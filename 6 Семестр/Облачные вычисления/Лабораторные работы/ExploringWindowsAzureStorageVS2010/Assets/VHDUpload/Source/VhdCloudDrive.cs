// ----------------------------------------------------------------------------------
// Microsoft Developer & Platform Evangelism
// 
// Copyright (c) Microsoft Corporation. All rights reserved.
// 
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES 
// OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
// ----------------------------------------------------------------------------------
// The example companies, organizations, products, domain names,
// e-mail addresses, logos, people, places, and events depicted
// herein are fictitious.  No association with any real company,
// organization, product, domain name, email address, logo, person,
// places, or events is intended or should be inferred.
// ----------------------------------------------------------------------------------

namespace VHDUpload
{
    using System;
    using System.IO;
    using System.Threading;
    using Microsoft.WindowsAzure;
    using Microsoft.WindowsAzure.StorageClient;

    public class VhdCloudDrive
    {
        private static readonly int PAGEBLOB_PAGE_SIZE = 512;
        private static readonly int MAX_PAGEBLOB_UPLOAD_SIZE = 4 * 1024 * 1024;

        private string fileName;
        private FileStream stream;
        private long fileOffset;
        private long blockOffset;
        private int blockLength;
        private byte[] buffer = new byte[MAX_PAGEBLOB_UPLOAD_SIZE];

        public VhdCloudDrive(string fileName)
        {
            this.fileName = fileName;
        }

        public void Upload(CloudStorageAccount account, string driveBlobUri)
        {
            FileInfo fileInfo = new FileInfo(this.fileName);

            Console.WriteLine("Uploading virtual hard disk (VHD) file: {0}", fileInfo.Name);
            Console.WriteLine();
            
            CloudBlobClient blobClient = account.CreateCloudBlobClient();
            blobClient.Timeout = new TimeSpan(0, 0, 180);

            // create page blob to provide backing storage for the drive - pad length to be multiple of 512 bytes
            CloudPageBlob driveBlob = blobClient.GetPageBlobReference(driveBlobUri);
            long paddedLength = (fileInfo.Length + PAGEBLOB_PAGE_SIZE - 1) & ~(PAGEBLOB_PAGE_SIZE - 1);
            Console.WriteLine("Creating Azure Drive");
            Console.WriteLine("  URI: {0}", driveBlob.Uri.AbsoluteUri);
            Console.WriteLine("  Size: {0:n3} MB", paddedLength / (1024 * 1024));
            Console.WriteLine();

            // first ensure that container exists and then create the blob
            CloudBlobContainer container = blobClient.GetContainerReference(driveBlob.Container.Name);
            container.CreateIfNotExist();
            driveBlob.Create(paddedLength);

            this.fileOffset = 0;
            this.blockLength = 0;

            Console.WriteLine("{0} - Uploading data...\r\n", DateTime.Now.ToLongTimeString());
            using (stream = fileInfo.OpenRead())
            {
                int blockNumber = 0;
                ProgressIndicator progress = new ProgressIndicator();

                while (Read())
                {
                    Console.Write("\r   Writing block {0,3} at offset: {1,16:n0}, size: {2,16:n1} KB", blockNumber, this.blockOffset, Convert.ToDecimal(this.blockLength) / 1024);
                    progress.Enable();
                    
                    driveBlob.WritePages(new MemoryStream(this.buffer, 0, this.blockLength, false), this.blockOffset);
                    Console.WriteLine("\r *");
                    progress.Disable();
                    blockNumber++;
                }

                Console.WriteLine();
                Console.WriteLine("{0} - Upload complete.", DateTime.Now.ToLongTimeString());
            }
        }

        private bool Read()
        {
            this.blockOffset = 0;
            this.blockLength = 0;

            while (this.blockLength < MAX_PAGEBLOB_UPLOAD_SIZE)
            {
                // read next page from stream
                int count = this.stream.Read(buffer, this.blockLength, PAGEBLOB_PAGE_SIZE);
                if (count == 0)
                {
                    break;
                }

                // clearing unused space at the end of the page, probably unnecessary
                Array.Clear(buffer, this.blockLength + count, PAGEBLOB_PAGE_SIZE - count);

                // scan page to determine if it contains only zeroes
                bool isAllZeroes = true;
                for (int pageOffset = 0; pageOffset < count; ++pageOffset)
                {
                    if (buffer[pageOffset + this.blockLength] != 0)
                    {
                        // non-zero page => add to block
                        if (this.blockLength == 0)
                        {
                            this.blockOffset = this.fileOffset;
                        }

                        this.blockLength += PAGEBLOB_PAGE_SIZE;
                        isAllZeroes = false;
                        break;
                    }
                }

                this.fileOffset += count;

                if (isAllZeroes && this.blockLength > 0)
                {
                    break;
                }
            }

            return this.blockLength > 0;
        }
    }
}

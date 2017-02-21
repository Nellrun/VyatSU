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
    using System.Reflection;
    using Microsoft.WindowsAzure;

    class Program
    {
        private const string DEVSTORAGE_ACCOUNT_NAME = "devstorage";
        private const string PARAMETER_FILE_PATH = "vhdFilePath";
        private const string PARAMETER_BLOB_URI = "blobUri";
        private const string PARAMETER_ACCOUNT_NAME = "accountName";
        private const string PARAMETER_ACCOUNT_KEY = "accountKey";

        static int Main(string[] args)
        {
            bool useDevelopmentStorage = (args.Length >= 3) && (args[2] == DEVSTORAGE_ACCOUNT_NAME);

            if ((useDevelopmentStorage && args.Length != 3) || (!useDevelopmentStorage && args.Length < 4))
            {
                Console.WriteLine();
                Console.WriteLine("Uploads a virtual hard disk (VHD) file to Windows Azure page blob service.");
                Console.WriteLine();
                Console.WriteLine(
                    "usage: {0} {1} {2} {3} {4}", 
                    Assembly.GetEntryAssembly().GetName().Name.ToUpper(), 
                    PARAMETER_FILE_PATH, 
                    PARAMETER_BLOB_URI, 
                    PARAMETER_ACCOUNT_NAME, 
                    PARAMETER_ACCOUNT_KEY);
                Console.WriteLine();
                Console.WriteLine("  {0,-12} - path to virtual hard disk (VHD) file", PARAMETER_FILE_PATH);
                Console.WriteLine("  {0,-12} - destination page blob relative URI (i.e. container/blobname)", PARAMETER_BLOB_URI);
                Console.WriteLine("  {0,-12} - storage account name (use {1} for storage emulator)", PARAMETER_ACCOUNT_NAME, DEVSTORAGE_ACCOUNT_NAME);
                Console.WriteLine("  {0,-12} - storage account primary key (omit for storage smulator)", PARAMETER_ACCOUNT_KEY);
                Console.WriteLine();
                return 1;
            }

            try
            {
                CloudStorageAccount account;
                if (useDevelopmentStorage)
                {
                    account = CloudStorageAccount.DevelopmentStorageAccount;
                }
                else
                {
                    string connectionString = String.Format("DefaultEndpointsProtocol=http;AccountName={0};AccountKey={1}", args[2], args[3]);
                    account = CloudStorageAccount.Parse(connectionString);
                }

                VhdCloudDrive drive = new VhdCloudDrive(args[0]);
                drive.Upload(account, args[1]);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error uploading virtual hard disk (VHD) file. {0}\n", e.ToString());
            }

            return 0;
        }
    }
}

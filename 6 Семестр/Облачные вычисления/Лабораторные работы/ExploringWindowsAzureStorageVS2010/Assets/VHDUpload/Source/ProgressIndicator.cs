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
    using System.Threading;

    internal class ProgressIndicator
    {
        private readonly char[] progressIndicator = { '-', '\\', '|', '/', '-' };
        private int progressState;
        private Timer timer;

        public ProgressIndicator()
        {
            Console.CursorVisible = false;

            this.timer = new Timer((state) =>
            {
                Console.Write("\r ");
                Console.Write(progressIndicator[progressState]);
                progressState = (progressState + 1) % progressIndicator.Length;
            }, null, Timeout.Infinite, 2000);
        }

        public void Enable()
        {
            this.timer.Change(0, 1000);
        }

        public void Disable()
        {
            this.timer.Change(Timeout.Infinite, 0);
        }
    }
}

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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Services.Client;
using Microsoft.WindowsAzure;

namespace RdChat_WebRole
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Save the text message to the message data context, and bind it to the list control.
        /// </summary>
        /// <param name="sender">Submit button</param>
        /// <param name="e">Button click event</param>
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            var statusMessage = String.Empty;

            try
            {
                var account = CloudStorageAccount.FromConfigurationSetting("DataConnectionString");
                var context = new MessageDataServiceContext(account.TableEndpoint.ToString(), account.Credentials);

                context.AddMessage(this.nameBox.Text, this.messageBox.Text);

                this.messageList.DataSource = context.Messages;
                this.messageList.DataBind();
            }
            catch (DataServiceRequestException ex)
            {
                statusMessage = "Unable to connect to the table service. Please check that the service is running.<br>"
                                 + ex.Message;
            }

            status.Text = statusMessage;
        }
    }
}
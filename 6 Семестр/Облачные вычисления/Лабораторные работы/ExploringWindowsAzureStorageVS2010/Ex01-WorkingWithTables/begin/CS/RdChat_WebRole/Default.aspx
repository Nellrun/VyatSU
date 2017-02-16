<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RdChat_WebRole._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Windows Azure Chat</title>    
    <style type="text/css">
        body { font-family: Verdana; font-size: 9pt; }
        h1 { font-size: 12pt; color: #555555; }
        li { list-style-type: none; }
        form { background-color: #eeeeff; width: 80%; margin: 0 auto; padding: 1em; border: solid 1px #333333; }
        #entryform, #messages { margin: 1em 0 }
        #entryform li span { float: left; width: 15%; color:#333333; margin-top:0.25em; }
        #entryform input[type="text"] { border: solid 1px #999999; }
        #messages { border: solid 1px #999999; }
        #messages li { padding: 0.5em; }
        .error { color: #ff0000; }
        .even { background-color: #ccccff; }
        .odd { background-color: #ffffff; font-style: italic; }        
        .messageBox { width: 73%; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <h1>Windows Azure Chat</h1>
        <ul id="entryform">
            <li><span>Your name</span><asp:TextBox ID="nameBox" runat="server" Text="Anonymous" /></li>
            <li><span>Message</span><asp:TextBox ID="messageBox" runat="server" CssClass="messageBox" /> <asp:Button ID="submitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" /></li>
        </ul>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div><asp:Label ID="status" runat="server" CssClass="error" /></div>
                <asp:ListView ID="messageList" runat="server">
                    <LayoutTemplate>
                        <ul id="messages">
                            <li ID="itemPlaceholder" runat="server" />
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li class="even">
                            <%# Eval("Name") %> said: <%# Eval("Body") %>
                        </li>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <li class="odd">
                            <%# Eval("Name") %> said: <%# Eval("Body") %>
                        </li>
                    </AlternatingItemTemplate>
                </asp:ListView>    
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="submitButton" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
</body>
</html>

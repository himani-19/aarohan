﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addCategory.aspx.cs" Inherits="Project_UI.Admin.addCategory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label">ADD CATEGORY</asp:Label>
        </div>
        <asp:Label ID="Label2" runat="server" Text="Label">Category Name: </asp:Label>
        <asp:TextBox ID="name" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Label">Category Description: </asp:Label>
        <asp:TextBox ID="desc" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Label">Category Image: </asp:Label>
        <asp:FileUpload ID="f1" runat="server" />
        <br />
        <asp:Button ID="submit_btn" runat="server" Text="Submit" OnClick="submit_btn_Click" />
        <br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </form>
</body>
</html>

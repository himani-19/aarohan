<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageUser.aspx.cs" Inherits="Project_UI.Admin.ManageUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>Manage Users</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content {
            display: flex;
            flex: 1;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .main-content {
            flex: 1;
            background-color: white;
            padding: 20px;
            margin-left: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
            <div class="main-content">
                <h2>Manage Users</h2>

    <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="UserID"
    OnRowEditing="GridViewUsers_RowEditing"
    OnRowUpdating="GridViewUsers_RowUpdating"
    OnRowCancelingEdit="GridViewUsers_RowCancelingEdit"
    OnRowDeleting="GridViewUsers_RowDeleting" OnRowCommand="GridViewUsers_RowCommand">
    <Columns>
        <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" ReadOnly="True" />

        <asp:TemplateField HeaderText="Full Name">
            <ItemTemplate>
                <%# Eval("FullName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtFullName" runat="server" Text='<%# Bind("FullName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <%# Eval("Email") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Phone Number">
            <ItemTemplate>
                <%# Eval("PhoneNumber") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Date of Birth">
            <ItemTemplate>
                <%# Eval("DateOfBirth") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtDateOfBirth" runat="server" Text='<%# Bind("DateOfBirth") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Gender">
            <ItemTemplate>
                <%# Eval("Gender") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlGender" runat="server" SelectedValue='<%# Bind("Gender") %>'>
                    <asp:ListItem Text="Select" Value="" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="State">
            <ItemTemplate>
                <%# Eval("State") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtState" runat="server" Text='<%# Bind("State") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="City">
            <ItemTemplate>
                <%# Eval("City") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Password">
            <ItemTemplate>
                <%# Eval("Password") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

       <asp:CommandField ShowEditButton="True" HeaderText="Edit" />
        <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
                <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" 
                    OnClientClick="return confirm('Are you sure you want to delete this user?');" 
                    CommandArgument='<%# Eval("UserID") %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>




                <br />

                <h3>User Feedback</h3>
                <asp:GridView ID="GridViewFeedback" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="FeedbackID"
    OnRowEditing="GridViewFeedback_RowEditing"
    OnRowUpdating="GridViewFeedback_RowUpdating"
    OnRowCancelingEdit="GridViewFeedback_RowCancelingEdit"
    OnRowDeleting="GridViewFeedback_RowDeleting" 
    OnRowCommand="GridViewFeedback_RowCommand">
    <Columns>
        <asp:BoundField DataField="FeedbackID" HeaderText="FeedbackID" SortExpression="FeedbackID" ReadOnly="True" />

        <asp:TemplateField HeaderText="AdvocateID">
            <ItemTemplate>
                <%# Eval("AdvocateID") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtAdvocateID" runat="server" Text='<%# Bind("AdvocateID") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="UserID">
            <ItemTemplate>
                <%# Eval("UserID") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtUserID" runat="server" Text='<%# Bind("UserID") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="FeedbackText">
            <ItemTemplate>
                <%# Eval("FeedbackText") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtFeedbackText" runat="server" Text='<%# Bind("FeedbackText") %>' TextMode="MultiLine" />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Rating">
            <ItemTemplate>
                <%# Eval("Rating") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlRating" runat="server" SelectedValue='<%# Bind("Rating") %>'>
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                    <asp:ListItem Text="5" Value="5" />
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="SubmittedOn">
            <ItemTemplate>
                <%# Eval("SubmittedOn") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtSubmittedOn" runat="server" Text='<%# Bind("SubmittedOn") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:CommandField ShowEditButton="True" HeaderText="Edit" />
        <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
                <asp:LinkButton ID="btnDelete1" runat="server" Text="Delete" CommandName="Delete" 
                    OnClientClick="return confirm('Are you sure you want to delete this user?');" 
                    CommandArgument='<%# Eval("UserID") %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

            </div>
        </div>
</asp:Content>

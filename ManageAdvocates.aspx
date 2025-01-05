<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageAdvocates.aspx.cs" Inherits="Project_UI.Admin.ManageAdvocates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Manage Advocates</title>
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

        .gridview-style {
            width: 100%;
            border-collapse: collapse;
        }

            .gridview-style th, .gridview-style td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .gridview-style th {
                background-color: #f2f2f2;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <div class="main-content">
            <h2>Manage Advocates</h2>
            <asp:SqlDataSource 
    ID="SqlDataSourceCategories" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnection %>" 
    SelectCommand="SELECT CategoryID, CategoryName FROM CaseCategory">
</asp:SqlDataSource>
            <asp:GridView ID="GridViewAdvocate" runat="server" AutoGenerateColumns="False"
                DataKeyNames="AdvocateID"
                OnRowEditing="GridViewAdvocate_RowEditing"
                OnRowUpdating="GridViewAdvocate_RowUpdating"
                OnRowCancelingEdit="GridViewAdvocate_RowCancelingEdit" OnRowDeleting="GridViewAdvocate_RowDeleting"
                OnRowCommand="GridViewAdvocate_RowCommand" OnRowDataBound="GridViewAdvocate_RowDataBound" CssClass="gridview-style">
               
                <Columns>
                    <asp:BoundField DataField="AdvocateID" HeaderText="AdvocateID" SortExpression="AdvocateID" ReadOnly="True" />

                    <asp:TemplateField HeaderText="Full Name">
                        <ItemTemplate>
                            <%# Eval("FullName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFullName" runat="server" Text='<%# Eval("FullName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <%# Eval("Email") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Phone Number">
                        <ItemTemplate>
                            <%# Eval("PhoneNumber") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhoneNumber" runat="server" Text='<%# Eval("PhoneNumber") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Gender">
                        <ItemTemplate>
                            <%# Eval("Gender") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlGender" runat="server">
                                <asp:ListItem Text="Select" Value="" />
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="State">
                        <ItemTemplate>
                            <%# Eval("State") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtState" runat="server" Text='<%# Eval("State") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <%# Eval("City") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCity" runat="server" Text='<%# Eval("City") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Years of Experience">
                        <ItemTemplate>
                            <%# Eval("YearsOfExperience") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtYearsOfExperience" runat="server" Text='<%# Eval("YearsOfExperience") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Area Of Specialization">
           
            <ItemTemplate>
                <%# Eval("CategoryName") %>
            </ItemTemplate>

            
            <EditItemTemplate>
               <asp:DropDownList ID="ddlCategory" runat="server" DataTextField="CategoryName" DataValueField="CategoryID">

</asp:DropDownList>

            </EditItemTemplate>
        </asp:TemplateField>


                    <asp:TemplateField HeaderText="Password">
                        <ItemTemplate>
                            <%# Eval("Password") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPassword" runat="server" Text='<%# Eval("Password") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" HeaderText="Edit" />
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="Delete"
                                OnClientClick="return confirm('Are you sure you want to delete this record?');"
                                CommandArgument='<%# Eval("AdvocateID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    
</asp:Content>

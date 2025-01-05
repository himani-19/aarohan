<%@ Page Title="Manage Case Categories and SubCategories" Language="C#" MasterPageFile="~/Admin/AdminSiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageCategoryAndSubCategory.aspx.cs" Inherits="Project_UI.Admin.ManageCategoryAndSubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Manage Categories and SubCategories</title>
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

        .view-button {
            color: #007bff;
            text-decoration: underline;
            cursor: pointer;
        }

        .subcat-gridview {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        .subcat-gridview th, .subcat-gridview td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .subcat-gridview th {
            background-color: #f2f2f2;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content">
        <h2>Manage Case Categories</h2>

        <!-- SqlDataSource for Categories -->
        <asp:SqlDataSource 
            ID="SqlDataSourceCategories" 
            runat="server" 
            ConnectionString="<%$ ConnectionStrings:DBConnection %>" 
            SelectCommand="SELECT CategoryID, CategoryName FROM CaseCategory">
        </asp:SqlDataSource>
     
<asp:Panel ID="panelAddCategory" runat="server" CssClass="form-section">
    <asp:TextBox ID="txtNewCategoryName" runat="server" CssClass="input-field" Placeholder="Enter Category Name"></asp:TextBox>
    <asp:TextBox ID="txtNewCategoryDesc" runat="server" CssClass="input-field"   Placeholder="Enter Description"></asp:TextBox>
    <asp:FileUpload ID="fileUploadCategoryImg" runat="server" CssClass="file-upload" />
    <asp:Button ID="btnAddCategory" runat="server" CssClass="btn" Text="Add Category" OnClick="btnAddCategory_Click" />
</asp:Panel>

        <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCategories_RowCommand"
    OnRowEditing="gvCategories_RowEditing" OnRowUpdating="gvCategories_RowUpdating"
    OnRowCancelingEdit="gvCategories_RowCancelingEdit" OnRowDeleting="gvCategories_RowDeleting" CssClass="grid" DataKeyNames="CategoryID">
    <Columns>
        <asp:TemplateField HeaderText="Category ID">
            <ItemTemplate>
                <%# Eval("CategoryID") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Category Name">
            <ItemTemplate>
                <%# Eval("CategoryName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtCategoryName" runat="server" Text='<%# Eval("CategoryName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>
       
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="btnViewSubcategories" runat="server" Text="View Subcategories" CommandName="ViewSubcategories" CommandArgument='<%# Eval("CategoryID") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="True" />
        <asp:CommandField ShowDeleteButton="True" />
    </Columns>
</asp:GridView>

        
        <asp:SqlDataSource 
    ID="SqlDataSourceSubcategories" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnection %>" 
    SelectCommand="SELECT * FROM SubCategory WHERE CategoryID = @CategoryID">
    <SelectParameters>
        <asp:Parameter Name="CategoryID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
       <asp:Panel ID="panelSubcategories" runat="server" Visible="false">
           <h3>Sub Categories</h3>
           <asp:Panel ID="panelAddSubcategory" runat="server" CssClass="form-section" Visible="false">
    <asp:TextBox ID="txtNewSubcategoryName" runat="server" CssClass="input-field" Placeholder="Enter Subcategory Name"></asp:TextBox>
    <asp:Button ID="btnAddSubcategory" runat="server" CssClass="btn" Text="Add Subcategory" OnClick="btnAddSubcategory_Click" />
</asp:Panel>
   <asp:GridView ID="gvSubcategories" runat="server" AutoGenerateColumns="False" 
    OnRowEditing="gvSubcategories_RowEditing" OnRowUpdating="gvSubcategories_RowUpdating" 
    OnRowCancelingEdit="gvSubcategories_RowCancelingEdit" OnRowDeleting="gvSubcategories_RowDeleting" 
    CssClass="grid" DataKeyNames="SubCategoryID">
    <Columns>
        <asp:BoundField DataField="SubCategoryID" HeaderText="SubCategoryID" SortExpression="SubCategoryID" ReadOnly="True" />
        

        <asp:TemplateField HeaderText="SubCategory Name">
            <ItemTemplate>
                <%# Eval("SubCategoryName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtSubCategoryName" runat="server" Text='<%# Eval("SubCategoryName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
                <asp:LinkButton ID="btnDeleteSubCategory" runat="server" Text="Delete" CommandName="Delete" 
                    CommandArgument='<%# Eval("SubCategoryID") %>' OnClientClick="return confirm('Are you sure you want to delete this subcategory?');" />
            </ItemTemplate>
        </asp:TemplateField>
       
    </Columns>
</asp:GridView>



</asp:Panel>


    </div>
</asp:Content>

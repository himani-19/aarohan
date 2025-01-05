using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI.Admin
{
    public partial class ManageCategoryAndSubCategory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategories();
            }
            else
            {
                if (ViewState["IsPanelVisible"] != null && (bool)ViewState["IsPanelVisible"])
                {
                    panelSubcategories.Visible = true;
                }
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string categoryName = txtNewCategoryName.Text.Trim();
            string categoryDesc = txtNewCategoryDesc.Text.Trim();
            string categoryImg = "";

            if (fileUploadCategoryImg.HasFile)
            {
                string fileExtension = Path.GetExtension(fileUploadCategoryImg.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                if (Array.Exists(allowedExtensions, ext => ext == fileExtension))
                {
                    string fileName = Guid.NewGuid() + fileExtension; 
                    string uploadPath = Server.MapPath("~/Images");
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    fileUploadCategoryImg.SaveAs(Path.Combine(uploadPath, fileName));
                    categoryImg = "~/Images" + fileName;
                }
               
            }
          

            if (!string.IsNullOrEmpty(categoryName) && !string.IsNullOrEmpty(categoryImg))
            {
                string query = "INSERT INTO CaseCategory (CategoryName, categoryDesc, categoryImg) VALUES (@CategoryName, @categoryDesc, @CategoryImg)";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                        cmd.Parameters.AddWithValue("@categoryDesc", categoryDesc);
                        cmd.Parameters.AddWithValue("@CategoryImg", categoryImg);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                txtNewCategoryName.Text = string.Empty;
                txtNewCategoryDesc.Text = string.Empty;
               

                BindCategories();
            }
        }


        protected void btnAddSubcategory_Click(object sender, EventArgs e)
        {
            if (ViewState["CurrentCategoryID"] != null)
            {
                int categoryID = Convert.ToInt32(ViewState["CurrentCategoryID"]);
                string subcategoryName = txtNewSubcategoryName.Text.Trim();

                if (!string.IsNullOrEmpty(subcategoryName))
                {
                    string query = "INSERT INTO CaseSubCategory (CategoryID, SubCategoryName) VALUES (@CategoryID, @SubCategoryName)";
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                            cmd.Parameters.AddWithValue("@SubCategoryName", subcategoryName);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    txtNewSubcategoryName.Text = string.Empty;

                    BindSubcategories(categoryID);
                }
            }
        }

        private void BindCategories()
        {
            string query = "SELECT CategoryID,CategoryName FROM CaseCategory";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    gvCategories.DataSource = cmd.ExecuteReader();
                    gvCategories.DataBind();
                }
            }
        }

        private void BindSubcategories(int categoryID)
        {
            ViewState["CurrentCategoryID"] = categoryID; 
            string query = "SELECT * FROM CaseSubCategory WHERE CategoryID = @CategoryID";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                    con.Open();
                    gvSubcategories.DataSource = cmd.ExecuteReader();
                    gvSubcategories.DataBind();
                }
            }

            panelSubcategories.Visible = true;
            panelAddSubcategory.Visible = true;
            ViewState["IsPanelVisible"] = true;
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewSubcategories")
            {
                int categoryID = Convert.ToInt32(e.CommandArgument);
                BindSubcategories(categoryID);
                panelSubcategories.Visible = true; 
            }
        }


        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            BindCategories();
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvCategories.Rows[e.RowIndex];
            int categoryID = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
            string categoryName = ((TextBox)row.FindControl("txtCategoryName")).Text;


            string query = "UPDATE CaseCategory SET CategoryName = @CategoryName WHERE CategoryID = @CategoryID";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
              int categoryID = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);

            string query = "DELETE FROM CaseCategory WHERE CategoryID = @CategoryID";
           using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
               
            }

            BindCategories();
        }

        protected void gvSubcategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSubcategories.EditIndex = e.NewEditIndex;
            int categoryID = Convert.ToInt32(gvCategories.SelectedDataKey.Value);
            BindSubcategories(categoryID);  
        }

        protected void gvSubcategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvSubcategories.Rows[e.RowIndex];
            int subcategoryID = Convert.ToInt32(gvSubcategories.DataKeys[e.RowIndex].Value);

            string subcategoryName = ((TextBox)row.FindControl("txtSubCategoryName")).Text;

            string query = "UPDATE CaseSubCategory SET SubCategoryName = @SubCategoryName WHERE SubCategoryID = @SubCategoryID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SubCategoryName", subcategoryName);
                    cmd.Parameters.AddWithValue("@SubCategoryID", subcategoryID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvSubcategories.EditIndex = -1;
            int categoryID = Convert.ToInt32(gvCategories.SelectedDataKey.Value);
            BindSubcategories(categoryID); 
        }

        protected void gvSubcategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSubcategories.EditIndex = -1;
            int categoryID = Convert.ToInt32(gvCategories.SelectedDataKey.Value);
            BindSubcategories(categoryID);  
        }

        protected void gvSubcategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
               
                int subcategoryID = Convert.ToInt32(gvSubcategories.DataKeys[e.RowIndex].Value);

                if (subcategoryID > 0)
                {
                  
                    string query = "DELETE FROM CaseSubCategory WHERE SubCategoryID = @SubCategoryID";
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@SubCategoryID", subcategoryID);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                   
                    if (gvCategories.SelectedDataKey != null)
                    {
                        int categoryID = Convert.ToInt32(gvCategories.SelectedDataKey.Value);
                        BindSubcategories(categoryID); 
                    }
                    else
                    {
                        
                        BindCategories();
                    }
                }
                else
                {
                    
                }
            }
            catch (Exception ex)
            {
                
                Response.Write("Error: " + ex.Message);
            }
        }


    }
}
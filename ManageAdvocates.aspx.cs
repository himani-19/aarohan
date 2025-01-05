using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI.Admin
{
    public partial class ManageAdvocates : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();

                string query = @"
              SELECT 
    Advocate.AdvocateID, 
    Advocate.FullName, 
    Advocate.Email, 
    Advocate.PhoneNumber, 
    Advocate.Gender, 
    Advocate.State, 
    Advocate.City, 
    Advocate.YearsOfExperience, 
    Advocate.Password,
    Advocate.AreaOfSpecialization, 
    c.CategoryID,  -- Ensure CategoryID is included
    c.CategoryName
FROM 
    AdvocateRegistration Advocate
LEFT JOIN 
    CaseCategory c
ON 
    Advocate.AreaOfSpecialization = c.CategoryID";

                // Fetch data into a DataTable
                SqlDataAdapter da = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the GridView
                GridViewAdvocate.DataSource = dt;
                GridViewAdvocate.DataBind();


            }
        }


        protected void GridViewAdvocate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewAdvocate.EditIndex = e.NewEditIndex;
            BindGridView();  // Rebind the gridview to show the edit form
        }

        protected void GridViewAdvocate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewAdvocate.EditIndex = -1;
            BindGridView();  // Exit Edit mode and rebind
        }

        protected void GridViewAdvocate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Get the AdvocateID of the row being updated
                int advocateID = Convert.ToInt32(GridViewAdvocate.DataKeys[e.RowIndex].Values["AdvocateID"]);

                // Find controls in the GridView row for each field
                TextBox txtFullName = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtFullName");
                TextBox txtEmail = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtEmail");
                TextBox txtPhoneNumber = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtPhoneNumber");
                DropDownList ddlGender = (DropDownList)GridViewAdvocate.Rows[e.RowIndex].FindControl("ddlGender");
                TextBox txtState = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtState");
                TextBox txtCity = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtCity");
                TextBox txtYearsOfExperience = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtYearsOfExperience");
                TextBox txtPassword = (TextBox)GridViewAdvocate.Rows[e.RowIndex].FindControl("txtPassword");
                DropDownList ddlCategory = (DropDownList)GridViewAdvocate.Rows[e.RowIndex].FindControl("ddlCategory");

                // Get the selected CategoryID from the DropDownList
                int selectedCategoryID = Convert.ToInt32(ddlCategory.SelectedValue);

                // Get the selected Gender from the DropDownList
                string selectedGender = ddlGender.SelectedValue;

                // SQL Update Query to update advocate details
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = @"
            UPDATE AdvocateRegistration
            SET 
                FullName = @FullName,
                Email = @Email,
                PhoneNumber = @PhoneNumber,
                Gender = @Gender,
                State = @State,
                City = @City,
                YearsOfExperience = @YearsOfExperience,
                Password = @Password,
                AreaOfSpecialization = @CategoryID
            WHERE AdvocateID = @AdvocateID";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@FullName", txtFullName.Text);
                    command.Parameters.AddWithValue("@Email", txtEmail.Text);
                    command.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text);
                    command.Parameters.AddWithValue("@Gender", selectedGender);
                    command.Parameters.AddWithValue("@State", txtState.Text);
                    command.Parameters.AddWithValue("@City", txtCity.Text);
                    command.Parameters.AddWithValue("@YearsOfExperience", txtYearsOfExperience.Text);
                    command.Parameters.AddWithValue("@Password", txtPassword.Text);
                    command.Parameters.AddWithValue("@CategoryID", selectedCategoryID);
                    command.Parameters.AddWithValue("@AdvocateID", advocateID);

                    command.ExecuteNonQuery();
                }

                // Show success message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SuccessMessage", "alert('Advocate details updated successfully.');", true);

                // Exit Edit Mode and rebind the GridView to reflect the changes
                GridViewAdvocate.EditIndex = -1;
                BindGridView();
            }
            catch (Exception ex)
            {
                // Show error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Error: " + ex.Message + "');", true);
            }
        }



        protected void GridViewAdvocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Handle Category dropdown
                DropDownList ddlCategory = (DropDownList)e.Row.FindControl("ddlCategory");
                if (e.Row.RowIndex == GridViewAdvocate.EditIndex)
                {
                    // Bind the categories to the DropDownList
                    ddlCategory.DataSource = SqlDataSourceCategories;
                    ddlCategory.DataTextField = "CategoryName";
                    ddlCategory.DataValueField = "CategoryID";
                    ddlCategory.DataBind();

                    // Set the selected category (from the database)
                    int categoryID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CategoryID"));
                    ddlCategory.SelectedValue = categoryID.ToString();
                }

                // Handle Gender dropdown
                DropDownList ddlGender = (DropDownList)e.Row.FindControl("ddlGender");
                if (e.Row.RowIndex == GridViewAdvocate.EditIndex)
                {
                    // Set the selected gender (from the database)
                    string gender = DataBinder.Eval(e.Row.DataItem, "Gender").ToString();

                    // Set selected value for gender dropdown
                    foreach (ListItem item in ddlGender.Items)
                    {
                        if (item.Value == gender)
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                }
            }
        }



        protected void GridViewAdvocate_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    // Retrieve the AdvocateID from the CommandArgument
                    int AdvocateID = Convert.ToInt32(e.CommandArgument);

                    // Perform the delete operation
                    DeleteAdvocate(AdvocateID);

                    // Optionally, you can rebind the GridView to reflect the changes
                    BindGridView();

                    // Show a success message after deletion
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Advocate deleted successfully');", true);
                }
                catch (Exception ex)
                {
                    // Show an error message if something goes wrong
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error deleting Advocate: " + ex.Message + "');", true);
                }
            }
        }
        protected void GridViewAdvocate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //int advocateID = Convert.ToInt32(GridViewAdvocate.DataKeys[e.RowIndex].Values["AdvocateID"]);

            //using (SqlConnection connection = new SqlConnection(connectionString))
            //{
            //    connection.Open();
            //    string query = "DELETE FROM AdvocateRegistration WHERE AdvocateID = @AdvocateID";

            //    using (SqlCommand command = new SqlCommand(query, connection))
            //    {
            //        command.Parameters.AddWithValue("@AdvocateID", advocateID);
            //        command.ExecuteNonQuery();
            //    }
            //}

            BindGridView();
        }
        private void DeleteAdvocate(int AdvocateID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM AdvocateRegistration WHERE AdvocateID = @AdvocateID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AdvocateID", AdvocateID);
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}

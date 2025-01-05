using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI.Admin
{
    public partial class ManageUser : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindGridViewFeedback();
            }

        }

        private void BindGridView()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT UserID, FullName, Email, PhoneNumber, DateOfBirth, Gender, State, City, Password FROM UserRegistration";
                SqlDataAdapter da = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewUsers.DataSource = dt;
                GridViewUsers.DataBind();
            }
        }

        protected void GridViewUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewUsers.EditIndex = e.NewEditIndex;
            BindGridView();  // Rebind the data to show the edit form
        }


        protected void GridViewUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Get the UserID from DataKey collection
                int userID = Convert.ToInt32(GridViewUsers.DataKeys[e.RowIndex].Values["UserID"]);

                // Get the updated values from the controls
                TextBox txtFullName = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtFullName");
                TextBox txtEmail = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtEmail");
                TextBox txtPhoneNumber = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtPhoneNumber");
                TextBox txtDateOfBirth = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtDateOfBirth");
                DropDownList ddlGender = (DropDownList)GridViewUsers.Rows[e.RowIndex].FindControl("ddlGender");
                TextBox txtState = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtState");
                TextBox txtCity = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtCity");
                TextBox txtPassword = (TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("txtPassword");

                // Make sure the controls are properly accessed
                if (txtFullName != null && txtEmail != null && txtPhoneNumber != null && txtDateOfBirth != null && ddlGender != null && txtState != null && txtCity != null && txtPassword != null)
                {
                    // Try to parse the DateOfBirth
                    DateTime dob;
                    if (DateTime.TryParse(txtDateOfBirth.Text, out dob))
                    {
                        // If valid date, update the user details in the database
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            connection.Open();
                            string query = "UPDATE UserRegistration SET FullName = @FullName, Email = @Email, PhoneNumber = @PhoneNumber, " +
                                           "DateOfBirth = @DateOfBirth, Gender = @Gender, State = @State, City = @City, Password = @Password WHERE UserID = @UserID";

                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                command.Parameters.AddWithValue("@FullName", txtFullName.Text);
                                command.Parameters.AddWithValue("@Email", txtEmail.Text);
                                command.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text);
                                command.Parameters.AddWithValue("@DateOfBirth", dob);  // Pass the valid DateTime
                                command.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                                command.Parameters.AddWithValue("@State", txtState.Text);
                                command.Parameters.AddWithValue("@City", txtCity.Text);
                                command.Parameters.AddWithValue("@Password", txtPassword.Text);
                                command.Parameters.AddWithValue("@UserID", userID);

                                int rowsAffected = command.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    // Display a success message using client script
                                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SuccessMessage", "alert('User updated successfully!');", true);
                                }
                                else
                                {
                                    // Display an error message
                                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Error updating user. Please try again.');", true);
                                }
                            }
                        }

                        // Exit Edit Mode and rebind the data
                        GridViewUsers.EditIndex = -1;
                        BindGridView();  // Rebind the GridView to reflect updated data
                    }
                    else
                    {
                        // Show an error message if the date is invalid
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Invalid Date of Birth format. Please enter a valid date.');", true);
                    }
                }
                else
                {
                    // Show error if any control is missing
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Some controls are missing. Please try again.');", true);
                }
            }
            catch (Exception ex)
            {
                // Log and show an error message if something goes wrong
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Error: " + ex.Message + "');", true);
            }
        }


        protected void GridViewUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewUsers.EditIndex = -1;
            BindGridView();  // Rebind the data to exit edit mode
        }



        protected void GridViewUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the UserID from the DataKey collection
                int userID = Convert.ToInt32(GridViewUsers.DataKeys[e.RowIndex].Values["UserID"]);
                string confirmMessage = "Are you sure you want to delete this user and all their feedback?";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ConfirmDeleteUser",
                    "if(confirm('" + confirmMessage + "')) { " +
                    "  __doPostBack('" + GridViewUsers.UniqueID + "', 'Delete$" + e.RowIndex + "');" +
                    "} else { return false; }", true);
                // Delete all feedback for the user first
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Delete feedback related to the user
                    string deleteFeedbackQuery = "DELETE FROM Feedback WHERE UserID = @UserID";

                    using (SqlCommand command = new SqlCommand(deleteFeedbackQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserID", userID);
                        command.ExecuteNonQuery();
                    }

                    // Now delete the user record
                    string deleteUserQuery = "DELETE FROM UserRegistration WHERE UserID = @UserID";

                    using (SqlCommand command = new SqlCommand(deleteUserQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserID", userID);
                        command.ExecuteNonQuery();
                    }
                }

                // Rebind the GridView to reflect the changes
                BindGridView();
                BindGridViewFeedback();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User deleted successfully');", true);
            }
            catch (Exception ex)
            {
                // Handle any errors (e.g., log or show a message)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error deleting user or feedback: " + ex.Message + "');", true);
            }
        }

        private void BindGridViewFeedback()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT FeedbackID, AdvocateID, UserID, FeedbackText, Rating, SubmittedOn FROM Feedback";
                SqlDataAdapter da = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewFeedback.DataSource = dt;
                GridViewFeedback.DataBind();
            }
        }

        protected void GridViewFeedback_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewFeedback.EditIndex = e.NewEditIndex;
            BindGridViewFeedback();
        }

        protected void GridViewFeedback_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Get the FeedbackID from DataKey collection
                int feedbackID = Convert.ToInt32(GridViewFeedback.DataKeys[e.RowIndex].Values["FeedbackID"]);

                // Get the updated values from the controls
                TextBox txtFeedbackText = (TextBox)GridViewFeedback.Rows[e.RowIndex].FindControl("txtFeedbackText");
                DropDownList ddlRating = (DropDownList)GridViewFeedback.Rows[e.RowIndex].FindControl("ddlRating");
                Label lblSubmittedOn = (Label)GridViewFeedback.Rows[e.RowIndex].FindControl("lblSubmittedOn"); // Just in case you want to display the submission date

                // Make sure the controls are properly accessed
                if (txtFeedbackText != null && ddlRating != null)
                {
                    // Update the feedback details in the database
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        string query = "UPDATE Feedback SET FeedbackText = @FeedbackText, Rating = @Rating WHERE FeedbackID = @FeedbackID";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@FeedbackText", txtFeedbackText.Text);
                            command.Parameters.AddWithValue("@Rating", ddlRating.SelectedValue);
                            command.Parameters.AddWithValue("@FeedbackID", feedbackID);

                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Display a success message using client script
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SuccessMessage", "alert('Feedback updated successfully!');", true);
                            }
                            else
                            {
                                // Display an error message if no rows are affected
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Error updating feedback. Please try again.');", true);
                            }
                        }
                    }

                    // Exit Edit Mode and rebind the data
                    GridViewFeedback.EditIndex = -1;
                    BindGridViewFeedback();  // Rebind the GridView to reflect updated data
                }
                else
                {
                    // Show error if any control is missing
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Some controls are missing. Please try again.');", true);
                }
            }
            catch (Exception ex)
            {
                // Log and show an error message if something goes wrong
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ErrorMessage", "alert('Error: " + ex.Message + "');", true);
            }
        }


        protected void GridViewFeedback_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewFeedback.EditIndex = -1;
            BindGridViewFeedback();
        }

        protected void GridViewFeedback_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int feedbackID = Convert.ToInt32(GridViewFeedback.DataKeys[e.RowIndex].Values["FeedbackID"]);
            string confirmMessage = "Are you sure you want to delete this feedback?";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ConfirmDeleteFeedback",
                "if(confirm('" + confirmMessage + "')) { " +
                "  __doPostBack('" + GridViewFeedback.UniqueID + "', 'Delete$" + e.RowIndex + "');" +
                "} else { return false; }", true);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "DELETE FROM Feedback WHERE FeedbackID = @FeedbackID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FeedbackID", feedbackID);
                    command.ExecuteNonQuery();
                }
            }

            BindGridViewFeedback();
        }
        private void DeleteFeedback(int feedbackID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM Feedback WHERE FeedbackID = @FeedbackID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FeedbackID", feedbackID);
                    command.ExecuteNonQuery();
                }
            }
        }
        private void DeleteUser(int UserID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM UserRegistration WHERE UserID = @UserID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", UserID);
                    command.ExecuteNonQuery();
                }
            }
        }
        protected void GridViewFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    // Retrieve the FeedbackID from the CommandArgument
                    int feedbackID = Convert.ToInt32(e.CommandArgument);

                    // Perform the delete operation
                    DeleteFeedback(feedbackID);

                    // Optionally, you can rebind the GridView to reflect the changes
                    BindGridViewFeedback();

                    // Show a success message after deletion
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Feedback deleted successfully');", true);
                }
                catch (Exception ex)
                {
                    // Show an error message if something goes wrong
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error deleting feedback: " + ex.Message + "');", true);
                }
            }
        }

        protected void GridViewUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    // Retrieve the FeedbackID from the CommandArgument
                    int UserID = Convert.ToInt32(e.CommandArgument);

                    // Perform the delete operation
                    DeleteUser(UserID);

                    // Optionally, you can rebind the GridView to reflect the changes
                    BindGridView();

                    // Show a success message after deletion
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User deleted successfully');", true);
                }
                catch (Exception ex)
                {
                    // Show an error message if something goes wrong
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error deleting User: " + ex.Message + "');", true);
                }
            }
        }
    }
}
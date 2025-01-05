using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Project_UI
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string emailOrPhone = EmailPhone.Text.Trim();
            string password = Password.Text.Trim();
            string userType = UserRadio.Checked ? "User" : (AdvocateRadio.Checked ? "Advocate" : (AdminRadio.Checked ? "Admin" : ""));

            if (string.IsNullOrEmpty(userType))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please select a user type.');", true);
                return;
            }

            int userId = GetUserId(emailOrPhone, password, userType);

            if (userId > 0)
            {
                // Set session variables
                Session["UserId"] = userId;
                Session["UserType"] = userType;

                // Redirect based on user type
                if (userType == "User" || userType == "Advocate")
                {
                    Response.Redirect("~/home.aspx");
                }
                else if (userType == "Admin")
                {
                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Invalid email/phone or password.');", true);
            }
        }

        private int GetUserId(string emailOrPhone, string password, string userType)
        {
            string tableName = userType == "Admin" ? "AdminLogin" : (userType == "Advocate" ? "AdvocateRegistration" : "UserRegistration");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query;
                    if (userType == "Admin")
                    {
                        query = $"SELECT ID FROM {tableName} WHERE Email = @Email AND Password = @Password";
                    }
                    else
                    {
                        query = $"SELECT UserID FROM {tableName} WHERE (Email = @Email OR PhoneNumber = @PhoneNumber) AND Password = @Password";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", emailOrPhone);
                        if (userType != "Admin")
                        {
                            cmd.Parameters.AddWithValue("@PhoneNumber", emailOrPhone);
                        }
                        cmd.Parameters.AddWithValue("@Password", password);

                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error during login: " + ex.Message);
                    return 0;
                }
            }
        }
    }
}

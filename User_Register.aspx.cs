using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Project_UI
{
    public partial class User_Register : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCities.Items.Clear();
            ddlCities.Items.Add(new ListItem("-- Select City --", ""));

            switch (ddlStates.SelectedValue)
            {
                case "Rajasthan":
                    ddlCities.Items.Add(new ListItem("Jaipur", "Jaipur"));
                    ddlCities.Items.Add(new ListItem("Jodhpur", "Jodhpur"));
                    ddlCities.Items.Add(new ListItem("Udaipur", "Udaipur"));
                    ddlCities.Items.Add(new ListItem("Bikaner", "Bikaner"));
                    ddlCities.Items.Add(new ListItem("Kota", "Kota"));
                    break;

                case "Maharashtra":
                    ddlCities.Items.Add(new ListItem("Mumbai", "Mumbai"));
                    ddlCities.Items.Add(new ListItem("Pune", "Pune"));
                    ddlCities.Items.Add(new ListItem("Nagpur", "Nagpur"));
                    ddlCities.Items.Add(new ListItem("Nashik", "Nashik"));
                    ddlCities.Items.Add(new ListItem("Aurangabad", "Aurangabad"));
                    break;

                case "Karnataka":
                    ddlCities.Items.Add(new ListItem("Bengaluru", "Bengaluru"));
                    ddlCities.Items.Add(new ListItem("Mysore", "Mysore"));
                    ddlCities.Items.Add(new ListItem("Hubli", "Hubli"));
                    ddlCities.Items.Add(new ListItem("Mangalore", "Mangalore"));
                    ddlCities.Items.Add(new ListItem("Belgaum", "Belgaum"));
                    break;

                case "Tamil Nadu":
                    ddlCities.Items.Add(new ListItem("Chennai", "Chennai"));
                    ddlCities.Items.Add(new ListItem("Coimbatore", "Coimbatore"));
                    ddlCities.Items.Add(new ListItem("Madurai", "Madurai"));
                    ddlCities.Items.Add(new ListItem("Salem", "Salem"));
                    ddlCities.Items.Add(new ListItem("Tiruchirappalli", "Tiruchirappalli"));
                    break;

                case "Punjab":
                    ddlCities.Items.Add(new ListItem("Amritsar", "Amritsar"));
                    ddlCities.Items.Add(new ListItem("Ludhiana", "Ludhiana"));
                    ddlCities.Items.Add(new ListItem("Jalandhar", "Jalandhar"));
                    ddlCities.Items.Add(new ListItem("Patiala", "Patiala"));
                    ddlCities.Items.Add(new ListItem("Bathinda", "Bathinda"));
                    break;
            }
        }

        private bool IsUserAlreadyRegistered(string email, string phoneNumber)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = "SELECT COUNT(*) FROM UserRegistration WHERE Email = @Email";

                // If phone number is not null or empty, include it in the check
                if (!string.IsNullOrEmpty(phoneNumber))
                {
                    query += " OR PhoneNumber = @PhoneNumber";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    // Only add the phone number parameter if it's not null or empty
                    if (!string.IsNullOrEmpty(phoneNumber))
                    {
                        cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    }

                    return (int)cmd.ExecuteScalar() > 0;
                }
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if (IsUserAlreadyRegistered(Email.Text, PhoneNumber.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User already registered with this email or phone number.');", true);
                return;
            }
            bool isValid = true;
            string errorMessage = "";

            string filePath = "";

            if (ProfilePicture.HasFile)
            {

                string fileExtension = Path.GetExtension(ProfilePicture.FileName).ToLower();
                int fileSize = ProfilePicture.PostedFile.ContentLength;

                string fileName = Path.GetFileName(ProfilePicture.FileName);
                filePath = "~/Uploads/" + fileName;

                ProfilePicture.SaveAs(Server.MapPath(filePath));

            }


            if (string.IsNullOrWhiteSpace(FullName.Text))
            {
                isValid = false;
                errorMessage += "Please enter your full name.\\n";
            }

            if (string.IsNullOrWhiteSpace(Email.Text))
            {
                isValid = false;
                errorMessage += "Please enter your email.\\n";
            }

            if (ddlStates.SelectedValue == "")
            {
                isValid = false;
                errorMessage += "Please select a state.\\n";
            }

            if (ddlCities.SelectedValue == "")
            {
                isValid = false;
                errorMessage += "Please select a city.\\n";
            }

            if (string.IsNullOrWhiteSpace(DateOfBirth.Text) || !DateTime.TryParse(DateOfBirth.Text, out DateTime dob))
            {
                isValid = false;
                errorMessage += "Please enter a valid date of birth.\\n";
            }

            if (string.IsNullOrWhiteSpace(Password.Text) || Password.Text != ConfirmPassword.Text)
            {
                isValid = false;
                errorMessage += "Passwords do not match.\\n";
            }


            if (!isValid)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{errorMessage}');", true);
                return;
            }


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"INSERT INTO UserRegistration 
                             (FullName, Email, PhoneNumber, DateOfBirth, Gender, State, City, ProfilePicture,Password,ConfirmPassword) 
                             VALUES 
                             (@FullName, @Email, @PhoneNumber, @DateOfBirth,@Gender,@State,@City,@ProfilePicture,@Password,@ConfirmPassword)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", FullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());
                    cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", ddlStates.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@City", ddlCities.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@Password", Password.Text);
                    cmd.Parameters.AddWithValue("@ConfirmPassword", ConfirmPassword.Text);
                    cmd.Parameters.AddWithValue("@DateOfBirth", DateOfBirth.Text);

                    cmd.Parameters.AddWithValue("@ProfilePicture", filePath); // Save the file path


                    cmd.ExecuteNonQuery();
                }
            }

            // Success message
            ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('Registration successful!');", true);
        }
    }
}


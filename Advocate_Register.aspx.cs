using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace Project_UI
{
    public partial class Advocate_Register : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCaseCategories();
            }
        }

        private void LoadCaseCategories()
        {
            string query = "SELECT CategoryID, CategoryName FROM CaseCategory";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        AreaOfSpecialization.DataSource = reader;
                        AreaOfSpecialization.DataValueField = "CategoryID";
                        AreaOfSpecialization.DataTextField = "CategoryName";
                        AreaOfSpecialization.DataBind();
                    }
                }
            }

            AreaOfSpecialization.Items.Insert(0, new ListItem("-- Select Specialization --", "-1"));
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


        protected void NextButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(FullName.Text) ||
                string.IsNullOrWhiteSpace(Email.Text) ||
                string.IsNullOrWhiteSpace(Password.Text) ||
                string.IsNullOrWhiteSpace(PhoneNumber.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill all fields correctly.');", true);
                return;
            }

            if (IsUserAlreadyRegistered(Email.Text, PhoneNumber.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User already registered with this email or phone number.');", true);
                return;
            }

            page1.Visible = false;
            page2.Visible = true;
        }
        protected void BackButton_Click(object sender, EventArgs e)
        {
            page1.Visible = true;  // Show page1
            page2.Visible = false; // Hide page2
        }

        private bool IsUserAlreadyRegistered(string email, string phoneNumber)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM AdvocateRegistration WHERE Email = @Email OR PhoneNumber = @PhoneNumber";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    return (int)cmd.ExecuteScalar() > 0;
                }
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            bool isValid = true;
            string errorMessage = "";
            string password = Password.Text;
            string confirmPassword = ConfirmPassword.Text;

            // File upload logic
            string bciCertificatePath = ""; // Declare the path variables outside the file upload block
            string photoPath = "";

            if (BCIEnrolmentCertificate.HasFile && Photograph.HasFile)
            {
                try
                {
                    // Save BCI Enrolment Certificate
                    string bciCertificateName = BCIEnrolmentCertificate.FileName;
                    bciCertificatePath = Server.MapPath("~/Uploads/" + bciCertificateName); // Assign path for BCI Enrolment Certificate
                    BCIEnrolmentCertificate.SaveAs(bciCertificatePath);

                    // Save Photograph
                    string photoName = Photograph.FileName;
                    photoPath = Server.MapPath("~/Uploads/" + photoName); // Assign path for Photograph
                    Photograph.SaveAs(photoPath);

                    // Check if both files are uploaded
                    if (string.IsNullOrEmpty(bciCertificatePath) || string.IsNullOrEmpty(photoPath))
                    {
                        isValid = false;
                        errorMessage += "File upload failed. Please ensure both files are selected.\\n";
                    }
                }
                catch (Exception ex)
                {
                    isValid = false;
                    errorMessage += $"File upload failed: {ex.Message}\\n";
                }
            }
            else
            {
                isValid = false;
                errorMessage += "Please upload both the BCI Enrolment Certificate and Photograph.\\n";
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

            if (ddlGender.SelectedValue == "")
            {
                isValid = false;
                errorMessage += "Please select a gender.\\n";
            }

            if (string.IsNullOrWhiteSpace(YearsOfExperience.Text))
            {
                isValid = false;
                errorMessage += "Please enter years of experience.\\n";
            }

            if (!int.TryParse(AreaOfSpecialization.SelectedValue, out int selectedSpecializationID) || selectedSpecializationID == -1)
            {
                isValid = false;
                errorMessage += "Please select a valid Area of Specialization.\\n";
            }

           
            if (!isValid)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{errorMessage}');", true);
                return;
            }

            
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"INSERT INTO AdvocateRegistration 
            (FullName, Email, PhoneNumber, State, City, Gender, Password, ConfirmPassword, YearsOfExperience, AreaOfSpecialization, BCIEnrolmentCertificate, Photograph) 
            VALUES 
            (@FullName, @Email, @PhoneNumber, @State, @City, @Gender, @Password, @ConfirmPassword, @YearsOfExperience, @AreaOfSpecialization, @BCIEnrolmentCertificate, @Photograph)";

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
                        cmd.Parameters.AddWithValue("@YearsOfExperience", YearsOfExperience.Text.Trim());
                        cmd.Parameters.AddWithValue("@AreaOfSpecialization", selectedSpecializationID);
                        cmd.Parameters.AddWithValue("@BCIEnrolmentCertificate", bciCertificatePath); 
                        cmd.Parameters.AddWithValue("@Photograph", photoPath); 

                        cmd.ExecuteNonQuery();
                    }
                }

               
                ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('You are successfully registered!');", true);
            }
            catch (Exception ex)
            {
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"alert('Error: {ex.Message}');", true);
            }
        }


    }
}

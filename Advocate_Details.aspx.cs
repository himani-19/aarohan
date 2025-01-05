using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace Project_UI
{
    public partial class Advocate_Details : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int advocateId;
                if (int.TryParse(Request.QueryString["advocateId"], out advocateId))
                {
                    LoadLawyerDetails(advocateId);
                    LoadFeedbacks(advocateId);

                    // Check if the user is logged in
                    if (Session["UserId"] != null)
                    {
                        pnlFeedbackForm.Visible = true; // Show feedback form
                    }
                    else
                    {
                        Response.Redirect("LoginPage.aspx");
                    }
                }
                else
                {
                    Response.Redirect("Advocate_List.aspx");
                }
            }
        }

        private void LoadLawyerDetails(int advocateId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
        SELECT 
            A.FullName, 
            A.State, 
            A.City, 
            A.YearsOfExperience, 
            C.CategoryName AS AreaOfSpecialization, 
            C.categoryDesc AS CaseDescription,
            A.Photograph, 
            A.PhoneNumber, 
            A.Email
        FROM 
            AdvocateRegistration A
        INNER JOIN 
            CaseCategory C ON A.AreaOfSpecialization = C.CategoryID
        WHERE 
            A.AdvocateID = @AdvocateId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AdvocateId", advocateId);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        lblFullName.Text = reader["FullName"].ToString();
                        lblLocation.Text = $"{reader["City"]}, {reader["State"]}";
                        lblExperience.Text = reader["YearsOfExperience"].ToString();
                        lblSpecialization.Text = reader["AreaOfSpecialization"].ToString();

                        string photoFile = reader["Photograph"]?.ToString() ?? string.Empty;
                        imgLawyerPhoto.ImageUrl = GetPhotoUrl(photoFile);

                        string phoneNumber = reader["PhoneNumber"].ToString();
                        string email = reader["Email"].ToString();

                        int feedbackCount;
                        decimal avgRating = GetAverageRatingAndFeedbackCount(advocateId, out feedbackCount);
                        lblRating.Text = GenerateStarRatingHtml((int)avgRating);
                        lblFeedbackCount.Text = $"({feedbackCount} feedbacks)";

                        btnPhone.HRef = "tel:" + phoneNumber;
                        btnEmail.HRef = "mailto:" + email;
                        lblCategoryDesc.Text = reader["CaseDescription"].ToString();
                    }
                }
            }
        }

        private void LoadFeedbacks(int advocateId)
        {
            StringBuilder feedbackHtml = new StringBuilder();
            string query = "SELECT FeedbackText, Rating, SubmittedOn FROM Feedback WHERE AdvocateId = @AdvocateId ORDER BY SubmittedOn DESC";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AdvocateId", advocateId);
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            string comment = reader["FeedbackText"].ToString();
                            int rating = Convert.ToInt32(reader["Rating"]);
                            DateTime feedbackDate = Convert.ToDateTime(reader["SubmittedOn"]);

                            feedbackHtml.Append("<div class='feedback-item'>");
                            feedbackHtml.Append($"<p>{feedbackDate:MMMM dd, yyyy}<br>{GenerateStarRatingHtml(rating)}<br>{comment}</p>");
                            feedbackHtml.Append("</div>");
                        }
                    }
                    else
                    {
                        feedbackHtml.Append("<p>No feedback available.</p>");
                    }
                }
            }

            feedbackContainer.InnerHtml = feedbackHtml.ToString();
        }

        private string GetPhotoUrl(string photograph)
        {
            string baseFolder = "~/Uploads/";
            string placeholderImage = "placeholder.jpg";

            if (string.IsNullOrEmpty(photograph))
            {
                return ResolveUrl(baseFolder + placeholderImage);
            }

            string sanitizedPhotoFile = Path.GetFileName(photograph);

            try
            {
                string fullPath = Server.MapPath(baseFolder + sanitizedPhotoFile);
                if (File.Exists(fullPath))
                {
                    return ResolveUrl(baseFolder + sanitizedPhotoFile);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPhotoUrl: {ex.Message}");
            }

            return ResolveUrl(baseFolder + placeholderImage);
        }

        private decimal GetAverageRatingAndFeedbackCount(int advocateId, out int feedbackCount)
        {
            decimal avgRating = 0;
            feedbackCount = 0;

            string query = "SELECT AVG(Rating) AS AverageRating, COUNT(Rating) AS FeedbackCount FROM Feedback WHERE AdvocateId = @AdvocateId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AdvocateId", advocateId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            avgRating = reader["AverageRating"] != DBNull.Value ? Convert.ToDecimal(reader["AverageRating"]) : 0;
                            feedbackCount = reader["FeedbackCount"] != DBNull.Value ? Convert.ToInt32(reader["FeedbackCount"]) : 0;
                        }
                    }
                }
            }

            return avgRating;
        }

        private string GenerateStarRatingHtml(int rating)
        {
            StringBuilder starHtml = new StringBuilder();

            for (int i = 0; i < rating; i++)
            {
                starHtml.Append("<i class='fas fa-star'></i>");
            }

            for (int i = rating; i < 5; i++)
            {
                starHtml.Append("<i class='far fa-star'></i>");
            }

            return starHtml.ToString();
        }

        private void AddFeedback(int advocateId, int userId, string feedbackText, int rating)
        {
            string query = "INSERT INTO Feedback (AdvocateID, UserID, FeedbackText, Rating, SubmittedOn) VALUES (@AdvocateID, @UserID, @FeedbackText, @Rating, @SubmittedOn)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AdvocateID", advocateId);
                    command.Parameters.AddWithValue("@UserID", userId);
                    command.Parameters.AddWithValue("@FeedbackText", feedbackText);
                    command.Parameters.AddWithValue("@Rating", rating);
                    command.Parameters.AddWithValue("@SubmittedOn", DateTime.Now);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void SubmitFeedback_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                int advocateId = Convert.ToInt32(Request.QueryString["advocateId"]);
                string feedbackText = txtFeedback.Text.Trim();
                int rating = Convert.ToInt32(ddlRating.SelectedValue);

                if (!string.IsNullOrEmpty(feedbackText) && rating > 0)
                {
                    AddFeedback(advocateId, userId, feedbackText, rating);
                    txtFeedback.Text = string.Empty;
                    ddlRating.SelectedIndex = 0;

                    LoadFeedbacks(advocateId);
                }
                txtFeedback.Text = "";
            }
            else
            {
                Response.Redirect("LoginPage.aspx");
            }
        }
    }
}

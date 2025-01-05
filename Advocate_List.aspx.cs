using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI
{
    public partial class Advocate_List : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdvocates();
            }
        }

        private void LoadAdvocates()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Updated query with JOIN
                string query = @"
            SELECT 
                A.AdvocateID, 
                A.FullName, 
                A.State, 
                A.City, 
                A.YearsOfExperience, 
                C.CategoryName AS AreaOfSpecialization, 
                A.Photograph
            FROM 
                AdvocateRegistration A
            INNER JOIN 
                CaseCategory C
            ON 
                A.AreaOfSpecialization = C.CategoryID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Bind the data to the Repeater
                    RepeaterAdvocates.DataSource = reader;
                    RepeaterAdvocates.DataBind();
                }
            }
        }

        protected string GetPhotoUrl(object photograph)
        {
            // Base folder for uploads
            string baseFolder = "~/Uploads/";
            string placeholderImage = "placeholder.jpg"; // Default placeholder image

            // Convert the 'photograph' object to a string, if null or empty, use the placeholder
            string photoFile = photograph != null ? photograph.ToString() : string.Empty;

            // If no photograph provided, return the placeholder image URL
            if (string.IsNullOrEmpty(photoFile))
            {
                return ResolveUrl(baseFolder + placeholderImage);
            }

            // Sanitize the file name to avoid invalid paths
            string sanitizedPhotoFile = Path.GetFileName(photoFile);

            try
            {
                // Construct the physical path on the server
                string fullPath = Server.MapPath(baseFolder + sanitizedPhotoFile);

                // Check if the file exists
                if (File.Exists(fullPath))
                {
                    return ResolveUrl(baseFolder + sanitizedPhotoFile);
                }
            }
            catch (Exception ex)
            {
                // Log the error for debugging purposes
                System.Diagnostics.Debug.WriteLine($"Error in GetPhotoUrl: {ex.Message}");
            }

            // If the file does not exist or an error occurs, return the placeholder image
            return ResolveUrl(baseFolder + placeholderImage);
        }
        // Example of how to get the average rating from the feedback table

        public decimal GetAverageRating(int advocateId)
        {
           
            decimal avgRating = 0;

            // SQL query to calculate average rating
            string query = "SELECT AVG(Rating) FROM Feedback WHERE AdvocateId = @AdvocateId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a command with the query and connection
                SqlCommand command = new SqlCommand(query, connection);

                // Add the parameter to the command to prevent SQL injection
                command.Parameters.AddWithValue("@AdvocateId", advocateId);

                try
                {
                    // Open connection
                    connection.Open();

                    // Execute the query and get the result
                    var result = command.ExecuteScalar(); // ExecuteScalar() returns the first column of the first row

                    if (result != DBNull.Value)
                    {
                        avgRating = Convert.ToDecimal(result);
                    }
                }
                catch (Exception ex)
                {
                    // Log error in case of exception
                    System.Diagnostics.Debug.WriteLine("Error in GetAverageRating: " + ex.Message);
                }
            }

            return avgRating;
        }

        public string GetStarRating(int advocateId)
        {
            // Get the average rating for the advocate (use the method defined above)
            decimal avgRating = GetAverageRating(advocateId);

            // Calculate full, half, and empty stars
            int fullStars = (int)avgRating;  // Whole number of stars
            bool halfStar = (avgRating - fullStars) >= 0.5m; // Check if half star is needed
            int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);  // Remaining empty stars

            // Build the HTML for stars
            StringBuilder starHtml = new StringBuilder();

            // Add full stars
            for (int i = 0; i < fullStars; i++)
            {
                starHtml.Append("<i class='fas fa-star'></i>");
            }

            // Add half star
            if (halfStar)
            {
                starHtml.Append("<i class='fas fa-star-half-alt'></i>");
            }

            // Add empty stars
            for (int i = 0; i < emptyStars; i++)
            {
                starHtml.Append("<i class='far fa-star'></i>");
            }

            return starHtml.ToString();
        }

    }
}

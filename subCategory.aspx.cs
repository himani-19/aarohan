
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
    public partial class subCategory : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string categoryId = Request.QueryString["id"]; // Retrieve category ID from the query string
                //if (string.IsNullOrEmpty(categoryId))
                //{
                //    Response.Write("Category ID not found.");
                //    return;
                //}



                string categoryId = Session["SelectedCategory"] as string;

                if (string.IsNullOrEmpty(categoryId))
                {
                    Response.Redirect("home.aspx");
                }

                // Load lawyers based on the selected category
                LoadLawyersByCategory(categoryId);
                LoadSubCategories(categoryId);
            }
        }
        private void LoadLawyersByCategory(string categoryId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // SQL query with JOIN to filter lawyers by category
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
                        A.AreaOfSpecialization = C.CategoryID
                    WHERE 
                        A.AreaOfSpecialization = @CategoryID";  // Filter by the selected category

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryID", categoryId); // Use category from session
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Bind the data to the Repeater control
                    RepeaterAdvocates.DataSource = reader;
                    RepeaterAdvocates.DataBind();
                }
            }
        }

        public void LoadSubCategories(string categoryId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT SubCategoryID, SubCategoryName FROM CaseSubCategory WHERE CategoryID = @CategoryID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        CategoryRepeater.DataSource = reader;
                        CategoryRepeater.DataBind();
                    }
                }
            }
        }
            protected string GetPhotoUrl(object photograph)
            {
                string baseFolder = "~/Uploads/";
                string placeholderImage = "placeholder.jpg"; // Default image if none exists

                string photoFile = photograph != null ? photograph.ToString() : string.Empty;

                if (string.IsNullOrEmpty(photoFile))
                {
                    return ResolveUrl(baseFolder + placeholderImage);
                }

                string sanitizedPhotoFile = Path.GetFileName(photoFile);

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

            public decimal GetAverageRating(int advocateId)
            {
                decimal avgRating = 0;
                string query = "SELECT AVG(Rating) FROM Feedback WHERE AdvocateId = @AdvocateId";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@AdvocateId", advocateId);

                    try
                    {
                        connection.Open();
                        var result = command.ExecuteScalar();
                        if (result != DBNull.Value)
                        {
                            avgRating = Convert.ToDecimal(result);
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Error in GetAverageRating: " + ex.Message);
                    }
                }

                return avgRating;
            }
        
        public string GetStarRating(int advocateId)
        {
            decimal avgRating = GetAverageRating(advocateId);

            int fullStars = (int)avgRating;
            bool halfStar = (avgRating - fullStars) >= 0.5m;
            int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

            StringBuilder starHtml = new StringBuilder();

            for (int i = 0; i < fullStars; i++)
            {
                starHtml.Append("<i class='fas fa-star'></i>");
            }

            if (halfStar)
            {
                starHtml.Append("<i class='fas fa-star-half-alt'></i>");
            }

            for (int i = 0; i < emptyStars; i++)
            {
                starHtml.Append("<i class='far fa-star'></i>");
            }

            return starHtml.ToString();
        }
    }
}

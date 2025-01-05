using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/LoginPage.aspx");
            //}

            if (!IsPostBack)
            {
                lblTotalUsers.Text = GetTotalUsers().ToString();
                lblTotalAdvocates.Text = GetTotalAdvocates().ToString();
                lblTotalCategories.Text = GetTotalCategories().ToString();
                lblTotalSubCategories.Text = GetTotalSubCategories().ToString();
            }
        }
        private int GetTotalUsers()
        {
            string query = "SELECT COUNT(*) FROM UserRegistration";
            return ExecuteCountQuery(query);
        }

        private int GetTotalAdvocates()
        {
            string query = "SELECT COUNT(*) FROM AdvocateRegistration";
            return ExecuteCountQuery(query);
        }

        private int GetTotalCategories()
        {
            string query = "SELECT COUNT(*) FROM CaseCategory";
            return ExecuteCountQuery(query);
        }

        private int GetTotalSubCategories()
        {
            string query = "SELECT COUNT(*) FROM CaseSubCategory";
            return ExecuteCountQuery(query);
        }

        private int ExecuteCountQuery(string query)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    conn.Close();
                    return count;
                }
            }
        }
    }
}
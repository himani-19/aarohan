using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_UI
{
    public partial class home : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadCaseCategory();
                loadLawyersInfo();
            }
        }

        public void loadCaseCategory()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM CaseCategory", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }

        public void loadLawyersInfo()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT DISTINCT t1.FullName, t1.Photograph, t2.categoryName " +
                    "FROM AdvocateRegistration t1 " +
                    "INNER JOIN CaseCategory t2 ON t1.AreaOfSpecialization = t2.categoryId", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Debug: Check if data is being fetched
                if (dt.Rows.Count == 0)
                {
                    Response.Write("<h1>No lawyers found in database.</h1>");
                }

                Repeater2.DataSource = dt;
                Repeater2.DataBind();
            }
        }
    }
}

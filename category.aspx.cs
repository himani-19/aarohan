
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Project_UI
{
    public partial class category : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection("Data Source = DESKTOP-RKLBJ1N;Initial Catalog=Project_DB_Sample;Integrated Security= True");

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM CaseCategory";
            cmd.ExecuteNonQuery();

            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            CategoryRepeater.DataSource = dt;
            CategoryRepeater.DataBind();
            conn.Close();


        }
    }
}

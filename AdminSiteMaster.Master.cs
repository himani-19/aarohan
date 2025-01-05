using System;
using System.Web;

namespace Project_UI.Admin
{
    public partial class AdminSiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Abandon();  
            Session.Clear();    


            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                var sessionCookie = new HttpCookie("ASP.NET_SessionId")
                {
                    Expires = DateTime.Now.AddDays(-1)
                };
                Response.Cookies.Add(sessionCookie);
            }

           
            Response.Redirect("../home.aspx");
        }
    }
}


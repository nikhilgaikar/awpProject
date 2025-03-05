using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace awpProject
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    lblUsername.Text = Session["Username"].ToString(); 
                }
                else
                {
                    lblUsername.Text = "Guest"; 
                }
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            
            Session.Clear(); 
            Session.Abandon();
            Response.Redirect("homepage.aspx");
        }


    }
}
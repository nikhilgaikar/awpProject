using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace awpProject
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    username.Text = Session["Username"].ToString(); // Set username from session
                }
                else
                {
                    username.Text = "Guest"; // Default text if no session exists
                }
            }
        }
    }
}
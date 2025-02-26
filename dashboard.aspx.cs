using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
                    username.Text = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("homepage.aspx"); 
                }

                LoadTaskCounts();
            }
        }

        private void LoadTaskCounts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @" SELECT 
                (SELECT COUNT(*) FROM Tasks WHERE Status = 'Overdue' AND UserID = @UserID) AS OverdueCount,
                (SELECT COUNT(*) FROM Tasks WHERE Status = 'Pending' AND UserID = @UserID) AS PendingCount,
                (SELECT COUNT(*) FROM Tasks WHERE Status = 'Completed' AND UserID = @UserID) AS CompletedCount;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Get the logged-in user's ID (assuming it's stored in Session)
                    int userId = Convert.ToInt32(Session["UserID"]);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Overdue.Text = reader["OverdueCount"].ToString();
                        Pending.Text = reader["PendingCount"].ToString();
                        Completed.Text = reader["CompletedCount"].ToString();
                    }
                    reader.Close();
                }
            }

        }

    }
}
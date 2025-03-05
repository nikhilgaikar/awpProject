using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
                LoadRecentStreaks(); 
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

        private void LoadRecentStreaks()
        {
            string userId = Session["UserID"]?.ToString();
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("homepage.aspx");
                return;
            }

            string query = @"SELECT TOP 3 StreakName, Description, GoalDate, StreakCount, 
             DATEDIFF(DAY, GETDATE(), GoalDate) AS DaysLeft, LastUpdated 
             FROM Streaks WHERE UserID = @UserID ORDER BY LastUpdated DESC"; 

            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            rptRecentStreaks.DataSource = dt;
            rptRecentStreaks.DataBind();
        }
    }
}

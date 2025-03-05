using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace awpProject
{
    public partial class streaks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                LoadStreaks();
            }
        }

        private void LoadStreaks()
        {
            string userId = Session["UserID"]?.ToString();
           

            string query = @"
                SELECT StreakID, StreakName, Description, GoalDate, StreakCount, 
                       DATEDIFF(DAY, GETDATE(), GoalDate) AS DaysLeft
                FROM Streaks 
                WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    rptStreaks.DataSource = reader;
                    rptStreaks.DataBind();
                }
            }
        }

        protected void btnCreateStreak_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"]?.ToString();
            

            string query = @"
                INSERT INTO Streaks (UserID, StreakName, Description, GoalDate, StreakCount, LastUpdated)
                VALUES (@UserID, @StreakName, @Description, @GoalDate, 0, NULL)";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@StreakName", streakName.Text);
                    cmd.Parameters.AddWithValue("@Description", streakDescription.Text);
                    cmd.Parameters.AddWithValue("@GoalDate", goalCompletionDate.Text);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadStreaks();
        }

        protected void btnContribute_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"]?.ToString();
            

            Button btn = (Button)sender;
            int streakId = Convert.ToInt32(btn.CommandArgument);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                conn.Open();

                // Check if the last contribution was today
                string checkQuery = @"SELECT * FROM Streaks WHERE StreakID = @StreakID AND UserID = @UserID 
                                    AND DATEDIFF(DAY, LastUpdated, GETDATE()) = 0";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@StreakID", streakId);
                    checkCmd.Parameters.AddWithValue("@UserID", userId);

                    object result = checkCmd.ExecuteScalar(); // Will return some value if a row exists

                    if (result != null) // If a row exists, LastUpdated is today
                    {
                        return; // Already updated today
                    }
                }


                // Update streak count and last updated date
                string updateQuery = "UPDATE Streaks SET StreakCount = StreakCount + 1, LastUpdated = CONVERT(DATE, GETDATE()) WHERE StreakID = @StreakID AND UserID = @UserID";
                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                {
                    updateCmd.Parameters.AddWithValue("@StreakID", streakId);
                    updateCmd.Parameters.AddWithValue("@UserID", userId);
                    updateCmd.ExecuteNonQuery();
                }
            }

            LoadStreaks();
        }

        protected void btnDeleteStreak_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"]?.ToString();
            

            Button btn = (Button)sender;
            int streakId = Convert.ToInt32(btn.CommandArgument);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                conn.Open();


                
                string deleteQuery = "DELETE FROM Streaks WHERE StreakID = @StreakID AND UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@StreakID", streakId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadStreaks();
        }
    }
}

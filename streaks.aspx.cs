using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace awpProject
{
    public partial class streaks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStreaks();
            }
        }

        private void LoadStreaks()
        {
            string userId = Session["UserID"]?.ToString();
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("login.aspx"); // Redirect if not logged in
                return;
            }

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
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("login.aspx");
                return;
            }

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
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("login.aspx");
                return;
            }

            int streakId = Convert.ToInt32((sender as System.Web.UI.WebControls.Button).CommandArgument);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Check last update date to prevent duplicate contributions in one day
                    string checkQuery = "SELECT LastUpdated FROM Streaks WHERE StreakID = @StreakID AND UserID = @UserID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn, transaction))
                    {
                        checkCmd.Parameters.AddWithValue("@StreakID", streakId);
                        checkCmd.Parameters.AddWithValue("@UserID", userId);
                        object lastUpdated = checkCmd.ExecuteScalar();

                        if (lastUpdated != DBNull.Value && Convert.ToDateTime(lastUpdated).Date == DateTime.Today)
                        {
                            transaction.Rollback();
                            return; // Already contributed today
                        }
                    }

                    // Update streak count and last updated date
                    string updateQuery = "UPDATE Streaks SET StreakCount = StreakCount + 1, LastUpdated = GETDATE() WHERE StreakID = @StreakID AND UserID = @UserID";
                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn, transaction))
                    {
                        updateCmd.Parameters.AddWithValue("@StreakID", streakId);
                        updateCmd.Parameters.AddWithValue("@UserID", userId);
                        updateCmd.ExecuteNonQuery();
                    }

                    // Insert into streak logs
                    string insertLogQuery = "INSERT INTO StreakLogs (StreakID, UserID, ContributionDate) VALUES (@StreakID, @UserID, GETDATE())";
                    using (SqlCommand logCmd = new SqlCommand(insertLogQuery, conn, transaction))
                    {
                        logCmd.Parameters.AddWithValue("@StreakID", streakId);
                        logCmd.Parameters.AddWithValue("@UserID", userId);
                        logCmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch
                {
                    transaction.Rollback();
                }
            }

            LoadStreaks();
        }

        protected void btnDeleteStreak_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"]?.ToString();
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("login.aspx");
                return;
            }

            int streakId = Convert.ToInt32((sender as System.Web.UI.WebControls.Button).CommandArgument);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Delete streak logs first
                    string deleteLogsQuery = "DELETE FROM StreakLogs WHERE StreakID = @StreakID";
                    using (SqlCommand cmd = new SqlCommand(deleteLogsQuery, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@StreakID", streakId);
                        cmd.ExecuteNonQuery();
                    }

                    // Delete streak
                    string deleteStreakQuery = "DELETE FROM Streaks WHERE StreakID = @StreakID AND UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(deleteStreakQuery, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@StreakID", streakId);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch
                {
                    transaction.Rollback();
                }
            }

            LoadStreaks();
        }
    }
}

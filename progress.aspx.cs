using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace awpProject
{
    public partial class progress : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                
                LoadProgressData();
            }
        }

        private void LoadProgressData()
        {
            string connString = ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString;
            string userId = Session["UserID"] as string;

           

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                
                int totalTasks = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE UserID = {userId}");
                int completedTasks = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE UserID = {userId} AND Status = 'Completed'");

                
                int totalCollege = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'College' AND UserID = {userId}");
                int completedCollege = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'College' AND Status = 'Completed' AND UserID = {userId}");

                int totalWork = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'Work' AND UserID = {userId}");
                int completedWork = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'Work' AND Status = 'Completed' AND UserID = {userId}");

                int totalPersonal = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'Personal' AND UserID = {userId}");
                int completedPersonal = GetTaskCount(conn, $"SELECT COUNT(*) FROM Tasks WHERE Category = 'Personal' AND Status = 'Completed' AND UserID = {userId}");

               
                int overallProgress = (totalTasks > 0) ? (completedTasks * 100) / totalTasks : 0;
                int collegeProgress = (totalCollege > 0) ? (completedCollege * 100) / totalCollege : 0;
                int workProgress = (totalWork > 0) ? (completedWork * 100) / totalWork : 0;
                int personalProgress = (totalPersonal > 0) ? (completedPersonal * 100) / totalPersonal : 0;

                
                lblOverallProgress.Text = overallProgress + "%";
                lblCollegeProgress.Text = collegeProgress + "%";
                lblWorkProgress.Text = workProgress + "%";
                lblPersonalProgress.Text = personalProgress + "%";

                
                progressOverall.Attributes["style"] = $"width: {overallProgress}%";
                progressCollege.Attributes["style"] = $"width: {collegeProgress}%";
                progressWork.Attributes["style"] = $"width: {workProgress}%";
                progressPersonal.Attributes["style"] = $"width: {personalProgress}%";
            }
        }

        private int GetTaskCount(SqlConnection conn, string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                return Convert.ToInt32(cmd.ExecuteScalar() ?? 0);
            }
        }
    }
}

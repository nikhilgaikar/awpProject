using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace awpProject
{
    public partial class tasks : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTasks();
            }
        }

        private void LoadTasks()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TaskID, TaskName, Description, Category, Priority, FORMAT(DueDate, 'dd/MM/yyyy') AS DueDate, Status FROM Tasks WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                GridView.DataSource = dt;
                GridView.DataBind();
            }
        }

        protected void AddTask_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Tasks (TaskName, Description, DueDate, Category, Priority, Status, UserID, CreatedAt, IsCompleted) " +
                               "VALUES (@TaskName, @Description, @DueDate, @Category, @Priority, 'Pending', @UserID, GETDATE(), 0)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TaskName", taskName.Text);
                cmd.Parameters.AddWithValue("@Description", taskDescription.Text);
                cmd.Parameters.AddWithValue("@DueDate", dueDate.Text);
                cmd.Parameters.AddWithValue("@Category", category.Text);
                cmd.Parameters.AddWithValue("@Priority", priority.SelectedValue);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ClearFields();
            LoadTasks();
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView.EditIndex = e.NewEditIndex;
            LoadTasks();
        }

        protected void GridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView.EditIndex = -1;
            LoadTasks();
        }

        protected void GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView.Rows[e.RowIndex];
            int taskId = Convert.ToInt32(GridView.DataKeys[e.RowIndex].Values[0]);

            string name = (row.FindControl("taskNameEdit") as TextBox).Text;
            string description = (row.FindControl("taskDescriptionEdit") as TextBox).Text;
            string category = (row.FindControl("categoryEdit") as TextBox).Text;
            string priority = (row.FindControl("priorityEdit") as DropDownList).SelectedValue;
            string dueDate = (row.FindControl("dueDateEdit") as TextBox).Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Tasks SET TaskName = @TaskName, Description = @Description, Category = @Category, " +
                               "Priority = @Priority, DueDate = @DueDate WHERE TaskID = @TaskID AND UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TaskName", name);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Priority", priority);
                cmd.Parameters.AddWithValue("@DueDate", dueDate);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            GridView.EditIndex = -1;
            LoadTasks();
        }

        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int taskId = Convert.ToInt32(GridView.DataKeys[e.RowIndex].Values[0]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Tasks WHERE TaskID = @TaskID AND UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadTasks();
        }

        private void ClearFields()
        {
            taskName.Text = "";
            taskDescription.Text = "";
            category.Text = "";
            dueDate.Text = "";
        }

        
    }
}

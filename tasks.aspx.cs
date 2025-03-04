using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
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
                UpdateOverdueTasks(); // Mark overdue tasks
                LoadTasks();
            }
        }

        private void UpdateOverdueTasks()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Tasks SET Status = 'Overdue' WHERE Status = 'Pending' AND DueDate < CAST(GETDATE() AS DATE)";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void applyFilterButton_Click(object sender, EventArgs e)
        {
            string category = categoryFilter.SelectedValue;
            string priority = priorityFilter.SelectedValue;
            string status = statusFilter.SelectedValue;

            LoadTasks(category, priority, status);
        }
        private void LoadTasks(string category = "All", string priority = "All", string status = "All")
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Base Query
                string query = "SELECT TaskID, TaskName, Description, Category, Priority, FORMAT(DueDate, 'dd/MM/yyyy') AS DueDate, Status FROM Tasks WHERE UserID = @UserID";

                // Dynamically add filters
                if (category != "All")
                    query += " AND Category = @Category";
                if (priority != "All")
                    query += " AND Priority = @Priority";
                if (status != "All")
                    query += " AND Status = @Status";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                // Add filter parameters only if a filter is applied
                if (category != "All")
                    cmd.Parameters.AddWithValue("@Category", category);
                if (priority != "All")
                    cmd.Parameters.AddWithValue("@Priority", priority);
                if (status != "All")
                    cmd.Parameters.AddWithValue("@Status", status);

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
                string query = "INSERT INTO Tasks (TaskName, Description, DueDate, Category, Priority, Status, UserID, CreatedAt) " +
                               "VALUES (@TaskName, @Description, @DueDate, @Category, @Priority, 'Pending', @UserID, GETDATE())";

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
            UpdateOverdueTasks();
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
            string category = (row.FindControl("categoryEdit") as DropDownList).SelectedValue;
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
            UpdateOverdueTasks();
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

        protected void MarkAsCompleted(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int taskId = Convert.ToInt32(GridView.DataKeys[row.RowIndex].Values[0]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Tasks SET Status = 'Completed' WHERE TaskID = @TaskID AND UserID = @UserID";
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
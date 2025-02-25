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
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure no cached session persists after logout
            Response.Cache.SetNoStore();
        }

        protected void SignupBtn_Click(object sender, EventArgs e)
        {
            string user = username.Text.Trim();
            string mail = email.Text.Trim();
            string pass = password.Text.Trim(); // Hashing should be applied in production

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagementDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if username already exists
                string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                SqlCommand checkUserCmd = new SqlCommand(checkUserQuery, conn);
                checkUserCmd.Parameters.AddWithValue("@Username", user);
                int userExists = (int)checkUserCmd.ExecuteScalar();

                if (userExists > 0)
                {
                    // Username already taken
                    Response.Write("<script>alert('Username already exists! Choose another.');</script>");
                    return;
                }

                // Insert new user
                string query = "INSERT INTO Users (Username, Email, Password) VALUES (@Username, @Email, @Password)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", user);
                cmd.Parameters.AddWithValue("@Email", mail);
                cmd.Parameters.AddWithValue("@Password", pass); // Store hashed password in real cases

                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    // Store session for logged-in user
                    Session["Username"] = user;
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Signup failed. Try again!');</script>");
                }
            }

        }

    }
}
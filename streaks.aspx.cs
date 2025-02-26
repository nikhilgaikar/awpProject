using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace awpProject
{
    public partial class streaks : System.Web.UI.Page
    {
        public class Streak
        {
            public int StreakID { get; set; }
            public string StreakName { get; set; }
            public string Description { get; set; }
            public string GoalDate { get; set; }
            public int StreakCount { get; set; }
            public DateTime LastUpdated { get; set; } // Track last update time
        }

        // Temporary in-memory list (No Database)
        private static List<Streak> streakList = new List<Streak>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindStreaks();
            }
        }

        protected void btnCreateStreak_Click(object sender, EventArgs e)
        {
            // Get Streak Data
            string name = streakName.Text;
            string description = streakDescription.Text;
            string goalDate = goalCompletionDate.Text;

            // Create new streak entry
            Streak newStreak = new Streak
            {
                StreakID = streakList.Count + 1,
                StreakName = name,
                Description = description,
                GoalDate = goalDate,
                StreakCount = 0,
                LastUpdated = DateTime.Now
            };

            // Add to list & Bind
            streakList.Add(newStreak);
            //BindStreaks();
        }

        protected void btnContribute_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int streakID = Convert.ToInt32(btn.CommandArgument);

            // Find and update streak
            var streak = streakList.FirstOrDefault(s => s.StreakID == streakID);
            if (streak != null)
            {
                // Check if they missed a day
                if ((DateTime.Now - streak.LastUpdated).TotalHours > 24)
                {
                    streak.StreakCount = 0; // Reset streak
                }

                streak.StreakCount++; // Increase streak count
                streak.LastUpdated = DateTime.Now; // Update last contributed time
            }

            //BindStreaks();
        }

        //private void BindStreaks()
        //{
        //    lvStreaks.DataSource = streakList;
        //    lvStreaks.DataBind();
        //}
    }
}
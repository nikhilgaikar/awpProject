<%@ Page Title="Streaks Tracker" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="streaks.aspx.cs" Inherits="awpProject.streaks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Streaks Tracker</h2>

        <!-- Streak Input Form -->
        <div class="card mb-4 customcard">
            <div class="card-header">
                <span>Create New Streak</span>
                <button type="button" class="btn btn-sm btn-outline-secondary float-end" onclick="minimize()">Minimize</button>
            </div>
            <script>
                function minimize() {
                    var form = document.getElementById("streakForm");
                    form.style.display = (form.style.display === "none") ? "block" : "none";
                }
            </script>
            <div class="card-body" id="streakForm">
                <div class="row g-2">
                    <div class="col-md-4">
                        <label class="form-label">Streak Name</label>
                        <asp:TextBox ID="streakName" CssClass="form-control" placeholder="Enter task name" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="streakDescription" CssClass="form-control" placeholder="Enter task description" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">Goal Completion Date</label>
                        <asp:TextBox ID="goalCompletionDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                    <asp:Button ID="btnCreateStreak" CssClass="btn btn-primary" runat="server" Text="Create Streak" OnClick="btnCreateStreak_Click"/>
                    </div>
                </div>  
            </div>
        </div>

        <!-- Streaks Display -->
        <div class="card customcard">
    <div class="card-header">Your Streaks</div>
        <div class="card-body">
            <div class="row d-flex flex-wrap"> <!-- Added Flexbox -->
                <asp:Repeater ID="rptStreaks" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 d-flex"> <!-- Ensures proper spacing and responsiveness -->
                            <div class="streak-card p-3">
                            
                                <h5><%# Eval("StreakName") %></h5>
                                <p><%# Eval("Description") %></p>
                                <p><strong>Goal Completion:</strong> <%# Eval("GoalDate", "{0:yyyy-MM-dd}") %></p>
                                <p><strong>Streak:</strong> 🔥 <span class="streak-count"><%# Eval("StreakCount") %></span> Days</p>
                                <p><strong>Days Left:</strong> <%# Eval("DaysLeft") %> </p>

                                <div class="d-flex gap-2">
                                    <asp:Button ID="btnContribute" CssClass="btn btn-success w-100" runat="server" Text="Contribute" 
                                        CommandArgument='<%# Eval("StreakID") %>' OnClick="btnContribute_Click"/>

                                    <asp:Button ID="btnDelete" CssClass="btn btn-danger w-100" runat="server" Text="Delete" 
                                        CommandArgument='<%# Eval("StreakID") %>' OnClick="btnDeleteStreak_Click"/>
                                </div>
                            </div>   
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    </div>
    <style>
      .streak-card {
        border: 1px solid #ddd; /* Light gray border */
        border-radius: 8px; /* Slightly rounded corners */
        padding: 15px; /* Space inside the card */
        background: white; /* Keep the background white */
        margin-bottom: 15px; /* Adds space below each card */
        }
    </style>

</asp:Content>



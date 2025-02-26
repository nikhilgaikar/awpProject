<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="streaks.aspx.cs" Inherits="awpProject.streaks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Streaks Tracker</h2>

        <!-- Streak Input Form -->
        <div class="card mb-4 customcard">
            <div class="card-header">
                <span>Create New Streak</span>
                <button type="button" class="btn btn-sm btn-outline-secondary float-end" onclick="toggleStreakForm()">Minimize</button>
            </div>
            <div class="card-body" id="streakForm">
                <div class="mb-3">
                    <label class="form-label">Streak Name</label>
                    <asp:TextBox ID="streakName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="streakDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Goal Completion Date</label>
                    <asp:TextBox ID="goalCompletionDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="btnCreateStreak" CssClass="btn btn-primary" runat="server" Text="Create Streak"/>
            </div>
        </div>

        <!-- Streaks Display -->
        <div class="card customcard">
            <div class="card-header">Your Streaks</div>
            <div class="card-body">
                <div id="streaksContainer" class="row">
                    <!-- Hardcoded Streaks (Test Data) -->
                    <div class="col-md-4">
                        <div class="streak-card">
                            <h5>Workout</h5>
                            <p>Daily morning exercise</p>
                            <p><strong>Goal Completion:</strong> 2025-03-10</p>
                            <p><strong>Streak:</strong> 🔥 <span class="streak-count">5</span> Days</p>
                            <button class="btn btn-success" onclick="increaseStreak(this)">Contribute</button>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="streak-card">
                            <h5>Reading</h5>
                            <p>Read 10 pages of a book</p>
                            <p><strong>Goal Completion:</strong> 2025-03-15</p>
                            <p><strong>Streak:</strong> 🔥 <span class="streak-count">12</span> Days</p>
                            <button class="btn btn-success" onclick="increaseStreak(this)">Contribute</button>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="streak-card">
                            <h5>Learning Programming</h5>
                            <p>Practice coding for 1 hour</p>
                            <p><strong>Goal Completion:</strong> 2025-04-01</p>
                            <p><strong>Streak:</strong> 🔥 <span class="streak-count">7</span> Days</p>
                            <button class="btn btn-success" onclick="increaseStreak(this)">Contribute</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Custom Styling */
        .customcard {
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }
        .streak-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .btn-success {
            width: 100%;
        }
    </style>

    <script>
        function toggleStreakForm() {
            var form = document.getElementById("streakForm");
            form.style.display = (form.style.display === "none") ? "block" : "none";
        }

        function increaseStreak(button) {
            var streakCountElement = button.parentElement.querySelector(".streak-count");
            var currentStreak = parseInt(streakCountElement.innerText);
            streakCountElement.innerText = currentStreak + 1;
        }
    </script>
</asp:Content>
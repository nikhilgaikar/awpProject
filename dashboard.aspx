<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="awpProject.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/dashboard.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-wrapper">
        <h1 class="message1">Welcome, <asp:Label ID="username" runat="server" Text=""></asp:Label></h1>
        <br />
        <h5 class="message2">All your tasks, at a glance</h5>

        <div class="dashboard-container">
            <!-- task cards -->
            <div class="cards">
                <a href="tasks.aspx" class="card red">
                    <p class="tip">❌ Overdue</p>
                    <h1><asp:Label ID="Overdue" runat="server" Text="0"></asp:Label></h1>
                </a>
                <a href="tasks.aspx" class="card blue">
                    <p class="tip">⏱️ Assigned</p>
                    <h1><asp:Label ID="Pending" runat="server" Text="0"></asp:Label></h1>
                </a>
                <a href="tasks.aspx" class="card green">
                    <p class="tip">✅ Completed</p>
                    <h1><asp:Label ID="Completed" runat="server" Text="0"></asp:Label></h1>
                </a>
            </div>
        </div>

        <!-- streaks cards -->
        <div class="recent-streaks-container mb-3">
            <h4 class="mt-4 mb-3">Recent Streaks</h4>
            <div class="row justify-content-center">
            <asp:Repeater ID="rptRecentStreaks" runat="server">
            <ItemTemplate>
                <div class="col-md-4 col-sm-6 streak-cards">
                    <a href="streaks.aspx" class="card streak-card">
                        <div class="streak-card p-3">
                        <p><h5><%# Eval("StreakName") %></h5></p>
                        
                        <p><%# Eval("Description") %></p>
                        <p><b>🔥 Current Streak:</b> <%# Eval("StreakCount") %> Days</p>
                        <p><b>Days Left:</b> <%# Eval("DaysLeft") %></p>
                         
                        </div>
                    </a>
                </div>
            </ItemTemplate>
             </asp:Repeater>


    </div>
</div>


    </div>
</asp:Content>

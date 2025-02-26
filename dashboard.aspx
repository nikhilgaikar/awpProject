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
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="awpProject.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/dashboard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dashboard-wrapper">
        <h1 class="message1">Welcome, <asp:Label ID="username" runat="server" Text=""></asp:Label></h1>
        <br />
        <h2 class="message2">All your tasks, at a glance</h2>
        
        <div class="dashboard-container">
            <div class="cards">
                <a href="tasks.aspx?filter=overdue" class="card red">
                    <p class="tip">❌ Overdue</p>
                    <h1>2</h1>
                </a>
                <a href="tasks.aspx?filter=assigned" class="card blue">
                    <p class="tip">⏱️ Assigned</p>
                    <h1>4</h1> 
                </a>
                <a href="tasks.aspx?filter=completed" class="card green">
                    <p class="tip">✅ Completed</p>
                    <h1>10</h1>
                </a>
            </div>
        </div>
    </div>
</asp:Content>

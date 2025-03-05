<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="progress.aspx.cs" Inherits="awpProject.progress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .progress-container {
            max-width: 600px;
            margin: 20px auto;
        }
        .progress-label {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2 class="text-center mb-4 mt-5">Task Progress</h2>
        
        <div class="progress-container">
            
            <p class="progress-label">Overall Progress: <asp:Label ID="lblOverallProgress" runat="server" /></p>
            <div class="progress">
                <div class="progress-bar" role="progressbar" runat="server" id="progressOverall"></div>
            </div>

            <p class="progress-label">College Tasks: <asp:Label ID="lblCollegeProgress" runat="server" /></p>
            <div class="progress">
                <div class="progress-bar bg-info" role="progressbar" runat="server" id="progressCollege"></div>
            </div>

            <p class="progress-label">Work Tasks: <asp:Label ID="lblWorkProgress" runat="server" /></p>
            <div class="progress">
                <div class="progress-bar bg-success" role="progressbar" runat="server" id="progressWork"></div>
            </div>

            <p class="progress-label">Personal Tasks: <asp:Label ID="lblPersonalProgress" runat="server" /></p>
            <div class="progress">
                <div class="progress-bar bg-warning" role="progressbar" runat="server" id="progressPersonal"></div>
            </div>
        </div>
    </div>
</asp:Content>

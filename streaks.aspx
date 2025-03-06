<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="streaks.aspx.cs" Inherits="awpProject.streaks" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">🏆 Streaks</h2>

        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <h5 class="card-title">Create a New Streak</h5>
                <div class="row">
                    <div class="col-md-4">
                        <asp:Label ID="lblstreakName" runat="server">Streak Name</asp:Label>
                        <asp:TextBox ID="streakName" runat="server" CssClass="form-control" placeholder="e.g., Daily Reading"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="lblstreakDescription" runat="server">Description</asp:Label>
                        <asp:TextBox ID="streakDescription" runat="server" CssClass="form-control" placeholder="Short description"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="lblgoalCompletionDate" runat="server">Goal Completion Date</asp:Label>
                        <asp:TextBox ID="goalCompletionDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnCreateStreak" runat="server" Text="Create Streak" CssClass="btn btn-primary mt-3" OnClick="btnCreateStreak_Click" />
            </div>
        </div>

        <!-- streaks list -->
        <div class="row">
            <asp:Repeater ID="rptStreaks" runat="server">
                <ItemTemplate>
                    <div class="col-md-6">
                        <div class="card mb-3 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <%# Eval("StreakName") %> 
                                    <span class="badge bg-secondary"><%# Eval("StreakCount") %>🔥</span>
                                </h5>
                                <p class="card-text"><%# Eval("Description") %></p>
                                <p class="text-muted">Days Left: <%# Eval("DaysLeft") %></p>
                                
                                <!-- Contribute Button -->
                                <asp:Button ID="btnContribute" runat="server" Text="Contribute Today" CssClass="btn btn-success btn-sm" 
                                    CommandArgument='<%# Eval("StreakID") %>' OnClick="btnContribute_Click" />

                                <!-- Delete Button -->
                                <asp:Button ID="btnDeleteStreak" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm ms-2" 
                                    CommandArgument='<%# Eval("StreakID") %>' OnClick="btnDeleteStreak_Click" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
 
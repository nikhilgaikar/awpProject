<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="tasks.aspx.cs" Inherits="awpProject.tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Task Management</h2>

        <!-- Task Input Form (Collapsible) -->
        <div class="card mb-4 customcard">
            <div class="card-header">
                <span>Add New Task</span>
                <button type="button" class="btn btn-sm btn-outline-secondary float-end" onclick="toggleTaskForm()">Minimize</button>
            </div>
            <div class="card-body" id="taskForm">
                <div class="mb-3">
                    <label class="form-label">Task Name</label>
                    <asp:TextBox ID="taskName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="taskDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <asp:TextBox ID="category" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Priority</label>
                    <asp:DropDownList ID="priority" CssClass="form-select" runat="server">
                        <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                        <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                        <asp:ListItem Text="High" Value="High"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label">Due Date</label>
                    <asp:TextBox ID="dueDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="addTask" CssClass="btn btn-primary" runat="server" Text="Add Task" OnClick="AddTask_Click"/>
            </div>
        </div>

        <!-- Task List Table -->
        <div class="card customcard">
            <div class="card-header">Task List</div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label">Filter by Status</label>
                    <asp:DropDownList ID="filterStatus" CssClass="form-select" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="All" Value="All"></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                        <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                        <asp:ListItem Text="Overdue" Value="Overdue"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Styled Task List -->
                <asp:GridView ID="GridView" runat="server" CssClass="table table-bordered table-hover"
                    AutoGenerateColumns="False" DataKeyNames="TaskID" PageSize="5"
                    OnRowEditing="GridView_RowEditing" OnRowUpdating="GridView_RowUpdating"
                    OnRowCancelingEdit="GridView_RowCancelingEdit" OnRowDeleting="GridView_RowDeleting">
                    
                    <Columns>
                        <asp:BoundField DataField="TaskID" HeaderText="Task ID" ReadOnly="True" />
                        <asp:BoundField DataField="TaskName" HeaderText="Task Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:BoundField DataField="Category" HeaderText="Category" />
                        <asp:BoundField DataField="Priority" HeaderText="Priority" />
                        <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />

                        <%-- Edit and Delete Buttons --%>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="edit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                                <asp:LinkButton ID="delete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
                            </ItemTemplate>

                            <%-- Edit individual items --%>
                            <EditItemTemplate>
                                <asp:TextBox ID="taskNameEdit" runat="server" CssClass="form-control" Text='<%# Bind("TaskName") %>'></asp:TextBox>
                                <asp:TextBox ID="taskDescriptionEdit" runat="server" CssClass="form-control" Text='<%# Bind("Description") %>'></asp:TextBox>
                                <asp:TextBox ID="categoryEdit" runat="server" CssClass="form-control" Text='<%# Bind("Category") %>'></asp:TextBox>
                                <asp:DropDownList ID="priorityEdit" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                                    <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                                    <asp:ListItem Text="High" Value="High"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="dueDateEdit" runat="server" CssClass="form-control" TextMode="Date" Text='<%# Bind("DueDate", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                <asp:LinkButton ID="update" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">Save</asp:LinkButton>
                                <asp:LinkButton ID="cancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Card Styling */
        .customcard {
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        }

        /* Table Styling */
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }

        /* Button Styling */
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.9rem;
        }
    </style>

    <script>
        function toggleTaskForm() {
            var form = document.getElementById("taskForm");
            form.style.display = form.style.display === "none" ? "block" : "none";
        }
    </script>
</asp:Content>

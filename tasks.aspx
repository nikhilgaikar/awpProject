<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="tasks.aspx.cs" Inherits="awpProject.tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container mt-4">
            <h2 class="mb-3">Task Management</h2>

            <!-- Task Input Form -->
                <div class="card p-3 mb-4">
                    <h5>Add New Task</h5>
                    <div class="row g-2">
                        <!-- Task Name -->
                        <div class="col-md-4">
                            <label for="taskName" class="form-label">Task Name</label>
                            <asp:TextBox ID="taskName" runat="server" CssClass="form-control" placeholder="Enter task name" />
                        </div>

                        <!-- Task Description -->
                        <div class="col-md-4">
                            <label for="taskDescription" class="form-label">Task Description</label>
                            <asp:TextBox ID="taskDescription" runat="server" CssClass="form-control" placeholder="Enter task description" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <!-- Due Date -->
                        <div class="col-md-2">
                            <label for="dueDate" class="form-label">Due Date</label>
                            <asp:TextBox ID="dueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- Category and Priorty-->
                        <div class="col-md-2">
                            <label for="category" class="form-label">Category</label>
                            <asp:DropDownList ID="category" CssClass="form-select" runat="server">
                                <asp:ListItem Text="📚 College" Value="College"></asp:ListItem>
                                <asp:ListItem Text="💼 Work" Value="Work"></asp:ListItem>
                                <asp:ListItem Text="🏡 Personal" Value="Personal"></asp:ListItem>
                            </asp:DropDownList>

                            <label for="priority" class="form-label">Priority</label>
                            <asp:DropDownList ID="priority" CssClass="form-select" runat="server">
                                <asp:ListItem Text="High" Value="High"></asp:ListItem>
                                <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                                <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Add Task Button -->
                        <div class="col-md-2">
                            <label class="form-label d-block">&nbsp;</label> 
                            <asp:Button ID="AddTask" runat="server" CssClass="btn btn-primary w-100" Text="Add Task" OnClick="AddTask_Click" />
                        </div>
                    </div>
                </div>

            <!-- Tasks GridView -->
            <asp:GridView ID="GridView" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                DataKeyNames="TaskID" OnRowEditing="GridView_RowEditing" OnRowCancelingEdit="GridView_RowCancelingEdit"
                OnRowUpdating="GridView_RowUpdating" OnRowDeleting="GridView_RowDeleting">
                
                <Columns>
                    <%-- Mark as Completed Column --%>
                    <asp:TemplateField HeaderText="Complete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnComplete" runat="server" CssClass="btn btn-success btn-sm"
                                Text="✅" OnClick="MarkAsCompleted"
                                Visible='<%# Eval("Status").ToString() != "Completed" %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- Task Name --%>
                    <asp:TemplateField HeaderText="Task">
                        <ItemTemplate>
                            <%# Eval("TaskName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="taskNameEdit" runat="server" CssClass="form-control" Text='<%# Bind("TaskName") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Description --%>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <%# Eval("Description") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="taskDescriptionEdit" runat="server" CssClass="form-control" Text='<%# Bind("Description") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Category --%>
                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <%# Eval("Category") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="categoryEdit" runat="server" CssClass="form-select">
                                <asp:ListItem Text="📚 College" Value="College"></asp:ListItem>
                                <asp:ListItem Text="💼 Work" Value="Work"></asp:ListItem>
                                <asp:ListItem Text="🏡 Personal" Value=" Personal"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Priority --%>
                    <asp:TemplateField HeaderText="Priority">
                        <ItemTemplate>
                            <%# Eval("Priority") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="priorityEdit" runat="server" CssClass="form-select">
                                <asp:ListItem Text="High" Value="High"></asp:ListItem>
                                <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                                <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Due Date --%>
                    <asp:TemplateField HeaderText="Due Date">
                        <ItemTemplate>
                            <%# Eval("DueDate", "{0:yyyy-MM-dd}") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="dueDateEdit" runat="server" CssClass="form-control" TextMode="Date" Text='<%# Bind("DueDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>


                    <%-- Status with Color --%>
                 <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <span style='<%# "display: inline-block; padding: 5px 10px; border-radius: 5px; color: white; background-color: " +
                            (Eval("Status").ToString() == "Completed" ? "#32a852" : 
                            (Eval("Status").ToString() == "Pending" ? "#ffc800" : "#fc1c1c")) %>;'>
                            <%# Eval("Status") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>



                    <%-- Edit & Delete Buttons --%>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-sm" Text="✏ Edit" CommandName="Edit"></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" Text="🗑 Delete" CommandName="Delete"
                                OnClientClick="return confirm('Are you sure you want to delete this task?');"></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm" Text="✔ Save" CommandName="Update"></asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-sm" Text="✖ Cancel" CommandName="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        </asp:Content>
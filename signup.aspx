<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="awpProject.signup" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Signup Page</title>
    <link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet" />
     <link href="css/signup.css" rel="stylesheet" />
</head>
<body>
    <!-- Header -->
    <header class="header">
    <a style="text-decoration:none" href="homepage.aspx">
        <div class="logo">
            <img src="images/logo.png" alt="Logo" height="40">
            <span>taskflow ™</span>
        </div>
    </a>
</header>
    <form id="form1" runat="server">
        <div class="sign-up-container">
            <div class="sign-up-form">
                <h2>Sign Up</h2>

                <div class="input-container">
                    <asp:TextBox ID="username" runat="server" placeholder="Username" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="reqUsername" runat="server" ControlToValidate="username" CssClass="error-message" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>

                <div class="input-container">
                    <asp:TextBox ID="email" runat="server" placeholder="Email" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="email" CssClass="error-message" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>
                <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="email" CssClass="error-message full-width"
                    ErrorMessage="Invalid email format" 
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$">
                </asp:RegularExpressionValidator>

                <div class="input-container">
                    <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="password" CssClass="error-message" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>

                <div class="input-container">
                    <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="reqConfirmPassword" runat="server" ControlToValidate="confirmPassword" CssClass="error-message" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>
                <asp:CompareValidator ID="comparePassword" runat="server" ControlToValidate="confirmPassword" ControlToCompare="password" CssClass="error-message full-width" ErrorMessage="Passwords do not match"></asp:CompareValidator>

                <asp:Button ID="signupBtn" runat="server" Text="Sign Up" CssClass="signup-btn" OnClick="SignupBtn_Click"/>

                <a href="login.aspx" class="login-link">Already have an account? Log in</a>
            </div>
        </div>
    </form>
</body>
</html>


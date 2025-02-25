<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="awpProject.signup" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Signup Page</title>
    <link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet" />
    <style>
        body {
            background-image: linear-gradient(to right, #B8E0D2, #E8F6F3);
            font-family: 'Inter', sans-serif;
        }

        .sign-up-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .sign-up-form {
            width: 100%;
            max-width: 450px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #f8f9fa;
            box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 12px;
            text-align: center;
        }

        .input-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            position: relative;
        }

        .input-container input {
            width: 88%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        .error-message {
            color: red;
            font-size: 0.85em;
            margin-left: 5px;
            white-space: nowrap;
        }

        .full-width {
            display: block;
            width: 100%;
            text-align: left;
            margin-top: 3px;
            margin-bottom: 5px;
        }

        .signup-btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        .signup-btn:hover {
            background: #0056b3;
        }

        .login-link {
            margin-top: 10px;
            display: block;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }

        .login-link:hover {
            text-decoration: underline;
        }
        .header {
            background: #ffffff;
            color: #343a40;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
            border-radius: 15px;
            padding-top: 10px;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        }

        .logo {
            display: flex;
            align-items: center; /* Ensures vertical alignment */
            gap: 10px; /* Adds spacing between logo and text */
        }

        .logo img {
            height: 40px;
        }

        .logo span {
            font-size: 1.8rem;  /* Bigger text */
            font-weight: bold;  /* Bold text */
            color: #343a40;     /* Dark color for better visibility */
            letter-spacing: 1px; /* Slight spacing for better look */
        }

    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo">
            <img src="images/logo.png" alt="Logo" height="40"/>
            <span>taskflow ™</span>
        </div>
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


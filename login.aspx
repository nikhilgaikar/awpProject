<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="awpProject.login" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet" />
    <style>
        body {
            background-image: linear-gradient(to right, #B8E0D2, #E8F6F3);
            font-family: 'Inter', sans-serif;
        }
        .log-in-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .log-in-form {
            width: 450px; /* Increased width */
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #f8f9fa;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            text-align: center;
        }
        .input-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            margin-bottom: 10px;
        }
        .log-in-form input {
            width: 90%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .login-btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
        }
        .log-in-form h2 {
            text-align: center;
            width: 100%;
        }
        .error-star {
            color: red;
            font-weight: bold;
            margin-left: 5px;
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
        <div class="log-in-container">
            <div class="log-in-form">
                <h2>Login</h2>

                <div class="input-container">
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="*" CssClass="error-star" Display="Dynamic" />
                </div>

                <div class="input-container">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" CssClass="error-star" Display="Dynamic" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login-btn" OnClick="btnLogin_Click" />
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" />

                <br />
                <asp:HyperLink ID="lnkSignup" runat="server" NavigateUrl="signup.aspx">Don't have an account? Sign up</asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>




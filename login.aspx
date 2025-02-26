<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="awpProject.login" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet" />
    <link href="css/login.css" rel="stylesheet" />
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




<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="awpProject.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet">
    <link href="css/homepage.css" rel="stylesheet">
    <title>taskflow</title>
</head>
<body>
    <div class="left">
        <h1 class="heading1">taskflow</h1>
        <h4 class="heading2">Get Things Done, One Task at a Time.</h4>
    </div>
    <div class="right">
        <div class="window">
            <form>
                <h3 class="text-center">Haven't registered?</h3>              
                <a href="signup.aspx">
                    <button type="button" class="signup-btn">Sign Up</button>
                </a>
                <h3 class="text-center">Already have an account?</h3>
                <a href="login.aspx">
                    <button type="button" class="login-btn">Log In</button>
                </a>
            </form>
        </div>
    </div>
</body>
</html>

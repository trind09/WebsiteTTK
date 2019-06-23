<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TTK Technology Services</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="CÔNG TY TNHH DỊCH VỤ CÔNG NGHỆ THÔNG TIN TTK">
    <meta name="target_country" content="VN">
    <meta content="text/html; charset=UTF-8" http-equiv="Content-type">
    <meta http-equiv="Content-Style-Type" content="text/css/">
    <meta name="page_content" content="services">
    <meta content="TTK TECHNOLOGY SERVICES COMPANY LIMITED" name="keywords">
    <meta name="company_code" content="ttk">
    <meta name="lang" content="vn">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Choose Icons: https://www.w3schools.com/icons/fontawesome_icons_webapp.asp -->
    <!-- Google fonts - Roboto -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700">
    <!-- owl carousel-->
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.theme.default.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="Logo_small.png">
    <!-- Tweaks for older IEs-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        function RefreshParent()
        {
            if (self !== top) {
                parent.location.reload();
            } else {
                var homeURL = $("#<%=Home_Page_URL.ClientID%>").text();
                window.location.href = homeURL;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:PlaceHolder runat="server" ID="LoginStatus" Visible="false">
            <div class="form-group">
                <asp:Label runat="server" ID="StatusText" Text=""></asp:Label>
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="LoginForm" Visible="false">
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="LoginUserName">User name</asp:Label>
                <asp:TextBox runat="server" ID="LoginUserName" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="LoginPassword">Password</asp:Label>
                <asp:TextBox runat="server" ID="LoginPassword" TextMode="Password" CssClass="form-control" />
            </div>
            <div class="text-center">
                <asp:Button runat="server" CssClass="btn btn-primary" OnClick="SignIn" Text="Log in" />
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="LogoutButton" Visible="false">
            <div class="text-center">
                <asp:Button runat="server" CssClass="btn btn-danger" OnClick="SignOut" Text="Log out" />
            </div>
        </asp:PlaceHolder>
        <p class="text-center text-muted">Not registered yet?</p>
        <p class="text-center text-muted"><a target="_parent" href="register.aspx"><strong>Register now</strong></a>! It is easy and done in 1 minute and gives you access to special discounts and much more!</p>
        <div runat="server" id="Home_Page_URL" style="display: none;"></div>
    </form>
</body>
</html>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">
        <div id="all">
            <div id="content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- breadcrumb-->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li aria-current="page" class="breadcrumb-item active">New account / Sign in</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col-lg-6" runat="server" id="RegisterForm">
                            <div class="box">
                                <h1>New account</h1>
                                <p class="lead">Not our registered customer yet?</p>
                                <p>With registration with us new world of fashion, fantastic discounts and much more opens to you! The whole process will not take you more than a minute!</p>
                                <p class="text-muted">If you have any questions, please feel free to <a href="contact.aspx">contact us</a>, our customer service center is working for you 24/7.</p>
                                <hr>
                                <div class="form-group">
                                    <asp:label runat="server" id="StatusMessage" text=""></asp:label>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="UserName">User name</asp:Label>
                                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="Password">Password</asp:Label>
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="ConfirmPassword">Confirm password</asp:Label>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                                </div>
                                <div class="text-center">
                                    <asp:Button runat="server" CssClass="btn btn-primary" OnClick="CreateUser_Click" Text="Register" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="box">
                                <h1>Login</h1>
                                <p class="lead">Already our customer?</p>
                                <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                                <hr>
                                <asp:PlaceHolder runat="server" ID="LoginStatus" Visible="false">
                                    <div class="form-group">
                                        <asp:Label runat="server" id="StatusText" Text=""></asp:Label>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


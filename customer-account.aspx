<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="customer-account.aspx.cs" Inherits="customer_account" %>

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
                                    <li aria-current="page" class="breadcrumb-item active">My account</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col-lg-3">
                            <!--
                  *** CUSTOMER MENU ***
                  _________________________________________________________
                  -->
                            <div class="card sidebar-menu">
                                <div class="card-header">
                                    <h3 class="h4 card-title">Customer section</h3>
                                </div>
                                <div class="card-body">
                                    <ul class="nav nav-pills flex-column">
                                        <a href="customer-orders.aspx" class="nav-link">
                                            <i class="fa fa-list"></i>My orders</a>
                                        <a href="customer-wishlist.aspx" class="nav-link">
                                            <i class="fa fa-heart"></i>My wishlist</a>
                                        <a href="customer-account.aspx" class="nav-link active">
                                            <i class="fa fa-user"></i>My account</a>
                                        <a href="Default.aspx" class="nav-link"><i class="fa fa-sign-out"></i>Logout</a>
                                    </ul>
                                </div>
                            </div>
                            <!-- /.col-lg-3-->
                            <!-- *** CUSTOMER MENU END ***-->
                        </div>
                        <div class="col-lg-9">
                            <div class="box">
                                <h1>My account</h1>
                                <p class="lead">Change your personal details or your password here.</p>
                                <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
                                <h3>Change password</h3>
                                <asp:Label ID="lblChangePasswordMessage" runat="server" Text=""></asp:Label>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password_old">Old password</label>
                                            <asp:TextBox ID="password_old" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password_1">New password</label>
                                            <asp:TextBox ID="password_1" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password_2">Retype new password</label>
                                            <asp:TextBox ID="password_2" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row-->
                                <div class="col-md-12 text-center">
                                    <asp:LinkButton ID="lbnChangePassword" runat="server" CssClass="btn btn-primary" OnClick="lbnChangePassword_Click"><i class="fa fa-save"></i>Save new password</asp:LinkButton>
                                </div>
                                <h3 class="mt-5">Personal details</h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="firstname">Firstname</label>
                                            <asp:TextBox ID="firstname" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="lastname">Lastname</label>
                                            <asp:TextBox ID="lastname" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="company">Company</label>
                                            <asp:TextBox ID="company" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="street">Street</label>
                                            <asp:TextBox ID="street" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row-->
                                <div class="row">
                                    <div class="col-md-6 col-lg-3">
                                        <div class="form-group">
                                            <label for="city">City</label>
                                            <asp:TextBox ID="city" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <div class="form-group">
                                            <label for="zip">ZIP</label>
                                            <asp:TextBox ID="zip" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <div class="form-group">
                                            <label for="state">State</label>
                                            <asp:TextBox ID="state" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <div class="form-group">
                                            <label for="country">Country</label>
                                            <asp:DropDownList ID="country" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phone">Telephone</label>
                                            <asp:TextBox ID="PhoneNumber" MaxLength="15" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <asp:TextBox ID="Email" MaxLength="64" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phone">Birthday</label>
                                            <input id="birthday" runat="server" type="text" date="date" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email">Gender</label>
                                            <asp:DropDownList ID="gender" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-12 text-center">
                                        <input id="currentDateFormat" runat="server" type="text" style="display: none;">
                                        <asp:LinkButton ID="btnSubmitUserAddress" runat="server" CssClass="btn btn-primary" OnClick="btnSubmitUserAddress_Click"><i class="fa fa-save"></i>Save changes</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            var currentDateFormat = $("#<%=currentDateFormat.ClientID%>").val();
            $('input[date=date]').each(function () {
                currentDateFormat = currentDateFormat.replace('yyyy', 'yy');
                currentDateFormat = currentDateFormat.replace('MM', 'mm');
                console.log(currentDateFormat);
                $(this).datepicker({
                    dateFormat: currentDateFormat
                });
            })
        });
    </script>
</asp:Content>


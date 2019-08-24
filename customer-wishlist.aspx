<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="customer-wishlist.aspx.cs" Inherits="customer_wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div runat="server" id="Wishlist_Data" style="display: none;"></div>
    <script>
        var currentHostUrl = window.location.origin;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
            }

            var Wishlist_Data_Json = $("#<%=Wishlist_Data.ClientID%>").text();
            if (Wishlist_Data_Json) {
                var model = jQuery.parseJSON(Wishlist_Data_Json);
                $('#totalProducts').text(" (" + model.TotalProducts + ")");
                MakeupLinks(model);
            }
        });

        function MakeupLinks(model) {
            $('#home_link').attr('href', currentHostUrl);
            $('#wishlist_link').attr('href', currentHostUrl + "/customer-wishlist.aspx");
            $('#my_account_link').attr('href', currentHostUrl + "/customer-account.aspx");
            $('#logout_link').attr('href', currentHostUrl + "/logout.aspx?redirect=" + window.location.href);
            $('#my_order_link').attr('href', currentHostUrl + "/customer-orders.aspx");
        }
    </script>
    <div id="all">
        <div id="content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <!-- breadcrumb-->
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#" id="home_link">Home</a></li>
                                <li aria-current="page" class="breadcrumb-item active">My wishlist</li>
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
                                    <a href="customer-orders.aspx" class="nav-link" id="my_order_link">
                                        <i class="fa fa-list"></i>My orders</a><a href="customer-wishlist.aspx" class="nav-link active" id="wishlist_link"><i class="fa fa-heart"></i> My wishlist</a>
                                    <a href="customer-account.aspx" class="nav-link" id="my_account_link"><i class="fa fa-user"></i> My account</a>
                                    <a href="Default.aspx" class="nav-link" id="logout_link"><i class="fa fa-sign-out"></i> Logout</a>
                                </ul>
                            </div>
                        </div>
                        <!-- /.col-lg-3-->
                        <!-- *** CUSTOMER MENU END ***-->
                    </div>
                    <div id="wishlist" class="col-lg-9">
                        <div class="box">
                            <h1>My wishlist<span id="totalProducts"></span></h1>
                        </div>
                        <div class="row products" runat="server" id="wishlist_region">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="checkout1.aspx.cs" Inherits="checkout1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var currentHostUrl = window.location.origin;
        var defaultShippingFee = 0;
        var defaultTax = 0;
        var basket = null;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
                defaultShippingFee = masterPageData.DefaultShippingFee;
                defaultTax = masterPageData.DefaultTax;
                basket = masterPageData.Basket;
            }

            InitControls();
        });

        function InitControls() {
            $('#back_to_basket_link').attr("href", currentHostUrl + "/basket.aspx");

            if (basket != null) {
                $('#order_subtotal').html("<span class='order_subtotal'>" + GetCurrency(basket.OrderTotal, basket.CurrencyCode, 'order_subtotal') + "</span>");
                $('#shipping_total').html("<span class='shipping_total'>" + GetCurrency(basket.ShippingTotal, basket.CurrencyCode, 'shipping_total') + "</span>");
                if (basket.TaxTotal == 0) {
                    $('#tax_cell').hide();
                } else {
                    $('#tax_total').html("<span class='tax_total'>" + GetCurrency(basket.TaxTotal, basket.CurrencyCode, 'tax_total') + "</span>");
                }
                if (basket.TotalDiscount > 0) {
                    $('#total_discount').html("<span class='total_discount'>" + GetCurrency(basket.TotalDiscount, basket.CurrencyCode, 'total_discount') + "</span>");
                } else {
                    $('#discount_cell').hide();
                }
                $('#grand_total').html("<span class='grand_total'>" + GetCurrency(basket.GrandTotal, basket.CurrencyCode, 'grand_total') + "</span>");
            }
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
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li aria-current="page" class="breadcrumb-item active">Checkout - Address</li>
                            </ol>
                        </nav>
                    </div>
                    <div id="checkout" class="col-lg-9">
                        <div class="box">
                            <form id="checkout1_form" runat="server">
                                <h1>Checkout - Address</h1>
                                <div class="nav flex-column flex-md-row nav-pills text-center"><a href="checkout1.aspx" class="nav-link flex-sm-fill text-sm-center active"><i class="fa fa-map-marker"></i>Address</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-truck"></i>Delivery Method</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-money"></i>Payment Method</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-eye"></i>Order Review</a></div>
                                <div class="content py-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtFirstname">Firstname</label>
                                                <asp:TextBox ID="txtFirstname" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtLastname">Lastname</label>
                                                <asp:TextBox ID="txtLastname" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.row-->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtCompany">Company</label>
                                                <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtStreet">Street</label>
                                                <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.row-->
                                    <div class="row">
                                        <div class="col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label for="txtCity">City</label>
                                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label for="txtZip">ZIP</label>
                                                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label for="txtState">State</label>
                                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label for="ddlCountry">Country</label>
                                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtPhoneNumber">Telephone</label>
                                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="txtEmail">Email</label>
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.row-->
                                </div>
                                <div class="box-footer d-flex justify-content-between">
                                    <a href="basket.aspx" id="back_to_basket_link" class="btn btn-outline-secondary"><i class="fa fa-chevron-left"></i>Back to Basket</a>
                                    <asp:LinkButton ID="lbnUpdateAddress" CssClass="btn btn-primary" runat="server" OnClick="lbnUpdateAddress_Click">Continue to Delivery Method<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                </div>
                            </form>
                        </div>
                        <!-- /.box-->
                    </div>
                    <!-- /.col-lg-9-->
                    <div class="col-lg-3">
                        <div id="order-summary" class="card">
                            <div class="card-header">
                                <h3 class="mt-4 mb-4">Order summary</h3>
                            </div>
                            <div class="card-body">
                                <p class="text-muted">Shipping and additional costs are calculated based on the values you have entered.</p>
                                <div class="table-responsive">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>Order subtotal</td>
                                                <th id="order_subtotal"></th>
                                            </tr>
                                            <tr>
                                                <td>Shipping and handling</td>
                                                <th id="shipping_total"></th>
                                            </tr>
                                            <tr id="tax_cell">
                                                <td>Tax</td>
                                                <th id="tax_total"></th>
                                            </tr>
                                            <tr id="discount_cell">
                                                <td>Discount</td>
                                                <th id="total_discount"></th>
                                            </tr>
                                            <tr class="total">
                                                <td>Total</td>
                                                <th id="grand_total"></th>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-lg-3-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>



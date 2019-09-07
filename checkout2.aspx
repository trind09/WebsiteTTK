﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="checkout2.aspx.cs" Inherits="checkout2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var currentHostUrl = window.location.origin;
        var defaultShippingFee = 0;
        var defaultTax = 0;
        var basket = null;
        var grandTotal = 0;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
                defaultShippingFee = masterPageData.DefaultShippingFee;
                defaultTax = masterPageData.DefaultTax;
                basket = masterPageData.Basket;
                grandTotal = basket.GrandTotal;
            }

            InitControls();
        });

        function InitControls() {
            $('#back_to_address_link').attr("href", currentHostUrl + "/checkout1.aspx");
            var CheckOut2_Data_Json = $("#<%=CheckOut2_Data.ClientID%>").text();
            if (CheckOut2_Data_Json) {
                var model = jQuery.parseJSON(CheckOut2_Data_Json);
                if (model) {
                    var methods = model.DeliveryMethods;
                    var selectedMethod = model.DeliveryMethod;
                    var currency = model.Currency;

                    var deliveryMethodsHtml = "";
                    for (var i = 0; i < methods.length; i++)
                    {
                        var method = methods[i];
                        deliveryMethodsHtml += "<div class='col-md-6'><div class='box shipping-method' onclick='SelectDeliveryMethod(\"" + method.delivery_id + "\");'>";
                        deliveryMethodsHtml += "<h4>" + method.delivery_name + "</h4>";
                        deliveryMethodsHtml += "<p>" + method.delievery_description + "</p>";
                        if (method.delivery_cost != null)
                        {
                            deliveryMethodsHtml += "<p><span class='method-" + method.delivery_id + "'>" + GetCurrency(method.delivery_cost, currency.currency_code, 'method-' + method.delivery_id) + "</span></p>";
                        }
                        deliveryMethodsHtml += "<div class='box-footer text-center'>";
                        if (selectedMethod != null)
                        {
                            if (method.delivery_id == selectedMethod.delivery_id)
                            {
                                deliveryMethodsHtml += "<input type='radio' name='delivery' value='" + method.delivery_id + "' selected>";
                            }
                            else
                            {
                                deliveryMethodsHtml += "<input type='radio' name='delivery' value='" + method.delivery_id + "'>";
                            }
                        } else
                        {
                            deliveryMethodsHtml += "<input type='radio' name='delivery' value='" + method.delivery_id + "'>";
                        }
                        deliveryMethodsHtml += "</div></div></div>";
                    }
                    $('#delivery_methods_div').html(deliveryMethodsHtml);
                    UpdateOrderSummary();
                }
            }
        }

        function UpdateOrderSummary() {
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

        function SelectDeliveryMethod(delivery_id) {
            var CheckOut2_Data_Json = $("#<%=CheckOut2_Data.ClientID%>").text();
            if (CheckOut2_Data_Json) {
                var model = jQuery.parseJSON(CheckOut2_Data_Json);
                if (model) {
                    var methods = model.DeliveryMethods;
                    for (var i = 0; i < methods.length; i++) {
                        var method = methods[i];
                        if (method.delivery_id == delivery_id) {
                            basket.ShippingTotal = method.delivery_cost;
                            basket.GrandTotal = grandTotal + method.delivery_cost;
                            UpdateOrderSummary();
                        }
                    }
                }
            }
        }
    </script>
    <div id="CheckOut2_Data" runat="server" style="display: none;"></div>
    <div id="all">
        <div id="content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <!-- breadcrumb-->
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li aria-current="page" class="breadcrumb-item active">Checkout - Delivery method</li>
                            </ol>
                        </nav>
                    </div>
                    <div id="checkout" class="col-lg-9">
                        <div class="box">
                            <form method="get" action="checkout3.aspx">
                                <h1>Checkout - Delivery method</h1>
                                <div class="nav flex-column flex-sm-row nav-pills"><a href="checkout1.aspx" class="nav-link flex-sm-fill text-sm-center"><i class="fa fa-map-marker"></i>Address</a><a href="checkout2.aspx" class="nav-link flex-sm-fill text-sm-center active"> <i class="fa fa-truck"></i>Delivery Method</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-money"></i>Payment Method</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-eye"></i>Order Review</a></div>
                                <div class="content py-3">
                                    <div class="row" id="delivery_methods_div"></div>
                                </div>
                                <div class="box-footer d-flex justify-content-between">
                                    <a href="checkout1.aspx" class="btn btn-outline-secondary" id="back_to_address_link"><i class="fa fa-chevron-left"></i>Back to address</a>
                                    <button type="submit" class="btn btn-primary">Continue to Payment Method<i class="fa fa-chevron-right"></i></button>
                                </div>
                            </form>
                        </div>
                        <!-- /.box-->
                    </div>
                    <!-- /.col-md-9-->
                    <div class="col-md-3">
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
                    <!-- /.col-md-3-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>


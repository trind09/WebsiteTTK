<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="basket.aspx.cs" Inherits="basket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var currentHostUrl = window.location.origin;
        var defaultShippingFee = 0;
        var defaultTax = 0;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
                defaultShippingFee = masterPageData.DefaultShippingFee;
                defaultTax = masterPageData.DefaultTax;
            }

            var Server_Data_Json = $("#<%=Server_Data.ClientID%>").text();
            if (Server_Data_Json) {
                var model = jQuery.parseJSON(Server_Data_Json);

                InitControls(model);

                SetUpMessage(model);
            }
        });

        //Startup functions ---------------------------------------------------
        function InitControls(model) {
            $('#basket_home_link').attr('href', currentHostUrl);
            $('#continue_shopping_link').attr('href', currentHostUrl);
            if (model.Order != null) {
                $('#coupon_code').attr('order_id', model.Order.order_id);
            }
        }

        function SetUpMessage(model) {
            if (model.OrderItems != null) {
                var basket_product_tbody = "";
                for (var i = 0; i < model.OrderItems.length; i++) {
                    var order_item = model.OrderItems[i];

                    var product_url = currentHostUrl + "/product-detail.aspx?product_id=" + order_item.product_id;
                    var remove_product_url = currentHostUrl + "/update-basket.aspx?remove_product_id=" + order_item.product_id + "&order_id=" + model.Order.order_id;

                    var imageItems = order_item.product_images.split(';');
                    var images = imageItems.filter(function (el) {
                        return el != "";
                    });
                    basket_product_tbody += "<tr>"
                        + "<td><a href='" + product_url + "'>";
                    if (images.length > 0) {
                        basket_product_tbody += "<img src='" + currentHostUrl + "/" + images[0] + "' alt='" + order_item.product_name +"'></a></td>";
                    } else {
                        basket_product_tbody += "<img src='" + currentHostUrl + "/img/no_image.jpg" + "' alt='" + order_item.product_name +"'></a></td>";
                    }
                    basket_product_tbody += "<td><a href='" + product_url + "'>" + order_item.product_name + "</a></td>"
                    basket_product_tbody += "<td><input style='width: 100px;' type='number' value='" + order_item.quantity + "' class='form-control product-quantity-field' id='" + order_item.item_id + "' order_id='" + model.Order.order_id + "' name='order_item_field'></td>";
                    basket_product_tbody += "<td><span class='price-" + order_item.product_id + "'>" + GetCurrency(order_item.list_price, model.CurrencyCode, 'price-' + order_item.product_id) + "</span></td>";
                    basket_product_tbody += "<td><span class='discount-" + order_item.product_id + "'>" + GetCurrency(order_item.discount, model.CurrencyCode, 'discount-' + order_item.product_id) + "</span></td>"
                    basket_product_tbody += "<td><span class='total-" + order_item.product_id + "'>" + GetCurrency(order_item.total_price, model.CurrencyCode, 'total-' + order_item.product_id) + "</span></td>"
                    basket_product_tbody += "<td><a onclick=\"RemoveProduct('" + remove_product_url + "')\" style='cursor: pointer;'><i class='fa fa-trash-o'></i></a></td>";
                    basket_product_tbody += "</tr>";
                }

                if (model.TaxTotal == 0) {
                    $('#tax_cell').hide();
                } else {
                    $('#tax_total').html("<span class='tax_total'>" + GetCurrency(model.TaxTotal, model.CurrencyCode, 'tax_total') + "</span>");
                }

                var grandTotal = model.OrderTotal + model.ShippingTotal + model.TaxTotal;

                var basket_product_tfoot = "<tr><th colspan='5'>Total</th><th colspan='2'><span class='ordertotal'>" + GetCurrency(model.OrderTotal, model.CurrencyCode, 'ordertotal') + "</span></th></tr>";
                
                $('#basket_message').html("You currently have " + model.TotalItem + " item(s) in your cart.");
                $('#basket_product_tbody').html(basket_product_tbody);
                $('#basket_product_tfoot').html(basket_product_tfoot);
                $('#order_subtotal').html("<span class='order_subtotal'>" + GetCurrency(model.OrderTotal, model.CurrencyCode, 'order_subtotal') + "</span>");
                $('#shipping_total').html("<span class='shipping_total'>" + GetCurrency(model.ShippingTotal, model.CurrencyCode, 'shipping_total') + "</span>");
                $('#grand_total').html("<span class='grand_total'>" + GetCurrency(model.GrandTotal, model.CurrencyCode, 'grand_total') + "</span>");
            }
        }
        //End: Startup functions ---------------------------------------------------

        //Start: Process functions ---------------------------------------------------
        function UpdateCart() {
            var ids = [];
            var quantities = [];
            var order_id = 0;
            $.each($('.product-quantity-field'), function (index, value) {
                var field = $('.product-quantity-field')[index];
                var id = field.id;
                var quantity = field.value;
                order_id = field.getAttribute('order_id');
                ids.push(id);
                quantities.push(quantity);
            });
            var ids_str = ids.join(';');
            var quantities_str = quantities.join(';');
            var update_cart_url = currentHostUrl + "/update-basket.aspx?ids=" + ids_str + "&quantities=" + quantities_str + "&order_id=" + order_id;
            location.href = update_cart_url;
        }

        function RemoveProduct(url) {
            if (confirm('Do you agree to remove this product from your order?')) {
                location.href = url;
            }
        }

        function ProceedToCheckout() {
            location.href = currentHostUrl + "/checkout1.aspx";
        }

        function ApplyCoupon() {
            var coupon_code = $('#coupon_code').val();
            var order_id = $('#coupon_code').attr('order_id');
            var update_cart_url = currentHostUrl + "/update-basket.aspx?coupon_code=" + coupon_code + "&order_id=" + order_id;
            $('#myframe').attr('src', update_cart_url);
            $('#center_div').show();
        }
        //End: Process functions ---------------------------------------------------

        //Start: Util functions---------------------------------------------
        function GetCurrency(amount, currency_code, control_id) {
            var data = {};
            data.param = amount + '|' + currency_code + '|' + control_id;
            $.ajax({
                type: "POST",
                url: currentHostUrl + "/WebServices/ProductWebService.asmx/GetCurrency",
                cache: false,
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(data),
                dataType: "json",
                success: ShowCurrency,
                error: ajaxFailed
            });
        }

        function ShowCurrency(data, status) {
            var str = data.d;
            var items = str.split('|');
            var priceLabels = $('.' + items[1]);
            $.each(priceLabels, function (index, value) {
                $(priceLabels[index]).text(items[0]);
            });
        }

        function ajaxFailed(xmlRequest) {
            console.log(xmlRequest.status + ' \n\r ' + 
                  xmlRequest.statusText + '\n\r' + 
                  xmlRequest.responseText);
        }

        window.CloseUpdateBasket = function () {
            $('#myframe').attr('src', "");
            $('#center_div').hide();
        }
        //End: Util functions---------------------------------------------
    </script>
    <div runat="server" id="Server_Data" style="display: none;" />
    <div id="all">
        <div id="content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <!-- breadcrumb-->
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#" id="basket_home_link">Home</a></li>
                                <li aria-current="page" class="breadcrumb-item active">Shopping cart</li>
                            </ol>
                        </nav>
                    </div>
                    <div id="basket" class="col-lg-9">
                        <div class="box">
                            <h1>Shopping cart</h1>
                            <p class="text-muted" id="basket_message"></p>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th colspan="2">Product</th>
                                            <th>Quantity</th>
                                            <th>Unit price</th>
                                            <th>Discount</th>
                                            <th colspan="2">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody id="basket_product_tbody">
                                    </tbody>
                                    <tfoot id="basket_product_tfoot">
                                    </tfoot>
                                </table>
                            </div>
                            <!-- /.table-responsive-->
                            <div class="box-footer d-flex justify-content-between flex-column flex-lg-row">
                                <div class="left"><a href="category.aspx" id="continue_shopping_link" class="btn btn-outline-secondary"><i class="fa fa-chevron-left"></i>Continue shopping</a></div>
                                <div class="right">
                                    <button class="btn btn-outline-secondary" onclick="UpdateCart();"><i class="fa fa-refresh"></i>Update cart</button>
                                    <button type="submit" class="btn btn-primary" onclick="ProceedToCheckout();">Proceed to checkout <i class="fa fa-chevron-right"></i></button>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-->
                        <div class="row same-height-row">
                            <div class="col-lg-3 col-md-6">
                                <div class="box same-height">
                                    <h3>You may also like these products</h3>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="product same-height">
                                    <div class="flip-container">
                                        <div class="flipper">
                                            <div class="front"><a href="product-detail.aspx">
                                                <img src="img/product2.jpg" alt="" class="img-fluid"></a></div>
                                            <div class="back"><a href="product-detail.aspx">
                                                <img src="img/product2_2.jpg" alt="" class="img-fluid"></a></div>
                                        </div>
                                    </div>
                                    <a href="product-detail.aspx" class="invisible">
                                        <img src="img/product2.jpg" alt="" class="img-fluid"></a>
                                    <div class="text">
                                        <h3>Fur coat</h3>
                                        <p class="price">$143</p>
                                    </div>
                                </div>
                                <!-- /.product-->
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="product same-height">
                                    <div class="flip-container">
                                        <div class="flipper">
                                            <div class="front"><a href="product-detail.aspx">
                                                <img src="img/product1.jpg" alt="" class="img-fluid"></a></div>
                                            <div class="back"><a href="product-detail.aspx">
                                                <img src="img/product1_2.jpg" alt="" class="img-fluid"></a></div>
                                        </div>
                                    </div>
                                    <a href="product-detail.aspx" class="invisible">
                                        <img src="img/product1.jpg" alt="" class="img-fluid"></a>
                                    <div class="text">
                                        <h3>Fur coat</h3>
                                        <p class="price">$143</p>
                                    </div>
                                </div>
                                <!-- /.product-->
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="product same-height">
                                    <div class="flip-container">
                                        <div class="flipper">
                                            <div class="front"><a href="product-detail.aspx">
                                                <img src="img/product3.jpg" alt="" class="img-fluid"></a></div>
                                            <div class="back"><a href="product-detail.aspx">
                                                <img src="img/product3_2.jpg" alt="" class="img-fluid"></a></div>
                                        </div>
                                    </div>
                                    <a href="product-detail.aspx" class="invisible">
                                        <img src="img/product3.jpg" alt="" class="img-fluid"></a>
                                    <div class="text">
                                        <h3>Fur coat</h3>
                                        <p class="price">$143</p>
                                    </div>
                                </div>
                                <!-- /.product-->
                            </div>
                        </div>
                    </div>
                    <!-- /.col-lg-9-->
                    <div class="col-lg-3">
                        <div id="order-summary" class="box">
                            <div class="box-header">
                                <h3 class="mb-0">Order summary</h3>
                            </div>
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
                                        <tr class="total">
                                            <td>Total</td>
                                            <th id="grand_total"></th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box-header">
                                <h4 class="mb-0">Coupon code</h4>
                            </div>
                            <p class="text-muted">If you have a coupon code, please enter it in the box below.</p>
                            <div class="input-group">
                                <input type="text" class="form-control" id="coupon_code">
                                <span class="input-group-append">
                                    <button type="button" class="btn btn-primary" onclick="ApplyCoupon()"><i class="fa fa-gift"></i></button>
                                </span>
                            </div>
                            <!-- /input-group-->
                        </div>
                    </div>
                    <!-- /.col-md-3-->
                </div>
            </div>
        </div>
    </div>
    <div id="center_div" style="display: none; width: 1px; height: 1px;"><iframe id="myframe" style="border: 0px; width: 1px; height: 1px;"></iframe></div>
</asp:Content>


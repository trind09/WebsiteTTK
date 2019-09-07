<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="recently-viewed.aspx.cs" Inherits="recently_viewed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        var currentHostUrl = window.location.origin;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
            }

            GetProductsViewedRecently();
        });

        function GetProductsViewedRecently() {
            //EraseCookie("ttk_product_ids");
            var product_ids = ReadCookie("ttk_product_ids");
            if (product_ids != null) {
                var product_ids = product_ids.split(',');

                if (product_ids.length > 0) {
                    //TODO with recent_product_ids
                    var data = {};
                    data.ids = product_ids.join('|');
                    $.ajax({
                            type: "POST",
                            url: currentHostUrl + "/WebServices/ProductWebService.asmx/GetProducts",
                            cache: false,
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(data),
                            dataType: "json",
                            success: ShowProductsViewedRecently,
                            error: ajaxFailed
                        });
                } else {
                    //CreateCookie("ttk_product_ids", product.product_id + "", 7);
                }
            } else {
                //CreateCookie("ttk_product_ids", product.product_id + "", 7);
            }
        }

        function ShowProductsViewedRecently(data, status) {
            var relativeProductHtml = "";
            if (data.d != null) {
                for (var count in data.d) {
                    var product = data.d[count];
                    var product_url = currentHostUrl + "/product-detail.aspx?product_id=" + product.product_id;
                    var imageItems = product.product_images.split(';');
                    var images = imageItems.filter(function (el) {
                        return el != "";
                    });
                    var product_image = "";
                    var image_url = "";
                    if (images.length > 0) {
                        product_image += "<div class='front'><a href='" + product_url + "'><img src='" + currentHostUrl + "/" + images[0] + "' alt='" + product.product_name + "' class='img-fluid'></a></div>"
                        image_url = currentHostUrl + "/" + images[0];
                        if (images.length > 1) {
                            product_image += "<div class='back'><a href='" + product_url + "'><img src='" + currentHostUrl + "/" + images[1] + "' alt='" + product.product_name + "' class='img-fluid'></a></div>"
                        } else {
                            product_image += "<div class='back'><a href='" + product_url + "'><img src='" + currentHostUrl + "/img/no_image.jpg' alt='" + product.product_name + "' class='img-fluid'></a></div>"
                        }
                    } else {
                        image_url = currentHostUrl + "/img/no_image.jpg";
                        product_image += "<div class='front'><a href='" + product_url + "'><img src='" + currentHostUrl + "/img/no_image.jpg' alt='" + product.product_name + "' class='img-fluid'></a></div>"
                        product_image += "<div class='back'><a href='" + product_url + "'><img src='" + currentHostUrl + "/img/no_image.jpg' alt='" + product.product_name + "' class='img-fluid'></a></div>"
                    }

                    relativeProductHtml += "<div class='col-md-3 col-sm-6'>";
                    relativeProductHtml += "<div class='product same-height'>";
                    relativeProductHtml += "<div class='flip-container'><div class='flipper'>";
                    relativeProductHtml += product_image;
                    relativeProductHtml += "</div></div>";
                    if (image_url != "") {
                        relativeProductHtml += "<a href='" + product_url + "' class='invisible'><img src='" + image_url + "' alt='' class='img-fluid'></a>";
                    }
                    relativeProductHtml += "<div class='text'><h3>" + product.product_name + "</h3><p class='price price-" + product.product_id + "'>" + GetCurrency(product.list_price, product.currency_code, 'price-' + product.product_id) + "</p>";
                    if (product.is_sale) {
                        relativeProductHtml += "<div style='margin-left: -10px;' class='ribbon sale'><div class='theribbon'>SALE</div><div class='ribbon-background'></div></div>";
                    }

                    if (product.is_new) {
                        relativeProductHtml += "<div style='margin-left: -10px;' class='ribbon new'><div class='theribbon'>NEW</div><div class='ribbon-background'></div></div>";
                    }

                    if (product.is_gift) {
                        relativeProductHtml += "<div style='margin-left: -10px;' class='ribbon gift'><div class='theribbon'>GIFT</div><div class='ribbon-background'></div></div>";
                    }
                    relativeProductHtml += "</div ></div></div>";
                }
                $("#productItems").html(relativeProductHtml);
            } else {
                $('#recently_viewed_panel').html("<h3>No product viewed currently!</h3>");
            }
        }

        //----------------Utils-----------------------------
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
        //----------------Utils-----------------------------
    </script>
    <div id="all">
        <div id="content">
            <div class="container">
                <div id="recently_viewed_panel" class="row breadcrumb">
                    <h3>Recently viewed products</h3>
                </div>
                <div class="row">
                    <div id="category_product_panel">
                        <div class="row products" id="productItems">
                        </div>
                    </div>
                    <!-- /.col-lg-9-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="product-detail.aspx.cs" Inherits="product_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div runat="server" id="Product_Data" style="display: none;"></div>
    <div runat="server" id="ThisProductCategory_Data" style="display: none;"></div>
    <div runat="server" id="StoreCategories_Data" style="display: none;"></div>
    <script>
        var currentHostUrl = window.location.protocol + '//' + $(location).attr('host');

        $(document).ready(function () {
            var productDataJson = $("#<%=Product_Data.ClientID%>").text();
            if (productDataJson) {
                var product = jQuery.parseJSON(productDataJson);
                MakeupProduct(product);

                //This will help to SEO this product
                UpdateMetaTag(product);

                var categoryDataJson = $("#<%=ThisProductCategory_Data.ClientID%>").text();
                var category = jQuery.parseJSON(categoryDataJson);

                var storeCategoriesDataJson = $("#<%=StoreCategories_Data.ClientID%>").text();
                var storeCategories = jQuery.parseJSON(storeCategoriesDataJson);
                MakeupCategories(category, storeCategories);
            }
        });

        function MakeupProduct(product) {
            if (product) {
                if (product.product_description != null && product.product_description.trim() != '') {
                    var product_description = $("<div>").html(product.product_description).text();
                    var description = "<p></p><h4>Product details</h4>" + product_description
                    var social = "<div class='social'><h4>Show it to your friends</h4><p>"
                        + "<a href='https://www.facebook.com/sharer.php?u=" + window.location.href + "' class='external facebook'><i class='fa fa-facebook'></i></a>"
                        + "<a href='https://twitter.com/intent/tweet?text=" + product.product_name + "&url=" + window.location.href + "' class='external twitter'><i class='fa fa-twitter'></i></a>"
                        + "<a href='mailto:?subject=" + product.product_name + "&amp;body=Check out this site " + window.location.href + "' class='email' title='Share by Email'><i class='fa fa-envelope'></i></a>"
                        + "</p></div>";
                    $('#details').html(description + social);
                }
            }
        }

        //Get total product of top level category. Apply for three levels only
        function GetProductCount(paCat, storeCategories) {
            var productCount = paCat.product_count;
            var firstChildCategories = storeCategories.filter(x => x.parent_id === paCat.category_id);
            if (firstChildCategories.length > 0) {
                for (j = 0; j < firstChildCategories.length; ++j) {
                    var fiChiCat = firstChildCategories[j];
                    productCount += fiChiCat.product_count;
                    var secondChildCategories = storeCategories.filter(x => x.parent_id === fiChiCat.category_id);
                    if (secondChildCategories.length > 0) {
                        for (k = 0; k < secondChildCategories.length; ++k) {
                            var seChiCat = secondChildCategories[k];
                            productCount += seChiCat.product_count;
                        }
                    }
                }
            }
            return productCount;
        }

        //Genrate category tree menu. Apply for three levels only
        function MakeupCategories(category, storeCategories) {
            if (storeCategories.length > 0) {
                var menuLiItems = "<ul class='nav nav-pills flex-column category-menu'>";
                var grandFatherCategories = storeCategories.filter(x => x.parent_id === 0);
                if (grandFatherCategories.length > 0) {
                    for (i = 0; i < grandFatherCategories.length; ++i) {
                        var paCat = grandFatherCategories[i];
                        var grandfather_category_url = currentHostUrl + "/category.aspx?category_id=" + paCat.category_id;
                        if (paCat.category_url)
                        {
                            grandfather_category_url = paCat.category_url;
                        }
                        var isLabel = paCat.is_label == null ? false : paCat.is_label;
                        isActive = category.category_id == paCat.category_id ? " active" : "";

                        var paCatProductCount = GetProductCount(paCat, storeCategories);
                        var productCount = paCatProductCount > 0 ? " <span class='badge badge-secondary'>" + paCatProductCount + "</span>" : ""
                        
                        if (isLabel) {
                            menuLiItems += "<li><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + paCat.category_name + productCount + "</span>";
                        }
                        else {
                            menuLiItems += "<li><a class='nav-link" + isActive + "' href='" + grandfather_category_url + "'>" + paCat.category_name + productCount + "</a>";
                        }

                        var firstChildCategories = storeCategories.filter(x => x.parent_id === paCat.category_id);
                        if (firstChildCategories.length > 0) {
                            menuLiItems += "<ul class='list-unstyled'>";
                            for (j = 0; j < firstChildCategories.length; ++j) {
                                var fiChiCat = firstChildCategories[j];
                                var father_category_url = currentHostUrl + "/category.aspx?category_id=" + fiChiCat.category_id;
                                if (fiChiCat.category_url) {
                                    father_category_url = fiChiCat.category_url;
                                }
                                isLabel = fiChiCat.is_label == null ? false : fiChiCat.is_label;
                                isActive = category.category_id == fiChiCat.category_id ? " active" : "";

                                productCount = fiChiCat.product_count > 0 ? " <span class='badge'>" + fiChiCat.product_count + "</span>" : ""

                                var secondChildCategories = storeCategories.filter(x => x.parent_id === fiChiCat.category_id);
                                if (secondChildCategories.length > 0) {
                                    if (isLabel) {
                                        menuLiItems += "<li><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + fiChiCat.category_name + productCount + "</span>";
                                    }
                                    else {
                                        menuLiItems += "<li><a class='nav-link" + isActive + "' href='" + father_category_url + "'>" + fiChiCat.category_name + productCount + "</a>";
                                    }

                                    menuLiItems += "<ul class='list-unstyled' style='margin-left: 20px; font-style: italic;'>";
                                    for (k = 0; k < secondChildCategories.length; ++k) {
                                        var seChiCat = secondChildCategories[k];
                                        var child_category_url = currentHostUrl + "/category.aspx?category_id=" + seChiCat.category_id;
                                        if (seChiCat.category_url) {
                                            child_category_url = seChiCat.category_url;
                                        }
                                        isLabel = seChiCat.is_label == null ? false : seChiCat.is_label;
                                        isActive = category.category_id == seChiCat.category_id ? " active" : "";

                                        productCount = seChiCat.product_count > 0 ? " <span class='badge'>" + seChiCat.product_count + "</span>" : ""

                                        if (isLabel) {
                                            menuLiItems += "<li><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + seChiCat.category_name + productCount + "</span></li>";
                                        } else {
                                            menuLiItems += "<li><a href='" + child_category_url + "' class='nav-link" + isActive + "'>" + seChiCat.category_name + productCount + "</a></li>";
                                        }
                                    }
                                    menuLiItems += "</ul>";
                                } else {
                                    if (isLabel) {
                                        menuLiItems += "<li><span class='nav-link" + isActive + "'>" + fiChiCat.category_name + productCount + "</span>";
                                    }
                                    else {
                                        menuLiItems += "<li><a class='nav-link" + isActive + "' href='" + father_category_url + "'>" + fiChiCat.category_name + productCount + "</a>";
                                    }
                                }
                                menuLiItems += "</li>";
                            }
                            menuLiItems += "</ul>";
                        } else {
                            if (isLabel)
                            {
                                menuLiItems += "<li><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + paCat.category_name + productCount + "</span>";
                            }
                            else
                            {
                                menuLiItems += "<li><a class='nav-link" + isActive + "' href='" + grandfather_category_url + "'>" + paCat.category_name + productCount + "</a>";
                            }
                        }
                        menuLiItems += "</li>";
                    }
                }
                menuLiItems += "</ul>";

                $('#categories').html(menuLiItems);
            }
            
        }

        //This will help to SEO this product
        function UpdateMetaTag(product) {
            $('meta[name=url]').remove();
            $('head').append('<meta name="url" content="' + window.location.href + '">');
            $('meta[name=type]').remove();
            $('head').append('<meta name="type" content="website">');
            $('meta[name=title]').remove();
            $('head').append('<meta name="title" content="' + product.product_name + '">');
            $('meta[name=description]').remove();
            $('head').append('<meta name="description" content="TTK Technology - ' + product.product_name + '">');

            $('head').append('<meta property="og:url" content="' + window.location.href + '">');
            $('head').append('<meta property="og:type" content="website">');
            $('head').append('<meta property="og:title" content="' + product.product_name + '">');
            $('head').append('<meta property="og:description" content="TTK Technology - ' + product.product_name + '">');
            var images = product.product_images.split(';');
            var product_image = "";
            for (i = 0; i < images.length; ++i) {
                var image = images[i];
                if (image != "")
                {
                    product_image = currentHostUrl + "/" + image;
                    break;
                }
            }
            $('head').append('<meta property="og:image" content="' + product_image + '">');
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
                                <li class="breadcrumb-item"><a href="#">Ladies</a></li>
                                <li class="breadcrumb-item"><a href="#">Tops</a></li>
                                <li aria-current="page" class="breadcrumb-item active">White Blouse Armani</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="col-lg-3 order-2 order-lg-1">
                        <!--
              *** MENUS AND FILTERS ***
              _________________________________________________________
              -->
                        <div class="card sidebar-menu mb-4">
                            <div class="card-header">
                                <h3 class="h4 card-title">Categories</h3>
                            </div>
                            <div class="card-body" id="categories">
                                
                            </div>
                        </div>
                        <div class="card sidebar-menu mb-4">
                            <div class="card-header">
                                <h3 class="h4 card-title">Brands <a href="#" class="btn btn-sm btn-danger pull-right"><i class="fa fa-times-circle"></i>Clear</a></h3>
                            </div>
                            <div class="card-body">
                                <form>
                                    <div class="form-group">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                Armani  (10)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                Versace  (12)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                Carlo Bruni  (15)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                Jack Honey  (14)
                                            </label>
                                        </div>
                                    </div>
                                    <button class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>
                                </form>
                            </div>
                        </div>
                        <div class="card sidebar-menu mb-4">
                            <div class="card-header">
                                <h3 class="h4 card-title">Colours <a href="#" class="btn btn-sm btn-danger pull-right"><i class="fa fa-times-circle"></i>Clear</a></h3>
                            </div>
                            <div class="card-body">
                                <form>
                                    <div class="form-group">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"><span class="colour white"></span> White (14)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"><span class="colour blue"></span> Blue (10)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"><span class="colour green"></span>  Green (20)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"><span class="colour yellow"></span>  Yellow (13)
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"><span class="colour red"></span>  Red (10)
                                            </label>
                                        </div>
                                    </div>
                                    <button class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>
                                </form>
                            </div>
                        </div>
                        <!-- *** MENUS AND FILTERS END ***-->
                        <div class="banner"><a href="#">
                            <img src="img/banner.jpg" alt="sales 2014" class="img-fluid"></a></div>
                    </div>
                    <div class="col-lg-9 order-1 order-lg-2">
                        <div id="productMain" runat="server" class="row">
                            
                        </div>
                        <div id="details" class="box"></div>
                        <div class="row same-height-row">
                            <div class="col-md-3 col-sm-6">
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
                        <div class="row same-height-row">
                            <div class="col-md-3 col-sm-6">
                                <div class="box same-height">
                                    <h3>Products viewed recently</h3>
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
                    <!-- /.col-md-9-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>


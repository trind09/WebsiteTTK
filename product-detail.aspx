<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="product-detail.aspx.cs" Inherits="product_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div runat="server" id="ProductControllerModel_Data" style="display: none;"></div>
    <script>
        var currentHostUrl = window.location.origin;

        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
            }

            var ProductControllerModel_Json = $("#<%=ProductControllerModel_Data.ClientID%>").text();
            if (ProductControllerModel_Json) {
                var model = jQuery.parseJSON(ProductControllerModel_Json);

                //Show product detail
                MakeupProduct(model.Product);

                //This will help to SEO this product
                UpdateMetaTag(model.Product);

                //Show category tree menu
                MakeupCategories(model.Category, model.Categories);

                //Show category path
                MakeupCategoriesPath(model);

                //Show brand tree menu
                MakeupBrands(model.Category, model.Brands);

                //Show colour tree menu
                MakeupColours(model.Category, model.Colours);

                //Show relative product
                ShowRelativeProducts(model.RelativeProducts);

                //Show products viewed recently
                GetProductsViewedRecently(model.Product);

                //Makeup sale, gift, and new link url
                MakeupSaleGiftNewLink(model);
            } else {
                $('#details').html("<h3>No product selected!</h3>");
            }
        });

        //Makeup sale, gift, and new link url
        function MakeupSaleGiftNewLink(model) {
            var category = model.Category;
            var store = model.Store;
            var urlWhereCls = "";
            if (category) {
                urlWhereCls = "category_id=" + category.category_id;
            } else {
                if (model.Store) {
                    urlWhereCls = "store_id=" + model.Store.store_id;
                }
            }
            if (category || store) {
                var sale_link = currentHostUrl + "/category.aspx?" + urlWhereCls + "&mode=sale";
                var gift_link = currentHostUrl + "/category.aspx?" + urlWhereCls + "&mode=gift";
                var new_link = currentHostUrl + "/category.aspx?" + urlWhereCls + "&mode=new";

                $('#sale_link').attr('href', sale_link);
                $('#sale_link').html('<img src="img/sale.jpg" alt="Sales items" class="img-fluid">');

                $('#gift_link').attr('href', gift_link);
                $('#gift_link').html('<img src="img/gift.jpg" alt="Items with gifts" class="img-fluid">');

                $('#new_link').attr('href', new_link);
                $('#new_link').html('<img src="img/new.jpg" alt="New items" class="img-fluid">');
            }
        }

        function AddToWishlist(product_id) {
            var data = {};
            data.product_id = product_id;
            $.ajax({
                type: "POST",
                url: currentHostUrl + "/WebServices/ProductWebService.asmx/AddToWishlist",
                cache: false,
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(data),
                dataType: "json",
                success: ShowAddToWishlistMessage,
                error: ajaxFailed
            });
        }

        function AddToCart(url) {
            if (isUserLogedIn) {
                location.href = url;
            } else {
                $('#btn_login').click();
            }
        }

        function ShowAddToWishlistMessage(data, status) {
            var model = data.d;
            if (model.Success) {
                ShowMessage(model.ResultCode);
                $('#wishlist_icon').attr('class', 'fa fa-heart');
            } else {
                if (model.ResultCode.Value[0] == 1) {
                    $('#btn_login').click();
                }
            }
        }

        //---------------------Start: Handle show recently viewed products--------------------//
        function GetProductsViewedRecently(product) {
            //EraseCookie("ttk_product_ids");
            var product_ids = ReadCookie("ttk_product_ids");
            if (product_ids != null) {
                var product_ids = product_ids.split(',');

                if (product_ids.length > 0) {
                    var recent_product_ids = $.grep(product_ids, function (e) {
                        return e != product.product_id;
                    });
                    //TODO with recent_product_ids
                    var data = {};
                    data.ids = recent_product_ids.join('|');
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
                    if (recent_product_ids.length > 6) {
                        recent_product_ids.splice(0, 1);
                    }
                    recent_product_ids.push(product.product_id + "");
                    CreateCookie("ttk_product_ids", recent_product_ids.join(','), 7);
                } else {
                    CreateCookie("ttk_product_ids", product.product_id + "", 7);
                }
            } else {
                CreateCookie("ttk_product_ids", product.product_id + "", 7);
            }
        }

        function ShowProductsViewedRecently(data, status) {
            var relativeProductHtml = "<div class='col-md-3 col-sm-6'><div class='box same-height'><h3>Products viewed recently</h3></div></div>";
            for (var count in data.d) {
                var product = data.d[count];
                var product_url = currentHostUrl + "/product-detail.aspx?product_id=" + product.product_id;
                var imageItems = product.product_images.split(';');
                var images = imageItems.filter(function (el) {
                    return el != "";
                });
                var productPrice = 0;
                if (product.list_price != null) {
                    productPrice = product.list_price;
                }
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
                relativeProductHtml += "<div class='text'><h3>" + product.product_name + "</h3><p class='price price-" + product.product_id + "'>" + GetCurrency(productPrice, product.currency_code, 'price-' + product.product_id) + "</p></div>";
                relativeProductHtml += "</div>";
                relativeProductHtml += "</div>";
            }
            $("#recentProducts").html(relativeProductHtml);
        }

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
        //---------------------End: Handle show recently viewed products--------------------//

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

        function MakeupCategoriesPath(model) {
            var category = model.Category;
            var storeCategories = model.Categories;
            var store = model.Store;
            var menuLiItems = "<nav aria-label='breadcrumb'><ol class='breadcrumb'>";
            var categoryHml = "";
            var parentCategoryHml = "";
            var grandParentCategoryHtml = "";
            if (category != null) {
                var category_url = currentHostUrl + "/category.aspx?category_id=" + category.category_id;
                if (category.category_url)
                {
                    category_url = category.category_url;
                }
                var isLabel = category.is_label == null ? false : category.is_label;
                if (isLabel) {
                    categoryHml = "<li class='breadcrumb-item'><span style='cursor: pointer;'>" + category.category_name + "</span></li>";
                }
                else {
                    categoryHml = "<li class='breadcrumb-item'><a href='" + category_url + "'>" + category.category_name + "</a></li>";
                }

                var parent_id = category.parent_id;
                if (parent_id > 0) {
                    var parentCategory = storeCategories.filter(x => x.category_id === parent_id);
                    if (parentCategory.length > 0) {
                        parentCategory = parentCategory[0];
                        var parent_category_url = currentHostUrl + "/category.aspx?category_id=" + parentCategory.category_id;
                        if (parentCategory.category_url)
                        {
                            parent_category_url = parentCategory.category_url;
                        }
                        isLabel = parentCategory.is_label == null ? false : parentCategory.is_label;
                        if (isLabel) {
                            parentCategoryHml = "<li class='breadcrumb-item'><span style='cursor: pointer;'>" + parentCategory.category_name + "</span></li>";
                        }
                        else {
                            parentCategoryHml = "<li class='breadcrumb-item'><a href='" + parent_category_url + "'>" + parentCategory.category_name + "</a></li>";
                        }

                        var grand_parent_id = parentCategory.parent_id;
                        if (grand_parent_id > 0) {
                            var grandParentCategory = storeCategories.filter(x => x.category_id === grand_parent_id);
                            if (grandParentCategory.length > 0) {
                                grandParentCategory = grandParentCategory[0];
                                var grand_parent_category_url = currentHostUrl + "/category.aspx?category_id=" + grandParentCategory.category_id;
                                if (grandParentCategory.category_url)
                                {
                                    grand_parent_category_url = grandParentCategory.category_url;
                                }
                                isLabel = grandParentCategory.is_label == null ? false : grandParentCategory.is_label;
                                if (isLabel) {
                                    grandParentCategoryHtml = "<li class='breadcrumb-item'><span style='cursor: pointer;'>" + grandParentCategory.category_name + "</span></li>";
                                }
                                else {
                                    grandParentCategoryHtml = "<li class='breadcrumb-item'><a href='" + grand_parent_category_url + "'>" + grandParentCategory.category_name + "</a></li>";
                                }
                            }
                        }
                    }
                }
            }
            var store_url = currentHostUrl + "/category.aspx?store_id=" + store.store_id;
            menuLiItems += "<li class='breadcrumb-item'><a href='" + store_url + "'>" + store.store_name + "</a></li>"
                + grandParentCategoryHtml + parentCategoryHml + categoryHml + "</ol></nav>";
            $('#category_path').html(menuLiItems);
        }

        //This function will help to create brand tree menu
        function MakeupBrands(category, brands) {
            if (brands) {
                var brandTreeHtml = "<div class='form-group'>";
                for (var i = 0; i < brands.length; i++) {
                    var brand = brands[i];
                    var productCount = brand.product_count > 0 ? " (" + brand.product_count + ")" : ""
                    brandTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='brand' value='" + brand.brand_id + "' category='" + category.category_id + "'> " + brand.brand_name + productCount + "</label></div>";
                }
                brandTreeHtml += '</div><button onclick="return Filter(\'brand\');" class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>';
                $('#brands').html(brandTreeHtml);
            }
        }

        //This function will help to create colour tree menu
        function MakeupColours(category, colours) {
            if (colours) {
                var colourTreeHtml = "<div class='form-group'>";
                for (var i = 0; i < colours.length; i++) {
                    var colour = colours[i];
                    var productCount = colour.product_count > 0 ? " (" + colour.product_count + ")" : ""
                    colourTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='colour' value='" + colour.colour_id + "' category='" + category.category_id + "'> <span class='colour' style='background: " + colour.colour_name + "; border-radius: 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> " + colour.colour_description + productCount + "</label></div>";
                }
                colourTreeHtml += '</div><button onclick="return Filter(\'colour\');" class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>';
                $('#colours').html(colourTreeHtml);
            }
        }

        function ShowRelativeProducts(relativeProducts) {
            if (relativeProducts != null) {
                if (relativeProducts.length > 0) {
                    var relativeProductHtml = "<div class='col-md-3 col-sm-6'><div class='box same-height'><h3>You may also like these products</h3></div></div>";
                    for (var i = 0; i < relativeProducts.length; i++) {
                        var product = relativeProducts[i];
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
                        relativeProductHtml += "<div class='text'><h3>" + product.product_name + "</h3><p class='price price-" + product.product_id + "'>" + GetCurrency(product.list_price, product.currency_code, 'price-' + product.product_id) + "</p></div>"
                        relativeProductHtml += "</div>";
                        relativeProductHtml += "</div>";
                    }
                    $("#relativeProducts").html(relativeProductHtml);
                }
            }
        }

        //filter product
        function Filter(element) {
            var isProcess = false;
            var brand_ids = new Array();
            var brand_query = "";
            var colour_ids = new Array();
            var colour_query = "";
            var category_id = 0;
            $.each($("input[name='brand']:checked"), function(){            
                brand_ids.push($(this).val());
                category_id = $(this).attr('category');
            });
            if (brand_ids.length > 0) {
                isProcess = true;
                brand_query = "&brand_id=" + brand_ids.join(',');
            }
            $.each($("input[name='colour']:checked"), function(){            
                colour_ids.push($(this).val());
                category_id = $(this).attr('category');
            });
            if (colour_ids.length > 0) {
                isProcess = true;
                colour_query = "&colour_id=" + colour_ids.join(',');
            }
            if (isProcess) {
                window.location.href = currentHostUrl + "/category.aspx?category_id=" + category_id + brand_query + colour_query;
            }
            return false;
        }

        //Clear filter product
        function ClearFilter(element) {
            return false;
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
                    <div class="col-lg-12" id="category_path">
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
                                <h3 class="h4 card-title">Brands <a href="#" class="btn btn-sm btn-danger pull-right" onclick="return ClearFilter('brand');"><i class="fa fa-times-circle"></i>Clear</a></h3>
                            </div>
                            <div class="card-body" id="brands">
                                
                            </div>
                        </div>
                        <div class="card sidebar-menu mb-4">
                            <div class="card-header">
                                <h3 class="h4 card-title">Colours <a href="#" class="btn btn-sm btn-danger pull-right" onclick="return ClearFilter('colour');"><i class="fa fa-times-circle"></i>Clear</a></h3>
                            </div>
                            <div class="card-body" id="colours">
                                
                            </div>
                        </div>
                        <!-- *** MENUS AND FILTERS END ***-->
                        <div class="banner">
                            <a id="sale_link" href="#"></a>
                        </div>
                        <div class="banner">
                            <a id="gift_link" href="#"></a>
                        </div>
                        <div class="banner">
                            <a id="new_link" href="#"></a>
                        </div>
                    </div>
                    <div class="col-lg-9 order-1 order-lg-2">
                        <div id="productMain" runat="server" class="row">
                            
                        </div>
                        <div id="details" class="box"></div>
                        <div class="row same-height-row" id="relativeProducts">
                            
                        </div>
                        <div class="row same-height-row" id="recentProducts">
                            
                        </div>
                    </div>
                    <!-- /.col-md-9-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>


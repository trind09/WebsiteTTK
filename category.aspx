<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="category.aspx.cs" Inherits="category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div runat="server" id="Server_Data" style="display: none;"></div>
    <script>
        var currentHostUrl = window.location.origin;
        $(document).ready(function () {
            var MasterPageDataJson = $('*[id*=MasterPageDataDiv]')[0].innerHTML;
            if (MasterPageDataJson) {
                var masterPageData = jQuery.parseJSON(MasterPageDataJson);
                currentHostUrl = masterPageData.HostUrl;
            }

            var Server_Data_Json = $("#<%=Server_Data.ClientID%>").text();
            if (Server_Data_Json) {
                var model = jQuery.parseJSON(Server_Data_Json);

                var mode = "";
                if ($.urlParam('mode')) {
                    mode = "&mode=" + $.urlParam('mode');
                }

                //Show only search products
                if ($.urlParam('search_val')) {
                    if (model.ProductItems != null) {
                        ShowProducts(model.ProductItems);

                        //Show product count
                        ShowPagination(model, mode);
                    } else {
                        $('#lblMessage').text('No products were found matching for "' + $.urlParam('search_val') + '"');
                        $('#categoryDetail').hide();
                    }
                    $('#category_panel').hide();
                    $('#brand_panel').hide();
                    $('#colour_panel').hide();
                    $('#category_product_panel').attr('class', '');
                } else {
                    //This will help to SEO this product
                    UpdateMetaTag(model);

                    //Show category detail
                    MakeupCategory(model);

                    //Show category tree menu
                    MakeupCategories(model.Category, model.Categories);

                    //Show category path
                    MakeupCategoriesPath(model);

                    //Show brand tree menu
                    MakeupBrands(model, mode);

                    //Show colour tree menu
                    MakeupColours(model, mode);

                    //Show relative product
                    ShowProducts(model.ProductItems);

                    //Show product count
                    ShowPagination(model, mode);

                    //Makeup sale, gift, and new link url
                    MakeupSaleGiftNewLink(model);
                }
            } else {
                $('#categoryDetail').html('<h3>No category has selected!');
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

        //Show product count
        function ShowPagination(model, mode) {
            var products = model.ProductItems;
            var total = model.TotalProducts;
            var category = model.Category;
            var urlWhereCls = "";
            if (category) {
                urlWhereCls = "category_id=" + category.category_id;
            } else if (model.Store) {
                urlWhereCls = "store_id=" + model.Store.store_id;
            } else if ($.urlParam('search_val')) {
                urlWhereCls = "search_val=" + $.urlParam('search_val');
            }
            if (products) {
                //Makeup now showing amount and total
                $('#productCount').html("Showing <strong>" + products.length + "</strong> of <strong>" + total + "</strong> products");

                if ($.urlParam('search_val')) {
                    $('#categoryDetail').text(total + ' items found for "' + $.urlParam('search_val') + '"');
                }

                //Makeup number per page list
                var orderby = "create_date";
                if ($.urlParam('orderby')) {
                    orderby = $.urlParam('orderby');
                }
                var sort = "desc";
                if ($.urlParam('sort')) {
                    sort = $.urlParam('sort');
                }
                var itemTwele = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=12&orderby="
                    + orderby + "&sort=" + sort + mode + "' class='btn btn-outline-secondary btn-sm'>12</a>";
                if ($.urlParam('pagesize') == '12') {
                    itemTwele = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=12&orderby="
                        + orderby + "&sort=" + sort + mode + "' class='btn btn-sm btn-primary'>12</a>";
                }
                var itemTwentyfour = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=24&orderby="
                        + orderby + "&sort=" + sort + mode + "' class='btn btn-outline-secondary btn-sm'>24</a>";
                if ($.urlParam('pagesize') == '24') {
                    itemTwentyfour = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=24&orderby="
                        + orderby + "&sort=" + sort + mode + "' class='btn btn-sm btn-primary'>24</a>";
                }
                var itemSixty = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=60&orderby="
                    + orderby + "&sort=" + sort + mode + "' class='btn btn-outline-secondary btn-sm'>60</a>";
                if ($.urlParam('pagesize') == '60' || !$.urlParam('pagesize')) {
                    itemSixty = "<a href='" + currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=60&orderby="
                        + orderby + "&sort=" + sort + mode + "' class='btn btn-sm btn-primary'>60</a>";
                }
                $('#productsNumber').html("<strong>Show</strong>" + itemTwele + itemTwentyfour + itemSixty + "<span>products</span>");

                //Makeup sort select list
                var sortBySelectList = "<strong>Sort by</strong><select name='sort-by' class='form-control' onchange=\"SortProducts(this,'" + mode + "');\" id='sortSelect'>";
                var options = ['Latest', 'Oldest', 'Price hight to low', 'Price low to hight'];
                var optionvalues = ['1', '2', '3', '4'];
                for (var i = 0; i < options.length; i++) {
                    sortBySelectList += "<option value='" + optionvalues[i] + "'>" + options[i] + "</option>";
                }
                sortBySelectList += "</select>";
                $('#productSortBy').html(sortBySelectList);

                //Dynamic set selected option for select list of orders
                if ($.urlParam('orderby') == "create_date" && $.urlParam('sort') == "desc") {
                    $('#sortSelect').val("1");
                } else if ($.urlParam('orderby') == "create_date" && $.urlParam('sort') == "asc") {
                    $('#sortSelect').val("2");
                } else if ($.urlParam('orderby') == "list_price" && $.urlParam('sort') == "desc") {
                    $('#sortSelect').val("3");
                } else if ($.urlParam('orderby') == "list_price" && $.urlParam('sort') == "asc") {
                    $('#sortSelect').val("4");
                }

                //Makeup pagination
                var currentPageIndex = 1;
                if ($.urlParam('pagenum')) {
                    currentPageIndex = $.urlParam('pagenum');
                }
                var currentPagesize = 60;
                if ($.urlParam('pagesize')) {
                    currentPagesize = $.urlParam('pagesize');
                }
                var orderby = "create_date";
                if ($.urlParam('orderby')) {
                    orderby = $.urlParam('orderby');
                }
                var sort = "desc";
                if ($.urlParam('sort')) {
                    sort = $.urlParam('sort');
                }
                var totalProducts = model.TotalProducts;
                if (totalProducts > currentPagesize) {
                    var pagingHtml = Paging(currentPageIndex, currentPagesize, totalProducts, mode)
                    $('#paginationPanel').html(pagingHtml);
                }
            }
        }

        function Paging(PageNumber, PageSize, TotalRecords, mode) {
            var urlWhereCls = "category_id=" + $.urlParam('category_id');
            var category_id = $.urlParam('category_id');
            var store_id = $.urlParam('store_id');
            if (!category_id) {
                urlWhereCls = "store_id=" + store_id;
            }
            if ($.urlParam('search_val')) {
                urlWhereCls += "&search_val=" + $.urlParam('search_val')
            }

            var currentPageIndex = 1;
            if ($.urlParam('pagenum')) {
                currentPageIndex = $.urlParam('pagenum');
            }
            var currentPagesize = 60;
            if ($.urlParam('pagesize')) {
                currentPagesize = $.urlParam('pagesize');
            }
            var orderby = "create_date";
            if ($.urlParam('orderby')) {
                orderby = $.urlParam('orderby');
            }
            var sort = "desc";
            if ($.urlParam('sort')) {
                sort = $.urlParam('sort');
            }

            var ReturnValue = "<ul class='pagination'>";
            var TotalPages = Math.ceil(TotalRecords / PageSize);
            if (+PageNumber > 1) {
                var preurl = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=" + (+PageNumber - 1) + "&pagesize=" + currentPagesize + "&orderby="
                                + orderby + "&sort=" + sort + mode;
                ReturnValue = ReturnValue + "<li class='page-item'><a href='" + preurl + "' aria-label='Previous' class='page-link'><span aria-hidden='true'>«</span><span class='sr-only'>Previous</span></a></li>";
            }
            else
                ReturnValue = ReturnValue + "<li class='page-item'><a style='cursor: pointer;' aria-label='Previous' class='page-link'><span aria-hidden='true'>«</span><span class='sr-only'>Previous</span></a></li>";
            if ((+PageNumber - 3) > 1) {
                var url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=" + currentPagesize + "&orderby="
                            + orderby + "&sort=" + sort + mode;
                ReturnValue = ReturnValue + "<li class='page-item'><a href='" + url + "' class='page-link'>1</a></li><li>&nbsp;.....&nbsp;</li>";
            }
            for (var i = +PageNumber - 3; i <= +PageNumber; i++)
                if (i >= 1) {
                    if (+PageNumber != i) {
                        var url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=" + i + "&pagesize=" + currentPagesize + "&orderby="
                            + orderby + "&sort=" + sort + mode;
                        ReturnValue = ReturnValue + "<li class='page-item'><a href='" + url + "' class='page-link'>" + i + "</a></li>";
                    }
                    else {
                        ReturnValue = ReturnValue + "<li class='page-item active'><a style='cursor: pointer;' class='page-link'>" + i + "</a></li>";
                    }
                }
            for (var i = +PageNumber + 1; i <= +PageNumber + 3; i++)
                if (i <= TotalPages) {
                    if (+PageNumber != i) {
                        var url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=" + i + "&pagesize=" + currentPagesize + "&orderby="
                            + orderby + "&sort=" + sort + mode;
                        ReturnValue = ReturnValue + "<li class='page-item'><a href='" + url + "' class='page-link'>" + i + "</a></li>";
                    }
                    else {
                        ReturnValue = ReturnValue + "<li class='page-item active'><a style='cursor: pointer;' class='page-link'>" + i + "</a></li>";
                    }
                }
            if ((+PageNumber + 3) < TotalPages) {
                var url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=" + TotalPages + "&pagesize=" + currentPagesize + "&orderby="
                            + orderby + "&sort=" + sort + mode;
                ReturnValue = ReturnValue + "<li class='page-item'>.....&nbsp;</li><li class='page-item'><a href='" + url + "' class='page-link'>" + TotalPages + "</a></li>";
            }
            if (+PageNumber < TotalPages) {
                var url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=" + (+PageNumber + 1) + "&pagesize=" + currentPagesize + "&orderby="
                            + orderby + "&sort=" + sort + mode;
                ReturnValue = ReturnValue + "<li class='page-item'><a href='" + url + "' aria-label='Next' class='page-link'><span aria-hidden='true'>»</span><span class='sr-only'>Next</span></a></li>";
            }
            else
                ReturnValue = ReturnValue + "<li class='page-item'>Next</li>";
            ReturnValue += "</ul>";
            return (ReturnValue);
        }

        //Show products of this category
        function ShowProducts(productItems) {
            if (productItems != null) {
                if (productItems.length > 0) {
                    var productHtml = "";
                    for (var i = 0; i < productItems.length; i++) {
                        var product = productItems[i];
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

                        productHtml += "<div class='col-lg-4 col-md-6'>";
                        productHtml += "<div class='product'>";
                        productHtml += "<div class='flip-container'><div class='flipper'>";
                        productHtml += product_image;
                        productHtml += "</div></div>";
                        if (image_url != "") {
                            productHtml += "<a href='" + product_url + "' class='invisible'><img src='" + image_url + "' alt='' class='img-fluid'></a>";
                        }
                        productHtml += "<div class='text'><h3><a href='" + product_url + "'>" + product.product_name + "</a></h3><p class='price'><del></del><span id='price-" + product.product_id + "'>" + GetCurrency(product.list_price, product.currency_code, 'price-' + product.product_id) + "</span></p>";
                        
                        if (product.is_sale)
                        {
                            productHtml += "<div style='margin-left: -10px;' class='ribbon sale'><div class='theribbon'>SALE</div><div class='ribbon-background'></div></div>";
                        }

                        if (product.is_new)
                        {
                            productHtml += "<div style='margin-left: -10px;' class='ribbon new'><div class='theribbon'>NEW</div><div class='ribbon-background'></div></div>";
                        }

                        if (product.is_gift)
                        {
                            productHtml += "<div style='margin-left: -10px;' class='ribbon gift'><div class='theribbon'>GIFT</div><div class='ribbon-background'></div></div>";
                        }

                        productHtml += "<p class='buttons'><a href='" + product_url + "' class='btn btn-outline-secondary'>View detail</a><a href='basket.aspx?product_id=" + product.product_id + "' class='btn btn-primary'><i class='fa fa-shopping-cart'></i>Add to cart</a></p>"
                            + "</div > ";
                        productHtml += "</div>";
                        productHtml += "</div>";
                    }
                    $("#productItems").html(productHtml);
                }
            }
        }

        //This function will help to create colour tree menu
        function MakeupColours(model, mode) {
            var category = model.Category;
            var store = model.Store;
            var category_id = 0;
            if (category) {
                category_id = category.category_id;
            }
            var store_id = 0;
            if (store) {
                store_id = store.store_id;
            }
            var colours = model.Colours;
            if (colours) {
                var colourTreeHtml = "<div class='form-group'>";
                var colour_ids = [];
                if ($.urlParam('colour_id')) {
                    colour_ids = ($.urlParam('colour_id') + "").split(',');
                }
                for (var i = 0; i < colours.length; i++) {
                    var colour = colours[i];
                    var productCount = colour.product_count > 0 ? " (" + colour.product_count + ")" : ""
                    var is_colour_id_exist_in_url = colour_ids.filter(x => x == colour.colour_id);
                    if (is_colour_id_exist_in_url.length == 1) {
                        colourTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='colour' value='" + colour.colour_id + "' category='" + category_id + "' store='" + store_id + "' checked> <span class='colour' style='background: " + colour.colour_name + "; border-radius: 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> " + colour.colour_description + productCount + "</label></div>";
                    } else {
                        colourTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='colour' value='" + colour.colour_id + "' category='" + category_id + "' store='" + store_id + "'> <span class='colour' style='background: " + colour.colour_name + "; border-radius: 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> " + colour.colour_description + productCount + "</label></div>";
                    }
                }
                colourTreeHtml += '</div><button onclick="return Filter(\'colour\', \'' + mode + '\');" class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>';
                $('#colours').html(colourTreeHtml);
            }
        }

        //This function will help to create brand tree menu
        function MakeupBrands(model, mode) {
            var category = model.Category;
            var store = model.Store;
            var brands = model.Brands;
            var category_id = 0;
            if (category) {
                category_id = category.category_id;
            }
            var store_id = 0;
            if (store) {
                store_id = store.store_id;
            }
            if (brands) {
                var brandTreeHtml = "<div class='form-group'>";
                var brand_ids = [];
                if ($.urlParam('brand_id')) {
                    brand_ids = ($.urlParam('brand_id') + "").split(',');
                }
                for (var i = 0; i < brands.length; i++) {
                    var brand = brands[i];
                    var productCount = brand.product_count > 0 ? " (" + brand.product_count + ")" : ""
                    var is_brand_id_exist_in_url = brand_ids.filter(x => x == brand.brand_id);
                    if (is_brand_id_exist_in_url.length == 1) {
                        brandTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='brand' value='" + brand.brand_id + "' category='" + category_id + "' store='" + store_id + "' checked> " + brand.brand_name + productCount + "</label></div>";
                    }
                    else {
                        brandTreeHtml += "<div class='checkbox'><label><input type='checkbox' name='brand' value='" + brand.brand_id + "' category='" + category_id + "' store='" + store_id + "'> " + brand.brand_name + productCount + "</label></div>";
                    }
                }
                brandTreeHtml += '</div><button onclick="return Filter(\'brand\', \'' + mode + '\');" class="btn btn-default btn-sm btn-primary"><i class="fa fa-pencil"></i>Apply</button>';
                $('#brands').html(brandTreeHtml);
            }
        }

        //Create category path links beneath the mega menu
        function MakeupCategoriesPath(model) {
            var category = model.Category;
            var storeCategories = model.Categories;
            var store = model.Store;
            var urlWhereCls = "";
            if (category) {
                urlWhereCls = "category_id=" + category.category_id;
            } else {
                if (store) {
                    urlWhereCls = "store_id=" + store.store_id;
                }
            }
            var menuLiItems = "<nav aria-label='breadcrumb'><ol class='breadcrumb'>";
            var categoryHml = "";
            var parentCategoryHml = "";
            var grandParentCategoryHtml = "";
            if (category) {
                var category_url = currentHostUrl + "/category.aspx?" + urlWhereCls;
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
            if (store != null) {
                var store_url = currentHostUrl + "/category.aspx?store_id=" + store.store_id;
                menuLiItems += "<li class='breadcrumb-item'><a href='" + store_url + "'>" + store.store_name + "</a></li>"
                    + grandParentCategoryHtml + parentCategoryHml + categoryHml + "</ol></nav>";
            }
            $('#category_path').html(menuLiItems);
        }

        //Genrate category tree menu. Apply for three levels only
        function MakeupCategories(category, storeCategories) {
            if (storeCategories != null) {
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
                        var isActive = "";
                        if (category) {
                            isActive = category.category_id == paCat.category_id ? " active" : "";
                        }

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
                                if (category) {
                                    isActive = category.category_id == fiChiCat.category_id ? " active" : "";
                                }

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
                                        if (category) {
                                            isActive = category.category_id == seChiCat.category_id ? " active" : "";
                                        }

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

        //This will show category detail
        function MakeupCategory(model) {
            var category = model.Category;
            var store = model.Store;
            if (category) {
                var categoryDetail = "<h1>" + category.category_name + "</h1>";
                if (category.category_description) {
                    categoryDetail += "<p>" + $("<div>").html(category.category_description).text() + "</p>";
                }
                $('#categoryDetail').html(categoryDetail);
            } else if (store) {
                var storeDetail = "<h1>" + store.store_name + "</h1>";
                if (store.store_description) {
                    storeDetail += "<p>" + $("<div>").html(store.store_description).text() + "</p>";
                }
                $('#categoryDetail').html(storeDetail);
            }
        }

        //This will help to SEO this product
        function UpdateMetaTag(model) {
            var category = model.Category;
            var store = model.Store;
            if (category) {
                $('meta[name=url]').remove();
                $('head').append('<meta name="url" content="' + window.location.href + '">');
                $('meta[name=type]').remove();
                $('head').append('<meta name="type" content="website">');
                $('meta[name=title]').remove();
                $('head').append('<meta name="title" content="' + category.category_name + '">');
                $('meta[name=description]').remove();
                $('head').append('<meta name="description" content="TTK Technology - ' + category.category_name + '">');

                $('head').append('<meta property="og:url" content="' + window.location.href + '">');
                $('head').append('<meta property="og:type" content="website">');
                $('head').append('<meta property="og:title" content="' + category.category_name + '">');
                $('head').append('<meta property="og:description" content="TTK Technology - ' + category.category_name + '">');
                var images = category.category_images.split(';');
                var category_image = "";
                for (i = 0; i < images.length; ++i) {
                    var image = images[i];
                    if (image != "") {
                        category_image = currentHostUrl + "/" + image;
                        break;
                    }
                }
                $('head').append('<meta property="og:image" content="' + category_image + '">');
            } else if (store) {
                $('meta[name=url]').remove();
                $('head').append('<meta name="url" content="' + window.location.href + '">');
                $('meta[name=type]').remove();
                $('head').append('<meta name="type" content="website">');
                $('meta[name=title]').remove();
                $('head').append('<meta name="title" content="' + store.store_name + '">');
                $('meta[name=description]').remove();
                $('head').append('<meta name="description" content="TTK Technology - ' + store.store_name + '">');

                $('head').append('<meta property="og:url" content="' + window.location.href + '">');
                $('head').append('<meta property="og:type" content="website">');
                $('head').append('<meta property="og:title" content="' + store.store_name + '">');
                $('head').append('<meta property="og:description" content="TTK Technology - ' + store.store_name + '">');
                var images = store.store_images.split(';');
                var store_image = "";
                for (i = 0; i < images.length; ++i) {
                    var image = images[i];
                    if (image != "") {
                        store_image = currentHostUrl + "/" + image;
                        break;
                    }
                }
                $('head').append('<meta property="og:image" content="' + store_image + '">');
            }
        }

        //--------------------------------------------------------------------------------------------------------
        //filter product
        function Filter(element, mode) {
            var isProcess = false;
            var brand_ids = new Array();
            var brand_query = "";
            var colour_ids = new Array();
            var colour_query = "";
            var category_id = 0;
            var store_id = 0;
            $.each($("input[name='brand']:checked"), function(){            
                brand_ids.push($(this).val());
                category_id = $(this).attr('category');
                store_id = $(this).attr('store');
            });
            if (brand_ids.length > 0) {
                isProcess = true;
                brand_query = "&brand_id=" + brand_ids.join(',');
            }
            $.each($("input[name='colour']:checked"), function(){            
                colour_ids.push($(this).val());
                category_id = $(this).attr('category');
                store_id = $(this).attr('store');
            });
            if (colour_ids.length > 0) {
                isProcess = true;
                colour_query = "&colour_id=" + colour_ids.join(',');
            }
            if (isProcess) {
                if (store_id > 0) {
                    window.location.href = currentHostUrl + "/category.aspx?store_id=" + store_id + brand_query + colour_query + mode;
                } else {
                    window.location.href = currentHostUrl + "/category.aspx?category_id=" + category_id + brand_query + colour_query + mode;
                }
            }
            return false;
        }

        //Clear filter product
        function ClearFilter(element) {
            if (element == "brand") {
                var brand_query = "";
                if ($.urlParam('brand_id')) {
                    brand_query = "&brand_id=" + $.urlParam('brand_id');
                }
                var newUrl = window.location.href.replace(brand_query, "");
                window.location.href = newUrl;
            } else if (element == "colour") {
                var colour_query = "";
                if ($.urlParam('colour_id')) {
                    colour_query = "&colour_id=" + $.urlParam('colour_id');
                }
                var newUrl = window.location.href.replace(colour_query, "");
                window.location.href = newUrl;
            }
        }

        //Sort products
        function SortProducts(element, mode) {
            var pagesize = $.urlParam('pagesize');
            if (!pagesize) {
                pagesize = 60;
            }
            var urlWhereCls = "category_id=" + $.urlParam('category_id');
            var category_id = $.urlParam('category_id');
            var store_id = $.urlParam('store_id');
            if (!category_id) {
                urlWhereCls = "store_id=" + store_id;
            }
            if ($.urlParam('search_val')) {
                urlWhereCls += "&search_val=" + $.urlParam('search_val')
            }

            var value = element.value;
            var url = currentHostUrl;
            if (value == "1") {
                var orderby = 'create_date';
                url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=" + pagesize + "&orderby="
                    + orderby + "&sort=desc" + mode;
            } else if (value == "2") {
                var orderby = 'create_date';
                url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=" + pagesize + "&orderby="
                    + orderby + "&sort=asc" + mode;
            } else if (value == "3") {
                var orderby = 'list_price';
                url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=" + pagesize + "&orderby="
                    + orderby + "&sort=desc" + mode;
            } else if (value == "4") {
                var orderby = 'list_price';
                url = currentHostUrl + "/category.aspx?" + urlWhereCls + "&pagenum=1&pagesize=" + pagesize + "&orderby="
                    + orderby + "&sort=asc" + mode;
            }
            location.href = url;
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

        //Get query string
        $.urlParam = function (name) {
            var results = new RegExp('[\?&]' + name + '=([^&#]*)')
                              .exec(window.location.search);

            return (results !== null) ? results[1] || 0 : false;
        }

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
            $('#' + items[1]).text(items[0]);
        }

        function ajaxFailed(xmlRequest) {
            console.log(xmlRequest.status + ' \n\r ' + 
                  xmlRequest.statusText + '\n\r' + 
                  xmlRequest.responseText);
        }
        //End: Util functions---------------------------------------------
    </script>
    <div id="all">
        <div id="content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12" id="category_path">
                    </div>
                    <div class="col-lg-3">
                        <!--
              *** MENUS AND FILTERS ***
              _________________________________________________________
              -->
                        <div class="card sidebar-menu mb-4" id="category_panel">
                            <div class="card-header">
                                <h3 class="h4 card-title">Categories</h3>
                            </div>
                            <div class="card-body" id="categories">
                            </div>
                        </div>
                        <div class="card sidebar-menu mb-4" id="brand_panel">
                            <div class="card-header">
                                <h3 class="h4 card-title">Brands <a style="cursor: pointer;" onclick="ClearFilter('brand');" class="btn btn-sm btn-danger pull-right"><i class="fa fa-times-circle"></i>Clear</a></h3>
                            </div>
                            <div class="card-body" id="brands">
                            </div>
                        </div>
                        <div class="card sidebar-menu mb-4" id="colour_panel">
                            <div class="card-header">
                                <h3 class="h4 card-title">Colours <a style="cursor: pointer;" onclick="ClearFilter('colour');" class="btn btn-sm btn-danger pull-right"><i class="fa fa-times-circle"></i>Clear</a></h3>
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
                    <div class="col-lg-9" id="category_product_panel">
                        <div class="box" id="categoryDetail">
                        </div>
                        <div class="box info-bar">
                            <div class="row">
                                <div class="col-md-12 col-lg-4 products-showing" id="productCount"></div>
                                <div class="col-md-12 col-lg-7 products-number-sort">
                                    <form class="form-inline d-block d-lg-flex justify-content-between flex-column flex-md-row">
                                        <div class="products-number" id="productsNumber"></div>
                                        <div class="products-sort-by mt-2 mt-lg-0" id="productSortBy">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <h3 id="lblMessage"></h3>
                        </div>
                        <div class="row products" id="productItems">
                        </div>
                        <div class="pages">
                            <%--<p class="loadMore"><a href="#" class="btn btn-primary btn-lg"><i class="fa fa-chevron-down"></i>Load more</a></p>--%>
                            <nav aria-label="Page navigation example" class="d-flex justify-content-center" id="paginationPanel">
                            </nav>
                        </div>
                    </div>
                    <!-- /.col-lg-9-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>


using System;
using System.Web.Script.Serialization;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;

public partial class product_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        int product_id = 0;
        Int32.TryParse(Request.QueryString["product_id"], out product_id);
        if (product_id > 0)
        {
            using (var context = new WebsiteTTKEntities())
            {
                //Get product data
                ProductControllerModel model = ProductController.GetProductDetailData(product_id);
                if (model != null)
                {
                    //Throw data to client for script to generate the interface of product
                    var productJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model.Product);
                    Product_Data.InnerText = productJson;
                    //Because product slider cannot be modify after script carousel is loaded. 
                    //Thus, we generate the slider on server first to help slider load before carousel script run.
                    MakeupProduct(model.Product);

                    //Push data to client for script to generate the interface of category
                    var thisProductCategoryJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model.Category);
                    ThisProductCategory_Data.InnerText = thisProductCategoryJson;

                    //Push data to client for script to generate the interface of categories
                    var storeCategoriesJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model.Categories);
                    StoreCategories_Data.InnerText = storeCategoriesJson;
                }
            }
        }
    }

    private void MakeupProduct(ProductCurrency qProduct)
    {
        var no_image = "img/no_image.jpg";
        var product_image = "img/no_image.jpg";
        var itemHtml = "<div class='col-md-6'>";
        if (qProduct.product_images != null && qProduct.product_images != "")
        {
            itemHtml += "<div data-slider-id='1' class='owl-carousel shop-detail-carousel'>";
            var images = qProduct.product_images.Split(';');
            for (int i = 0; i < images.Length; i++)
            {
                var image = images[i];
                if (image != "")
                {
                    product_image = image; //Set the first image of this product. Which could use as the fron image
                    itemHtml += "<div class='item'><img src='" + image + "' alt='" + qProduct.product_name + "' class='img-fluid'></div>";
                }
            }
        }
        else
        {
            itemHtml += "<div class='item'><img src='" + no_image + "' alt='" + qProduct.product_name + "' class='img-fluid'></div>";
        }
        itemHtml += "</div>";

        if (qProduct.is_sale != null)
        {
            if (qProduct.is_sale.Value)
            {
                itemHtml += "<div class='ribbon sale'><div class='theribbon'>SALE</div><div class='ribbon-background'></div></div>";
            }
        }

        if (qProduct.is_new != null)
        {
            if (qProduct.is_new.Value)
            {
                itemHtml += "<div class='ribbon new'><div class='theribbon'>NEW</div><div class='ribbon-background'></div></div>";
            }
        }

        if (qProduct.is_gift != null)
        {
            if (qProduct.is_gift.Value)
            {
                itemHtml += "<div class='ribbon gift'><div class='theribbon'>GIFT</div><div class='ribbon-background'></div></div>";
            }
        }
        itemHtml += "</div>";

        //Create price bar
        itemHtml += "<div class='col-md-6'>";
        itemHtml += "<div class='box'>";
        itemHtml += "<h1 class='text-center'>" + qProduct.product_name + "</h1>";
        itemHtml += "<p class='goToDescription'><a href='#details' class='scroll-to'>Scroll to product details, material &amp; care and sizing</a></p>";
        itemHtml += "<p class='goToDescription'><p class='price'>" + qProduct.list_price + qProduct.currency_symbol + "</p>";
        itemHtml += "<p class='text-center buttons'><a href='basket.aspx' class='btn btn-primary'><i class='fa fa-shopping-cart'></i>Add to cart</a><a href='basket.aspx' class='btn "
            + "btn-outline-primary'><i class='fa fa-heart'></i> Add to wishlist</a></p>";
        itemHtml += "</div>";

        //Create thumber buttons
        if (qProduct.product_images != null && qProduct.product_images != "")
        {
            itemHtml += "<div data-slider-id='1' class='owl-thumbs'>";
            var images = qProduct.product_images.Split(';');
            for (int i = 0; i < images.Length; i++)
            {
                var image = images[i];
                if (image != "")
                {
                    product_image = image; //Set the first image of this product. Which could use as the fron image
                    itemHtml += "<button class='owl-thumb-item'><img src='" + image + "' alt='" + qProduct.product_name + "' class='img-fluid'></button>";
                }
            }
            itemHtml += "</div>";
        }
        else
        {
            itemHtml += "<div data-slider-id='1' class='owl-thumbs'><button class='owl-thumb-item'><img src='" + no_image + "' alt='" + qProduct.product_name + "' class='img-fluid'></button></div>";
        }

        itemHtml += "</div>";
        //End of product item

        productMain.InnerHtml = itemHtml;
    }
}
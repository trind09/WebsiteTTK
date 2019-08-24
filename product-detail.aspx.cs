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
                //Get loged in user info
                System.Threading.Tasks.Task<Microsoft.AspNet.Identity.EntityFramework.IdentityUser> user = null;
                if (User.Identity.IsAuthenticated)
                {
                    var userName = User.Identity.Name;
                    var userStore = new Microsoft.AspNet.Identity.EntityFramework.UserStore<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>();
                    var userManager = new Microsoft.AspNet.Identity.UserManager<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>(userStore);
                    user = userManager.FindByNameAsync(userName);
                }

                //Get product data
                ProductControllerModel model = ProductController.GetProductDetailData(product_id, user);
                if (model != null)
                {
                    //Throw data to client for script to generate the interface of product
                    var productDetailJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model);
                    ProductControllerModel_Data.InnerText = productDetailJson;

                    //Because product slider cannot be modify after script carousel is loaded. 
                    //Thus, we generate the slider on server first to help slider load before carousel script run.
                    MakeupProduct(model);
                }
            }
        }
    }

    //Because product slider cannot be modify after script carousel is loaded. 
    //Thus, we generate the slider on server first to help slider load before carousel script run.
    private void MakeupProduct(ProductControllerModel model)
    {
        string hostUrl = Helper.GetHostURL();
        ProductCurrency qProduct = model.Product;
        List<wishlist> wishlists = model.Wishlists;
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
                    itemHtml += "<div class='item'><img src='" + hostUrl + "/" + image + "' alt='" + qProduct.product_name + "' class='img-fluid'></div>";
                }
            }
        }
        else
        {
            itemHtml += "<div class='item'><img src='" + hostUrl + "/" + no_image + "' alt='" + qProduct.product_name + "' class='img-fluid'></div>";
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
        itemHtml += "<p class='goToDescription'><p class='price'>" + Helper.FormatCurrency(qProduct.list_price, qProduct.currency_code) + "</p>";
        if (qProduct.colour_id > 0)
        {
            itemHtml += "<p class='goToDescription'><span class='colour' style='background: " + qProduct.colour_name + "; border-radius: 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> " + qProduct.colour_description + "</p>";
        }
        itemHtml += "<p class='text-center buttons'><a onclick=\"return AddToCart('" + hostUrl + "/basket.aspx?product_id=" + qProduct.product_id + "');\" style='cursor: pointer;' class='btn btn-primary'><i class='fa fa-shopping-cart'></i>Add to cart</a><a style='cursor: pointer;' onclick=\"return AddToWishlist('" + qProduct.product_id + "');\" class='btn "
            + "btn-outline-primary'>";
        if (wishlists != null)
        {
            itemHtml += "<i class='fa fa-heart' id='wishlist_icon'></i> Add to wishlist</a></p>";
        }
        else
        {
            itemHtml += "<i class='fa fa-heart-o' id='wishlist_icon'></i> Add to wishlist</a></p>";
        }
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
                    itemHtml += "<button class='owl-thumb-item'><img src='" + hostUrl + "/" + image + "' alt='" + qProduct.product_name + "' class='img-fluid'></button>";
                }
            }
            itemHtml += "</div>";
        }
        else
        {
            itemHtml += "<div data-slider-id='1' class='owl-thumbs'><button class='owl-thumb-item'><img src='" + hostUrl + "/" + no_image + "' alt='" + qProduct.product_name + "' class='img-fluid'></button></div>";
        }

        itemHtml += "</div>";
        //End of product item

        productMain.InnerHtml = itemHtml;
    }
}
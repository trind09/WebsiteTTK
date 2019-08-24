using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class customer_wishlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string hostUrl = Helper.GetHostURL();
            System.Web.UI.Page page = new System.Web.UI.Page();
            System.Threading.Tasks.Task<Microsoft.AspNet.Identity.EntityFramework.IdentityUser> user;
            if (page.User.Identity.IsAuthenticated)
            {
                var userName = page.User.Identity.Name;
                var userStore = new Microsoft.AspNet.Identity.EntityFramework.UserStore<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>();
                var userManager = new Microsoft.AspNet.Identity.UserManager<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>(userStore);
                user = userManager.FindByNameAsync(userName);
                if (user.Result != null)
                {
                    string userId = user.Result.Id;
                    PushDataToClient(userId, hostUrl);
                }
            } else
            {
                Response.Redirect(hostUrl);
            }
        }
    }

    //Push data to client
    private void PushDataToClient(string userId, string hostUrl)
    {
        ProductControllerModel model = ProductController.GetWishlist(userId);
        var totalProducts = 0;
        if (model.ProductItems != null)
        {
            totalProducts = model.ProductItems.Count();
            string html = "";
            foreach (var item in model.ProductItems)
            {
                html += "<div class='col-lg-3 col-md-4'><div class='product'>";
                var no_image = hostUrl + "/" + "img/no_image.jpg";
                var product_image = "";
                int counter = 0;
                if (item.product_images != null && item.product_images != "")
                {
                    var images = item.product_images.Split(';');
                    for (int i = 0; i < images.Length; i++)
                    {
                        var image = images[i];
                        if (image != "")
                        {
                            if (counter == 0)
                            {
                                product_image = image;
                                ///product-detail.aspx?product_id=327
                                html += "<div class='flip-container'>";
                                html += "<div class='flipper'><div class='front'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>"
                                      + "<img src='" + hostUrl + "/" + image + "' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                            }
                            else if (counter == 1)
                            {
                                html += "<div class='back'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>"
                                      + "<img src='" + hostUrl + "/" + image + "' alt='" + item.product_name + "' class='img-fluid'></a></div></div></div>";
                            }
                            counter++;
                        }
                    }
                    if (counter == 0)
                    {
                        html += "<div class='flip-container'>";
                        html += "<div class='flipper'><div class='front'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>"
                              + "<img src='" + hostUrl + "/" + no_image + "' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                        html += "<div class='back'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>"
                                      + "<img src='" + hostUrl + "/" + no_image + "' alt='" + item.product_name + "' class='img-fluid'></a></div></div></div>";
                        html += "<a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "' class='invisible'>"
                                      + "<img src='" + hostUrl + "/" + no_image + "' alt='" + item.product_name + "' class='img-fluid'></a>";
                    } else if (counter == 1)
                    {
                        html += "<div class='back'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>"
                                      + "<img src='" + hostUrl + "/" + no_image + "' alt='" + item.product_name + "' class='img-fluid'></a></div></div></div>";
                        html += "<a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "' class='invisible'>"
                                      + "<img src='" + hostUrl + "/" + no_image + "' alt='" + item.product_name + "' class='img-fluid'></a>";
                    } else
                    {
                        html += "<a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "' class='invisible'>"
                                      + "<img src='" + hostUrl + "/" + product_image + "' alt='" + item.product_name + "' class='img-fluid'></a>";
                    }
                    html += "<div class='text'><h3><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "'>" + item.product_name + "</a></h3>"
                        + "<p class='price'><del></del>" + Helper.FormatCurrency(item.list_price, item.currency_code) + "</p>"
                        + "<p class='buttons'><a href='" + hostUrl + "/product-detail.aspx?product_id=" + item.product_id + "' class='btn btn-outline-secondary'>View detail</a>"
                        + "<a href='" + hostUrl + "/basket.aspx?product_id=" + item.product_id + "' class='btn btn-primary'><i class='fa fa-shopping-cart'></i>Add to cart</a></p>"
                        + "</div>";

                    if (item.is_sale != null)
                    {
                        if (item.is_sale.Value)
                        {
                            html += "<div class='ribbon sale'><div class='theribbon'>SALE</div><div class='ribbon-background'></div></div>";
                        }
                    }

                    if (item.is_new != null)
                    {
                        if (item.is_new.Value)
                        {
                            html += "<div class='ribbon new'><div class='theribbon'>NEW</div><div class='ribbon-background'></div></div>";
                        }
                    }

                    if (item.is_gift != null)
                    {
                        if (item.is_gift.Value)
                        {
                            html += "<div class='ribbon gift'><div class='theribbon'>GIFT</div><div class='ribbon-background'></div></div>";
                        }
                    }
                }
                html += "</div></div>";
            }
            wishlist_region.InnerHtml = html;
        }

        if (model != null)
        {
            ProductControllerModel model1 = new ProductControllerModel();
            model1.TotalProducts = totalProducts;
            var modelJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model1);
            Wishlist_Data.InnerText = modelJson;
        }
    }
}
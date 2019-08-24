using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class update_basket : System.Web.UI.Page
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
                    UpdateBasket(userId, hostUrl);
                }
            }
            else
            {
                Response.Redirect(hostUrl);
            }
        }
    }

    private void UpdateBasket(string userId, string hostUrl)
    {
        string basketUrl = hostUrl + "/basket.aspx";
        int removeProductId = 0;
        Int32.TryParse(Request.QueryString["remove_product_id"], out removeProductId);
        int orderId = 0;
        Int32.TryParse(Request.QueryString["order_id"], out orderId);
        string ids = Request.QueryString["ids"];
        string quantities = Request.QueryString["quantities"];
        string coupon_code = Request.QueryString["coupon_code"];
        if (removeProductId > 0 && orderId > 0)
        {
            ProductControllerModel model = ProductController.RemoveProductFromOrder(removeProductId, orderId, userId, OrderStatus.Status.New);
            if (model.Success)
            {
                Response.Redirect(basketUrl);
            } else
            {
                ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.parent.ShowMessage(0,\"" + model.Message + "\"); window.parent.CloseUpdateBasket();", true);
            }
        } else if (!String.IsNullOrEmpty(ids) && !String.IsNullOrEmpty(quantities) && orderId > 0)
        {
            ProductControllerModel model = ProductController.UpdateOrderQuantity(ids, quantities, orderId, userId, OrderStatus.Status.New);
            if (model.Success)
            {
                Response.Redirect(basketUrl);
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.parent.ShowMessage(0,\"" + model.Message + "\"); window.parent.CloseUpdateBasket();", true);
            }
        } else if (!String.IsNullOrEmpty(coupon_code) && orderId > 0)
        {
            ProductControllerModel model = ProductController.UpdateOrderDiscount(coupon_code, orderId, userId, OrderStatus.Status.New);
            if (model.Success)
            {
                Response.Redirect(basketUrl);
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.parent.ShowMessage(0,\"" + model.Message + "\"); window.parent.CloseUpdateBasket();", true);
            }
        }
        else
        {
            Response.Redirect(basketUrl);
        }
    }
}
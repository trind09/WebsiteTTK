using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class basket :  System.Web.UI.Page
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
                    BindData(userId, hostUrl);
                }
            }
            else
            {
                Response.Redirect(hostUrl);
            }
        }
    }

    private void BindData(string userId, string hostUrl)
    {
        int product_id = 0;
        Int32.TryParse(Request.QueryString["product_id"], out product_id);
        //Get product data
        ProductControllerModel model = ProductController.AddProductToBasket(product_id, userId);
        BasketControllerModel basket = ProductController.GetBasket(product_id, userId);
        //Throw data to client for script to generate the interface of product
        var productDetailJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(basket);
        Server_Data.InnerText = productDetailJson;
    }
}
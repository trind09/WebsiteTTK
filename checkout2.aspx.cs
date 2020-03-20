using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class checkout2 : System.Web.UI.Page
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
        order order = OrderHelper.GetNewCreatedOrder(userId);
        if (order != null)
        {
            DeliveryModel model = DeliveryHelper.GetDeliveryModel(order);
            model.UserId = userId;

            //Throw data to client
            var clientObjsJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model);
            CheckOut2_Data.InnerText = clientObjsJson;
        } else
        {
            Response.Redirect(hostUrl);
        }
    }

    protected void btnSubmitPaymentMethod_Click(object sender, EventArgs e)
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

                var deliveryId = Helper.GetPlainTextFromHtml(txtDeliveryId.Text);
                var currentUserId = Helper.GetPlainTextFromHtml(txtUserId.Text);
                if (currentUserId == userId && !String.IsNullOrEmpty(currentUserId))
                {
                    int delivery_id = 0;
                    int.TryParse(deliveryId, out delivery_id);
                    if (delivery_id > 0)
                    {
                        var result = OrderHelper.UpdateNewOrderShippingCost(userId, delivery_id);
                        if (result != null)
                        {
                            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + result + "\",true);", true);
                        } else
                        {
                            Response.Redirect(hostUrl + "/checkout3.aspx");
                        }
                    } else
                    {
                        ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + "Missing delivery method!" + "\",true);", true);
                    }
                } else
                {
                    ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + "Current user doesn't fix your query!" + "\",true);", true);
                }
            } else
            {
                ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + "Please login to continue!" + "\",true);", true);
            }
        }
        else
        {
            Response.Redirect(hostUrl);
        }
    }
}
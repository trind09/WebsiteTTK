using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Web;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Home_Page_URL.InnerText = Helper.GetHostURL();
        if (!IsPostBack)
        {
            if (User.Identity.IsAuthenticated)
            {
                StatusText.Text = string.Format("Hello {0}!!", User.Identity.GetUserName());
                LoginStatus.Visible = true;
                LogoutButton.Visible = true;
            }
            else
            {
                LoginForm.Visible = true;
            }
        }
    }

    protected void SignIn(object sender, EventArgs e)
    {
        var userStore = new UserStore<IdentityUser>();
        var userManager = new UserManager<IdentityUser>(userStore);
        var user = userManager.Find(LoginUserName.Text, LoginPassword.Text);

        if (user != null)
        {
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);

            authenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = false }, userIdentity);
            ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script language='javascript'>RefreshParent()</script>");
        }
        else
        {
            StatusText.Text = "Invalid username or password.";
            LoginStatus.Visible = true;
        }
    }

    protected void SignOut(object sender, EventArgs e)
    {
        var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
        authenticationManager.SignOut();
        Page.Response.Redirect(Page.Request.Url.ToString(), true);
    }
}
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Web;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (User.Identity.IsAuthenticated)
            {
                StatusText.Text = string.Format("Hello {0}!!", User.Identity.GetUserName());
                LoginStatus.Visible = true;
                LogoutButton.Visible = true;
                RegisterForm.Visible = false;
            }
            else
            {
                LoginForm.Visible = true;
            }
        }
    }

    protected void CreateUser_Click(object sender, EventArgs e)
    {
        // Default UserStore constructor uses the default connection string named: DefaultConnection
        string unsatifyMessage = "";
        string userName = Helper.StripHTML(UserName.Text);
        string password = Helper.StripHTML(Password.Text);
        string confirmPassword = Helper.StripHTML(ConfirmPassword.Text);
        string email = Helper.StripHTML(Email.Text);
        string phoneNumber = Helper.StripHTML(PhoneNumber.Text);
        if (password != confirmPassword)
        {
            unsatifyMessage = "<p style='color: red;'>Confirm password doesn't match!</p>";
        }
        if (!Helper.IsValidUsername(userName) || userName.Trim().Length == 0)
        {
            unsatifyMessage += "<p style='color: red;'>Username is invalid!</p>";
        }
        if (!Helper.IsValidPassword(password) || password.Trim().Length == 0)
        {
            unsatifyMessage += "<p style='color: red;'>Password at least 6 characters and has no white space!</p>";
        }
        if (!Helper.IsValidEmail(email) || email.Trim().Length == 0)
        {
            unsatifyMessage += "<p style='color: red;'>Email is invalid!</p>";
        }
        if (unsatifyMessage != "")
        {
            StatusMessage.Text = unsatifyMessage;
        }
        else
        {
            StatusMessage.Text = "";
            var userStore = new UserStore<IdentityUser>();
            var manager = new UserManager<IdentityUser>(userStore);
            var user = new IdentityUser() { UserName = userName, Email = email, PhoneNumber = phoneNumber };

            IdentityResult result = manager.Create(user, password);

            if (result.Succeeded)
            {
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
                authenticationManager.SignIn(new AuthenticationProperties() { }, userIdentity);
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                StatusMessage.Text = result.Errors.FirstOrDefault();
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
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
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
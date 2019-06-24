using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Web;

public partial class customer_account : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (User.Identity.IsAuthenticated)
            {
                //StatusText.Text = string.Format("Hello {0}!!", User.Identity.GetUserName());
                //LoginStatus.Visible = true;
                //LogoutButton.Visible = true;
                //RegisterForm.Visible = false;
                var userName = User.Identity.GetUserName();
                var userStore = new UserStore<IdentityUser>();
                var userManager = new UserManager<IdentityUser>(userStore);
                System.Threading.Tasks.Task<IdentityUser> user = userManager.FindByNameAsync(userName);
                if (user != null)
                {
                    PhoneNumber.Text = user.Result.PhoneNumber;
                    Email.Text = user.Result.Email;
                    AspNetUserAddress address = UserHelper.GetUserAddressByUserId(user.Result.Id);
                }
            }
            else
            {
                Page.Response.Redirect(Helper.GetHostURL(), true);
            }
        }
    }

    protected void lbnChangePassword_Click(object sender, EventArgs e)
    {
        string oldPassword = password_old.Text;
        string newPassword = password_1.Text;
        string repeatPassword = password_2.Text;
        var userName = User.Identity.GetUserName();
        if (newPassword != repeatPassword)
        {
            lblChangePasswordMessage.Text = "<span style='color: red;'>New password doesn't meet repeat password!</span>";
        } else if (userName != null)
        {
            var userStore = new UserStore<IdentityUser>();
            var userManager = new UserManager<IdentityUser>(userStore);
            var user = userManager.Find(userName, oldPassword);
            if (user != null)
            {
                var changePasswordResult = UserHelper.ChangePasswordAsync(userName, newPassword);
                if (changePasswordResult.Status != System.Threading.Tasks.TaskStatus.Faulted)
                {
                    if (changePasswordResult.Result.Succeeded)
                    {
                        lblChangePasswordMessage.Text = "<span style='color: green;'>Update password successful!</span>";
                    }
                    else
                    {
                        lblChangePasswordMessage.Text = "<span style='color: red;'>Update password fail!</span>";
                    }
                } else
                {
                    lblChangePasswordMessage.Text = "<span style='color: red;'>Update password fail!</span>";
                }
            }
            else
            {
                lblChangePasswordMessage.Text = "<span style='color: red;'>Invalid old password!</span>";
            }
        } else
        {
            Page.Response.Redirect(Helper.GetHostURL(), true);
        }
    }
}
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Security.Principal;
using System.Web;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                login_link.Visible = false;
                register_link.Visible = false;
                profile_link.Visible = true;
                log_out_link.Visible = true;
                log_out_hyperlink.HRef = "logout.aspx?redirect=" + Page.Request.Url.ToString();
            }
        }
    }
}

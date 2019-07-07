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
            PushDataToClient();
        }
    }

    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get Category data
            System.Collections.Generic.IEnumerable<category> listOfCategories = (from s in context.categories.AsEnumerable() where s.is_publish == true && s.is_menu == true
                                                      select new category
                                                      {
                                                          category_id = s.category_id,
                                                          category_name = s.category_name,
                                                          category_description = s.category_description,
                                                          category_images = s.category_images,
                                                          category_url = s.category_url,
                                                          create_date = s.create_date,
                                                          parent_id = s.parent_id,
                                                          is_publish = s.is_publish,
                                                          is_menu = s.is_menu
                                                      }).ToList();

            string currentHostUrl = Helper.GetHostURL();
            string menuLiItems = "<li class='nav-item'><a href='" + currentHostUrl + "' class='nav-link active'>Home</a></li>";
            System.Collections.Generic.IEnumerable<category> parentCategories = from t in listOfCategories where t.parent_id == null select t;
            foreach (var item in parentCategories)
            {
                string url = currentHostUrl + "/category.aspx?category_id=" + item.category_id;
                menuLiItems += "<li class='nav-item dropdown menu-large'><a href='" + url + "' data-toggle='dropdown' data-hover='dropdown' data-delay='200' class='dropdown-toggle nav-link'>" + item.category_name + "<b class='caret'></b></a>";
                System.Collections.Generic.IEnumerable<category> firstChildCategories = from t in listOfCategories where t.parent_id == item.category_id select t;
                if (firstChildCategories.Count() > 0)
                {
                    foreach (var firstChild in firstChildCategories)
                    {
                        url = currentHostUrl + "/category.aspx?category_id=" + firstChild.category_id;
                        menuLiItems += "<li class='nav-item dropdown menu-large'><a href='" + url + "' data-toggle='dropdown' data-hover='dropdown' data-delay='200' class='dropdown-toggle nav-link'>" + item.category_name + "<b class='caret'></b></a>";
                    }
                }
            }
        }
    }
}

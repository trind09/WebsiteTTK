﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Script.Serialization;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var hostUrl = Helper.GetHostURL();
            var defaultShippingFee = Helper.GetDefaultShippingFee();
            var defaultTax = Helper.GetDefaultTax();
            var countries = Helper.GetCountries();

            var isUserLogedIn = HttpContext.Current.User.Identity.IsAuthenticated;
            var userName = Page.User.Identity.Name;
            var userStore = new Microsoft.AspNet.Identity.EntityFramework.UserStore<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>();
            var userManager = new Microsoft.AspNet.Identity.UserManager<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>(userStore);
            var user = userManager.FindByNameAsync(userName);
            string userId = null;
            if (user.Result != null)
            {
                userId = user.Result.Id;
            }

            PushDataToClient();

            //Push master page data to client
            MasterPageData data = new MasterPageData();
            data.HostUrl = hostUrl;
            data.IsUserLogedIn = isUserLogedIn;
            data.User = user.Result;
            data.Basket = ProductController.GetBasket(0, userId);
            data.DefaultShippingFee = defaultShippingFee;
            data.DefaultTax = defaultTax;
            data.Countries = countries;
            var dataJson = new JavaScriptSerializer().Serialize(data);
            MasterPageDataDiv.InnerHtml = dataJson;
        }
    }

    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get Category data
            System.Collections.Generic.IEnumerable<procategory> listOfCategories = (from s in context.procategories.AsEnumerable() where s.is_publish == true && s.is_menu == true
                                                      select new procategory
                                                      {
                                                          category_id = s.category_id,
                                                          category_name = s.category_name,
                                                          category_description = s.category_description,
                                                          category_images = s.category_images,
                                                          category_url = s.category_url,
                                                          create_date = s.create_date,
                                                          parent_id = s.parent_id,
                                                          is_publish = s.is_publish,
                                                          is_menu = s.is_menu,
                                                          is_label = s.is_label,
                                                          is_collection = s.is_collection
                                                      }).ToList();

            string currentHostUrl = Helper.GetHostURL();
            string isActive = Helper.IsHomePage() ? " active" : "";
            string menuLiItems = "<li class='nav-item'><a href='" + currentHostUrl + "' class='nav-link" + isActive + "'>Home</a></li>";
            System.Collections.Generic.IEnumerable<procategory> grandFatherCategories = (from t in listOfCategories where t.parent_id == 0 select t).ToList();
            foreach (var item in grandFatherCategories)
            {
                string grandfather_category_url = currentHostUrl + "/category.aspx?category_id=" + item.category_id;
                if (!String.IsNullOrEmpty(item.category_url))
                {
                    grandfather_category_url = item.category_url;
                }
                bool isLabel = item.is_label == null ? false : item.is_label.Value;
                isActive = Request.QueryString["category_id"] == item.category_id + "" ? " active" : "";
                System.Collections.Generic.IEnumerable<procategory> firstChildCategories = (from t in listOfCategories where t.parent_id == item.category_id select t).ToList();
                if (firstChildCategories.Count() > 0)
                {
                    if (isLabel)
                    {
                        menuLiItems += "<li class='nav-item dropdown menu-large'><span style='cursor: pointer;' data-toggle='dropdown' data-hover='dropdown' data-delay='200' class='dropdown-toggle nav-link" + isActive + "'>" + item.category_name + "<b class='caret'></b></span>";
                    }
                    else
                    {
                        menuLiItems += "<li class='nav-item dropdown menu-large'><a data-toggle='dropdown' data-hover='dropdown' data-delay='200' class='dropdown-toggle nav-link" + isActive + "' href='" + grandfather_category_url + "'>" + item.category_name + "<b class='caret'></b></a>";
                    }

                    menuLiItems += "<ul class='dropdown-menu megamenu'><li><div class='row'>";
                    foreach (var firstChild in firstChildCategories)
                    {
                        var father_category_url = currentHostUrl + "/category.aspx?category_id=" + firstChild.category_id;
                        if (!String.IsNullOrEmpty(firstChild.category_url))
                        {
                            father_category_url = firstChild.category_url;
                        }
                        isLabel = firstChild.is_label == null ? false : firstChild.is_label.Value;
                        isActive = Request.QueryString["category_id"] == firstChild.category_id + "" ? " active" : "";
                        
                        System.Collections.Generic.IEnumerable<procategory> secondChildCategories = (from t in listOfCategories where t.parent_id == firstChild.category_id select t).ToList();
                        if (secondChildCategories.Count() > 0)
                        {
                            if (isLabel)
                            {
                                menuLiItems += "<div class='col-md-6 col-lg-3'><h5><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + firstChild.category_name + "</span></h5>";
                            }
                            else
                            {
                                menuLiItems += "<div class='col-md-6 col-lg-3'><h5><a class='nav-link" + isActive + "' href='" + father_category_url + "'>" + firstChild.category_name + "</a></h5>";
                            }

                            menuLiItems += "<ul class='list-unstyled mb-3'>";
                            foreach (var secondChild in secondChildCategories)
                            {
                                var child_category_url = currentHostUrl + "/category.aspx?category_id=" + secondChild.category_id;
                                if (!String.IsNullOrEmpty(secondChild.category_url))
                                {
                                    child_category_url = secondChild.category_url;
                                }
                                isLabel = secondChild.is_label == null ? false : secondChild.is_label.Value;
                                isActive = Request.QueryString["category_id"] == secondChild.category_id + "" ? " active" : "";
                                if (isLabel)
                                {
                                    menuLiItems += "<li class='nav-item'><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + secondChild.category_name + "</span></li>";
                                } else
                                {
                                    menuLiItems += "<li class='nav-item'><a href='" + child_category_url + "' class='nav-link" + isActive + "'>" + secondChild.category_name + "</a></li>";
                                }
                            }
                            menuLiItems += "</ul>";
                        } else
                        {
                            if (isLabel)
                            {
                                menuLiItems += "<div class='nav-item' style='margin-right: 35px;'><span class='nav-link" + isActive + "'>" + firstChild.category_name  + "</span>";
                            }
                            else
                            {
                                menuLiItems += "<div class='nav-item' style='margin-right: 35px;'><a class='nav-link" + isActive + "' href='" + father_category_url + "'>" + firstChild.category_name + "</a>";
                            }
                        }
                        menuLiItems += "</div>";
                    }
                    menuLiItems += "</div></li></ul>";
                } else
                {
                    if (isLabel)
                    {
                        menuLiItems += "<li class='nav-item'><span style='cursor: pointer;' class='nav-link" + isActive + "'>" + item.category_name + "</span>";
                    }
                    else
                    {
                        menuLiItems += "<li class='nav-item'><a class='nav-link" + isActive + "' href='" + grandfather_category_url + "'>" + item.category_name + "</a>";
                    }
                }
                menuLiItems += "</li>";
            }
            Mega_Menu_UL.InnerHtml = menuLiItems;
        }
    }
}

public class MasterPageData
{
    public string HostUrl { get; set; }
    public bool IsUserLogedIn { get; set; }
    public BasketControllerModel Basket { get; set; }
    public IdentityUser User { get; set; }
    public decimal DefaultShippingFee { get; set; }
    public double DefaultTax { get; set; }
    public List<string> Countries { get; set; }
}
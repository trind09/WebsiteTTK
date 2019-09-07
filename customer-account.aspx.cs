﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
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
                var userName = User.Identity.GetUserName();
                var userStore = new UserStore<IdentityUser>();
                var userManager = new UserManager<IdentityUser>(userStore);
                System.Threading.Tasks.Task<IdentityUser> user = userManager.FindByNameAsync(userName);
                if (user.Result != null)
                {
                    //Because of updating user's profile, thus it use home address.
                    List<AspNetUserAddress> addresses = UserHelper.GetUserAddressByUserId(user.Result.Id, UserHelper.AddressType.HomeAddress);
                    if (addresses.Count > 0)
                    {
                        AspNetUserAddress address = addresses.FirstOrDefault();
                        firstname.Text = address.Firstname;
                        lastname.Text = address.Lastname;
                        company.Text = address.Company;
                        street.Text = address.Street;
                        city.Text = address.City;
                        zip.Text = address.Zip;
                        state.Text = address.State;
                        SetupCountryDropDownList(address.Country);
                        if (address.Birthday != null)
                        {
                            string globalDateFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
                            birthday.Value = address.Birthday.Value.ToString(globalDateFormat);
                        }
                        SetupGenderDropDownList(UserHelper.ConvertBooleanToGender(address.Gender));

                        //This code block can help to bypass ASP user's email and phone number. And used only home address for user's profile
                        //Because of updating user's profile. It can get ASP user's email if profile address's email is empty.
                        if (String.IsNullOrEmpty(address.Email))
                        {
                            Email.Text = user.Result.Email;
                        } else
                        {
                            Email.Text = address.Email;
                        }

                        //Because of updating user's profile. It can get ASP user's phone number if profile address's phone number is empty.
                        if (String.IsNullOrEmpty(address.PhoneNumber))
                        {
                            PhoneNumber.Text = user.Result.PhoneNumber;
                        }
                        else
                        {
                            PhoneNumber.Text = address.PhoneNumber;
                        }
                    } else
                    {
                        PhoneNumber.Text = user.Result.PhoneNumber;
                        Email.Text = user.Result.Email;
                        SetupCountryDropDownList(null);
                        SetupGenderDropDownList(null);
                    }
                }
                currentDateFormat.Value = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
            }
            else
            {
                Page.Response.Redirect(Helper.GetHostURL(), true);
            }
        }
    }

    #region Setup Dropdownlist
    private void SetupGenderDropDownList(string option)
    {
        gender.Items.Clear();
        if (option == "Male")
        {
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Male", "Male", true));
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Female", "Female"));
        }
        else if (option == "Female")
        {
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Male", "Male"));
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Female", "Female", true));
        } else
        {
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("--Select--", "", true));
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Male", "Male"));
            gender.Items.Add(new System.Web.UI.WebControls.ListItem("Female", "Female"));
        }
    }

    private void SetupCountryDropDownList(string option)
    {
        //Refresh dropdownlist
        country.Items.Clear();
        country.SelectedIndex = -1;

        country.Items.Add(new System.Web.UI.WebControls.ListItem("--Select--", ""));
        string[] countries = UserHelper.Countries();
        int selectedIndex = 0;
        for (int i = 0; i < countries.Length; i++)
        {
            var item = countries[i];
            if (item == option)
            {
                selectedIndex = i + 1;
            }
            country.Items.Add(new System.Web.UI.WebControls.ListItem(item, item));
        }
        country.SelectedIndex = selectedIndex;
    }
    #endregion

    #region Button Action
    protected void lbnChangePassword_Click(object sender, EventArgs e)
    {
        string oldPassword = password_old.Text;
        string newPassword = password_1.Text;
        string repeatPassword = password_2.Text;
        var userName = User.Identity.GetUserName();
        if (newPassword != repeatPassword)
        {
            lblChangePasswordMessage.Text = "<span style='color: red;'>New password doesn't meet repeat password!</span>";
        }
        else if (userName != null)
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
                }
                else
                {
                    lblChangePasswordMessage.Text = "<span style='color: red;'>Update password fail!</span>";
                }
            }
            else
            {
                lblChangePasswordMessage.Text = "<span style='color: red;'>Invalid old password!</span>";
            }
        }
        else
        {
            Page.Response.Redirect(Helper.GetHostURL(), true);
        }
    }

    protected void btnSubmitUserAddress_Click(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            var userName = User.Identity.GetUserName();
            var userStore = new UserStore<IdentityUser>();
            var userManager = new UserManager<IdentityUser>(userStore);
            System.Threading.Tasks.Task<IdentityUser> user = userManager.FindByNameAsync(userName);
            if (user.Result != null)
            {
                //Because of updating user's profile, thus it use home address.
                List<AspNetUserAddress> addresses = UserHelper.GetUserAddressByUserId(user.Result.Id, UserHelper.AddressType.HomeAddress);
                if (addresses.Count > 0)
                {
                    AspNetUserAddress address = addresses.FirstOrDefault();
                    address.Firstname = Helper.GetPlainTextFromHtml(firstname.Text);
                    address.Lastname = Helper.GetPlainTextFromHtml(lastname.Text);
                    address.Company = Helper.GetPlainTextFromHtml(company.Text);
                    address.Street = Helper.GetPlainTextFromHtml(street.Text);
                    address.City = Helper.GetPlainTextFromHtml(city.Text);
                    address.Zip = Helper.GetPlainTextFromHtml(zip.Text);
                    address.State = Helper.GetPlainTextFromHtml(state.Text);
                    if (!Helper.IsValidEmail(Email.Text))
                    {
                        string message = "Invalid email!";
                        ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                    }
                    else
                    {
                        address.Email = Helper.GetPlainTextFromHtml(Email.Text);
                        address.PhoneNumber = Helper.GetPlainTextFromHtml(PhoneNumber.Text);
                        address.Country = Helper.GetPlainTextFromHtml(country.SelectedValue);
                        try
                        {
                            string globalDateFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
                            DateTime biDate = DateTime.ParseExact(Helper.GetPlainTextFromHtml(birthday.Value), globalDateFormat, System.Globalization.CultureInfo.InvariantCulture);
                            address.Birthday = biDate;
                        }
                        catch
                        {
                            address.Birthday = null;
                        }
                        address.Gender = UserHelper.ConvertStringToGender(Helper.GetPlainTextFromHtml(gender.SelectedValue));

                        try
                        {
                            UserHelper.UpdateUserAddresses(new System.Collections.Generic.List<AspNetUserAddress> { address });
                            string message = "Update successful!";
                            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                        }
                        catch (Exception ex)
                        {
                            string message = "Update fail! " + ex.Message;
                            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                        }
                    }
                } else
                {
                    AspNetUserAddress address = new AspNetUserAddress();
                    address.UserId = user.Result.Id;
                    //Because of updating user's profile, thus it use home address.
                    address.AddressType = UserHelper.AddressType.HomeAddress.ToString();
                    address.Firstname = Helper.GetPlainTextFromHtml(firstname.Text);
                    address.Lastname = Helper.GetPlainTextFromHtml(lastname.Text);
                    address.Company = Helper.GetPlainTextFromHtml(company.Text);
                    address.Street = Helper.GetPlainTextFromHtml(street.Text);
                    address.City = Helper.GetPlainTextFromHtml(city.Text);
                    address.Zip = Helper.GetPlainTextFromHtml(zip.Text);
                    address.State = Helper.GetPlainTextFromHtml(state.Text);
                    if (!Helper.IsValidEmail(Email.Text))
                    {
                        string message = "Invalid email!";
                        ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                    }
                    else
                    {
                        address.Email = Helper.GetPlainTextFromHtml(Email.Text);
                        address.PhoneNumber = Helper.GetPlainTextFromHtml(PhoneNumber.Text);
                        address.Country = Helper.GetPlainTextFromHtml(country.SelectedValue);
                        try
                        {
                            string globalDateFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
                            DateTime biDate = DateTime.ParseExact(Helper.GetPlainTextFromHtml(birthday.Value), globalDateFormat, System.Globalization.CultureInfo.InvariantCulture);
                            address.Birthday = biDate;
                        }
                        catch
                        {
                            address.Birthday = null;
                        }
                        address.Gender = UserHelper.ConvertStringToGender(Helper.GetPlainTextFromHtml(gender.SelectedValue));

                        try
                        {
                            UserHelper.UpdateUserAddresses(new List<AspNetUserAddress> { address });
                            string message = "Update successful!";
                            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                        }
                        catch (Exception ex)
                        {
                            string message = "Update fail! " + ex.Message;
                            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                        }
                    }
                }
            }
        }
        else
        {
            Page.Response.Redirect(Helper.GetHostURL(), true);
        }
    }
    #endregion
}
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class checkout1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (User.Identity.IsAuthenticated)
            {
                Customer customer = new Customer();
                customer.Countries = UserHelper.Countries();
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
                        customer.AspNetUserAddress = address;

                        if (address.Birthday != null)
                        {
                            string globalDateFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
                            customer.Birthday = address.Birthday.Value.ToString(globalDateFormat);
                        }

                        //This code block can help to bypass ASP user's email and phone number. And used only home address for user's profile
                        //Because of updating user's profile. It can get ASP user's email if profile address's email is empty.
                        if (String.IsNullOrEmpty(address.Email))
                        {
                            customer.Email = user.Result.Email;
                        }
                        else
                        {
                            customer.Email = address.Email;
                        }

                        //Because of updating user's profile. It can get ASP user's phone number if profile address's phone number is empty.
                        if (String.IsNullOrEmpty(address.PhoneNumber))
                        {
                            customer.PhoneNumber = user.Result.PhoneNumber;
                        }
                        else
                        {
                            customer.PhoneNumber = address.PhoneNumber;
                        }
                    }
                    else
                    {
                        customer.PhoneNumber = user.Result.PhoneNumber;
                        customer.Email = user.Result.Email;
                    }
                    txtFirstname.Text = customer.AspNetUserAddress.Firstname;
                    txtLastname.Text = customer.AspNetUserAddress.Lastname;
                    txtCompany.Text = customer.AspNetUserAddress.Company;
                    txtStreet.Text = customer.AspNetUserAddress.Street;
                    txtCity.Text = customer.AspNetUserAddress.City;
                    txtZip.Text = customer.AspNetUserAddress.Zip;
                    txtState.Text = customer.AspNetUserAddress.State;
                    txtPhoneNumber.Text = customer.PhoneNumber;
                    txtEmail.Text = customer.Email;
                    SetupCountryDropDownList(customer);
                }
            }
            else
            {
                Page.Response.Redirect(Helper.GetHostURL(), true);
            }
        }
    }

    private void SetupCountryDropDownList(Customer customer)
    {
        var selectedCountry = customer.AspNetUserAddress.Country;
        var countries = customer.Countries;
        //Refresh dropdownlist
        ddlCountry.Items.Clear();
        ddlCountry.SelectedIndex = -1;

        ddlCountry.Items.Add(new System.Web.UI.WebControls.ListItem("--Select--", ""));
        int selectedIndex = 0;
        for (int i = 0; i < countries.Length; i++)
        {
            var item = countries[i];
            if (item == selectedCountry)
            {
                selectedIndex = i + 1;
            }
            ddlCountry.Items.Add(new System.Web.UI.WebControls.ListItem(item, item));
        }
        ddlCountry.SelectedIndex = selectedIndex;
    }

    protected void lbnUpdateAddress_Click(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            List<string> messages = new List<string>();

            var userName = User.Identity.GetUserName();
            var userStore = new UserStore<IdentityUser>();
            var userManager = new UserManager<IdentityUser>(userStore);
            System.Threading.Tasks.Task<IdentityUser> user = userManager.FindByNameAsync(userName);
            if (user.Result != null)
            {
                Customer customer = new Customer();
                customer.AspNetUser = UserHelper.GetUserByUserId(user.Result.Id);
                customer.AspNetUserAddress = new AspNetUserAddress();

                string firstname = Helper.GetPlainTextFromHtml(txtFirstname.Text);
                if (String.IsNullOrEmpty(firstname))
                {
                    messages.Add("Please enter your first name!");
                }
                else if (firstname.Length > 149)
                {
                    messages.Add("Your first name is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.Firstname = firstname;
                }
                string lastname = Helper.GetPlainTextFromHtml(txtLastname.Text);
                if (String.IsNullOrEmpty(lastname))
                {
                    messages.Add("Please enter your last name!");
                }
                else if (lastname.Length > 149)
                {
                    messages.Add("Your last name is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.Lastname = lastname;
                }
                string company = Helper.GetPlainTextFromHtml(txtCompany.Text);
                if (company.Length > 249)
                {
                    messages.Add("Company is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.Company = company;
                }
                string street = Helper.GetPlainTextFromHtml(txtStreet.Text);
                if (String.IsNullOrEmpty(street))
                {
                    messages.Add("Please enter street!");
                }
                else if (street.Length > 299)
                {
                    messages.Add("Street is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.Street = street;
                }
                string city = Helper.GetPlainTextFromHtml(txtCity.Text);
                if (String.IsNullOrEmpty(city))
                {
                    messages.Add("Please enter city!");
                }
                else if (city.Length > 249)
                {
                    messages.Add("City is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.City = city;
                }
                string zip = Helper.GetPlainTextFromHtml(txtZip.Text);
                if (zip.Length > 149)
                {
                    messages.Add("Zip is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.Zip = zip;
                }
                string state = Helper.GetPlainTextFromHtml(txtState.Text);
                if (state.Length > 149)
                {
                    messages.Add("State is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.State = state;
                }
                string phoneNumber = Helper.GetPlainTextFromHtml(txtPhoneNumber.Text);
                if (String.IsNullOrEmpty(phoneNumber))
                {
                    messages.Add("Please enter your phone number!");
                }
                else if (phoneNumber.Length > 49)
                {
                    messages.Add("Your phone number is too long!");
                }
                else
                {
                    customer.AspNetUserAddress.PhoneNumber = phoneNumber;
                }
                string email = Helper.GetPlainTextFromHtml(txtEmail.Text);
                if (String.IsNullOrEmpty(email))
                {
                    messages.Add("Please enter your email!");
                }
                else if (email.Length > 149)
                {
                    messages.Add("Your email is too long!");
                }
                else if (!Helper.IsValidEmail(email))
                {
                    messages.Add("Your email is not correct!");
                }
                else
                {
                    customer.AspNetUserAddress.Email = email;
                }
                string country = ddlCountry.SelectedValue;
                if (String.IsNullOrEmpty(country))
                {
                    messages.Add("Please select country!");
                } else
                {
                    customer.AspNetUserAddress.Country = ddlCountry.SelectedValue;
                }
                if (messages.Count > 0)
                {
                    string message = string.Join("</br>", messages.ToArray());
                    ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + message + "\",true);", true);
                }
                else
                {
                    string result = CustomerHelper.UpdateCustomerAddress(customer);
                    if (result != null)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + result + "\",true);", true);
                    } else
                    {
                        Response.Redirect(Helper.GetHostURL() + "/checkout2.aspx");
                    }
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + "Please login to continue!" + "\",true);", true);
            }
        } else
        {
            ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "window.ShowMessage(0,\"" + "Please login to continue!" + "\",true);", true);
        }
    }
}
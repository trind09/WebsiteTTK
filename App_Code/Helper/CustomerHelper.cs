using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CustomerHelper
/// </summary>
public class CustomerHelper
{
    public CustomerHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteCustomerByIds(List<string> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.AspNetUsers.SingleOrDefault(b => b.Id == id);
                if (result != null)
                {
                    context.AspNetUsers.Attach(result);
                    context.AspNetUsers.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatecustomers(List<Customer> customers)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (Customer item in customers)
            {
                var userStore = new Microsoft.AspNet.Identity.EntityFramework.UserStore<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>();
                var manager = new Microsoft.AspNet.Identity.UserManager<Microsoft.AspNet.Identity.EntityFramework.IdentityUser>(userStore);

                var user = manager.FindByIdAsync(item.AspNetUser.Id).Result;
                if (user != null)
                {
                    user.Email = item.AspNetUser.Email;
                    user.PhoneNumber = item.AspNetUser.PhoneNumber;

                    Microsoft.AspNet.Identity.IdentityResult result = manager.UpdateAsync(user).Result;
                }
                else
                {
                    user = new Microsoft.AspNet.Identity.EntityFramework.IdentityUser() { UserName = item.AspNetUser.UserName, Email = item.AspNetUser.Email, PhoneNumber = item.AspNetUser.PhoneNumber };

                    Microsoft.AspNet.Identity.IdentityResult result = manager.CreateAsync(user, item.Password).Result;
                }
            }
        }
    }

    public static List<Customer> GetAllCustomer()
    {
        using (var context = new WebsiteTTKEntities())
        {
            List<Customer> customers = new List<Customer>();
            var users = context.AspNetUsers.ToList();
            foreach (var user in users)
            {
                Customer customer = new Customer();
                AspNetUserAddress address = context.AspNetUserAddresses.SingleOrDefault(x => x.UserId == user.Id);
                customer.AspNetUserAddress = address;
                customer.AspNetUser = user;
                string globalDateFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateFormat"];
                customer.Birthday = address.Birthday.Value.ToString(globalDateFormat);
                customer.City = address.City;
                List<string> countries = Helper.GetCountries();
                if (countries != null)
                {
                    customer.Countries = countries.ToArray();
                }
                customer.Email = user.Email;
                customer.FirstName = address.Firstname;
                customer.LastName = address.Lastname;
                customer.PhoneNumber = address.PhoneNumber;
                customer.Street = address.Street;
                customer.ZipCode = address.Zip;

                customers.Add(customer);
            }
            return customers;
        }
    }

    /// <summary>
    /// Update customer address
    /// </summary>
    /// <param name="customer">Customer entity</param>
    /// <returns></returns>
    public static string UpdateCustomerAddress(Customer customer)
    {
        try
        {
            AspNetUser user = customer.AspNetUser;
            AspNetUserAddress address = customer.AspNetUserAddress;
            using (var context = new WebsiteTTKEntities())
            {
                var existAddress = context.AspNetUserAddresses.FirstOrDefault(x => x.UserId == user.Id);
                existAddress.Firstname = address.Firstname;
                existAddress.Lastname = address.Lastname;
                existAddress.Company = address.Company;
                existAddress.Street = address.Street;
                existAddress.City = address.City;
                existAddress.Zip = address.Zip;
                existAddress.State = address.State;
                existAddress.PhoneNumber = address.PhoneNumber;
                existAddress.Email = address.Email;
                existAddress.Country = address.Country;

                context.SaveChanges();
                return null;
            }
        } catch (Exception ex)
        {
            return ex.Message;
        }
    }
}
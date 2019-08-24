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
        throw new NotImplementedException();
    }
}
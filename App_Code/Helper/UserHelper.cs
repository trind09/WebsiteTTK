using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UserHelper
/// </summary>
public class UserHelper
{
    public UserHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public enum AddressType
    {
        HomeAddress = 0,
        ShippingAddress = 1,
        Other = 2
    }

    /// <summary>
    /// Change user password
    /// </summary>
    /// <param name="userName">user name in string</param>
    /// <param name="newPassword">new user password</param>
    /// <returns></returns>
    public static async System.Threading.Tasks.Task<IdentityResult> ChangePasswordAsync(string userName, string newPassword)
    {
        var userStore = new UserStore<IdentityUser>();
        var userManager = new UserManager<IdentityUser>(userStore);
        System.Threading.Tasks.Task<IdentityUser> user = userManager.FindByNameAsync(userName);
        var userId = user.Result.Id;
        if (userId != null)
        {
            if (userManager.HasPasswordAsync(userId).Result)
            {
                System.Threading.Tasks.Task<IdentityResult> removePassResult = userManager.RemovePasswordAsync(userId);
                if (removePassResult.Status != System.Threading.Tasks.TaskStatus.Faulted)
                {
                    var newPasswordHash = userManager.PasswordHasher.HashPassword(newPassword);
                    await userStore.SetPasswordHashAsync(user.Result, newPasswordHash);
                    return userManager.UpdateAsync(user.Result).Result;
                }
                return null;
            }
            return null;
        }
        return null;
    }

    /// <summary>
    /// Convert bolean to string gender 
    /// </summary>
    /// <param name="gender">Nulable Boolean</param>
    /// <returns></returns>
    public static string ConvertBooleanToGender(bool? gender)
    {
        if (gender != null)
        {
            if (gender.Value)
            {
                return "Male";
            } else
            {
                return "Female";
            }
        }
        return null;
    }

    /// <summary>
    /// Convert string to boolean gender
    /// </summary>
    /// <param name="gender">String</param>
    /// <returns></returns>
    public static bool? ConvertStringToGender(string gender)
    {
        if (gender != null)
        {
            if (gender == "Male")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        return null;
    }

    /// <summary>
    /// Get list of user's address base on address type
    /// </summary>
    /// <param name="id">Address ID</param>
    /// <param name="type">Address Type (Enum)</param>
    /// <returns></returns>
    public static List<AspNetUserAddress> GetUserAddressByUserId(string id, AddressType type)
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            IQueryable<AspNetUserAddress> qUserAddressTable = from t in context.AspNetUserAddresses where t.UserId == id && t.AddressType == type.ToString()
                                                 select t; // can you confirm if your context has Tables or MyTables?
            var listOfProducts = qUserAddressTable.Select(s => new {
                Id = s.Id,
                UserId = s.UserId,
                Firstname = s.Firstname,
                Lastname = s.Lastname,
                Company = s.Company,
                Street = s.Street,
                City = s.City,
                Country = s.Country,
                State = s.State,
                Zip = s.Zip,
                Birthday = s.Birthday,
                Gender = s.Gender,
                PhoneNumber = s.PhoneNumber,
                Email = s.Email,
                AddressType = s.AddressType
            }).ToList();

            List<AspNetUserAddress> addresses = new List<AspNetUserAddress>();
            foreach (var item in listOfProducts)
            {
                AspNetUserAddress address = new AspNetUserAddress();
                address.Id = item.Id;
                address.UserId = item.UserId;
                address.Firstname = item.Firstname;
                address.Lastname = item.Lastname;
                address.Company = item.Company;
                address.Street = item.Street;
                address.City = item.City;
                address.Country = item.Country;
                address.State = item.State;
                address.Zip = item.Zip;
                address.Birthday = item.Birthday;
                address.Gender = item.Gender;
                address.PhoneNumber = item.PhoneNumber;
                address.Email = item.Email;
                address.AddressType = item.AddressType;

                addresses.Add(address);
            }

            return addresses;
        }
    }

    /// <summary>
    /// Get AspNetUser by user id
    /// </summary>
    /// <param name="id">user id</param>
    /// <returns></returns>
    public static AspNetUser GetUserByUserId(string id)
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            return context.AspNetUsers.FirstOrDefault(x => x.Id == id);
        }
    }

    /// <summary>
    /// List of country
    /// </summary>
    /// <returns>List of countries in string</returns>
    public static string[] Countries()
    {
        string countries = System.Configuration.ConfigurationManager.AppSettings["Countries"];
        return countries.Split(';');
    }

    /// <summary>
    /// Update or add a new address
    /// </summary>
    /// <param name="addresses">List of address to be updated or added</param>
    public static void UpdateUserAddresses(List<AspNetUserAddress> addresses)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (AspNetUserAddress item in addresses)
            {
                var result = context.AspNetUserAddresses.SingleOrDefault(b => b.Id == item.Id);
                if (result != null)
                {
                    result.Firstname = item.Firstname;
                    result.Lastname = item.Lastname;
                    result.Company = item.Company;
                    result.Street = item.Street;
                    result.City = item.City;
                    result.Zip = item.Zip;
                    result.State = item.State;
                    result.Country = item.Country;
                    result.Birthday = item.Birthday;
                    result.Gender = item.Gender;
                    result.PhoneNumber = item.PhoneNumber;
                    result.Email = item.Email;
                    result.AddressType = item.AddressType;

                    context.SaveChanges();
                }
                else
                {
                    context.AspNetUserAddresses.Add(new AspNetUserAddress
                    {
                        UserId = item.UserId,
                        Firstname = item.Firstname,
                        Lastname = item.Lastname,
                        Company = item.Company,
                        Street = item.Street,
                        City = item.City,
                        Zip = item.Zip,
                        State = item.State,
                        Country = item.Country,
                        Birthday = item.Birthday,
                        Gender = item.Gender,
                        PhoneNumber = item.PhoneNumber,
                        Email = item.Email,
                        AddressType = item.AddressType
                    });

                    context.SaveChanges();
                }
            }
        }
    }
}
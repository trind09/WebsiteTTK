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
    /// List of country
    /// </summary>
    /// <returns>List of countries in string</returns>
    public static string[] Countries()
    {
        string countries = "Afghanistan;Åland Islands;Albania;Algeria;American Samoa;Andorra;Angola;Anguilla;Antarctica;Antigua and Barbuda;Argentina;Armenia;Aruba;Australia;Austria;Azerbaijan;Bahamas;Bahrain;Bangladesh;Barbados;Belarus;Belgium;Belize;Benin;Bermuda;Bhutan;Bolivia, Plurinational State of;Bosnia and Herzegovina;Botswana;Bouvet Island;Brazil;British Indian Ocean Territory;Brunei Darussalam;Bulgaria;Burkina Faso;urundi;Cambodia;Cameroon;Canada;Cape Verde;Cayman Islands;Central African Republic;Chad;Chile;China;Christmas Island;Cocos (Keeling) Islands;Colombia;Comoros;Congo;Congo, The Democratic Republic of the;Cook Islands;Costa Rica;Côte d'Ivoire;Croatia;Cuba;Cyprus;Czech Republic;Denmark;Djibouti;Dominica;Dominican Republic;Ecuador;Egypt;El Salvador;Equatorial Guinea;Eritrea;Estonia;Ethiopia;Falkland Islands (Malvinas);Faroe Islands;Fiji;Finland;France;French Guiana;French Polynesia;French Southern Territories;Gabon;Gambia;Georgia;Germany;Ghana;Gibraltar;Greece;Greenland;Grenada;Guadeloupe;Guam;Guatemala;Guernsey;Guinea;Guinea-Bissau;Guyana;Haiti;Heard Island and McDonald Islands;Holy See (Vatican City State);Honduras;Hong Kong;Hungary;Iceland;India;Indonesia;Iran, Islamic Republic of;Iraq;Ireland;Isle of Man;Israel;Italy;Jamaica;Japan;Jersey;Jordan;Kazakhstan;Kenya;Kiribati;Korea, Democratic People's Republic of;Korea, Republic of;Kuwait;Kyrgyzstan;Lao People's Democratic Republic;Latvia;Lebanon;Lesotho;Liberia;Libyan Arab Jamahiriya;Liechtenstein;Lithuania;Luxembourg;Macao;Macedonia, The Former Yugoslav Republic of;Madagascar;Malawi;Malaysia;Maldives;Mali;Malta;Marshall Islands;Martinique;Mauritania;Mauritius;Mayotte;Mexico;Micronesia, Federated States of;Moldova, Republic of;Monaco;Mongolia;Montenegro;Montserrat;Morocco;Mozambique;Myanmar;Namibia;Nauru;Nepal;Netherlands;Netherlands Antilles;New Caledonia;New Zealand;Nicaragua;Niger;Nigeria;Niue;Norfolk Island;Northern Mariana Islands;Norway;Oman;Pakistan;Palau;Palestinian Territory, Occupied;Panama;Papua New Guinea;Paraguay;Peru;Philippines;Pitcairn;Poland;Portugal;Puerto Rico;Qatar;Réunion;Romania;Russian Federation;Rwanda;Saint Barthélemy;Saint Helena, Ascension and Tristan Da Cunha;Saint Kitts and Nevis;Saint Lucia;Saint Martin;Saint Pierre and Miquelon;Saint Vincent and the Grenadines;Samoa;San Marino;Sao Tome and Principe;Saudi Arabia;Senegal;Serbia;Seychelles;Sierra Leone;Singapore;Slovakia;lovenia;Solomon Islands;Somalia;South Africa;South Georgia and the South Sandwich Islands;Spain;Sri Lanka;Sudan;Suriname;Svalbard and Jan Mayen;Swaziland;Sweden;Switzerland;Syrian Arab Republic;Taiwan, Province of China;Tajikistan;Tanzania, United Republic of;Thailand;Timor-Leste;Togo;Tokelau;Tonga;Trinidad and Tobago;Tunisia;Turkey;Turkmenistan;Turks and Caicos Islands;Tuvalu;Uganda;Ukraine;United Arab Emirates;United Kingdom;United States;United States Minor Outlying Islands;Uruguay;Uzbekistan;Vanuatu;Venezuela, Bolivarian Republic of;Viet Nam;Virgin Islands, British;Virgin Islands, U.S.;Wallis and Futuna;Western Sahara;Yemen;Zambia;Zimbabwe";
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
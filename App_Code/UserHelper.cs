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

    public static AspNetUserAddress GetUserAddressByUserId(string id)
    {
        return null;
    }
}
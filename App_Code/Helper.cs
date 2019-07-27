﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
    public Helper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static DateTime? ConverToDateTime(string str)
    {
        try
        {
            string globalDateTimeFormat = System.Configuration.ConfigurationManager.AppSettings["GlobalDateTimeFormat"];
            DateTime date = DateTime.ParseExact(str, globalDateTimeFormat, System.Globalization.CultureInfo.InvariantCulture);
            return date;
        }
        catch
        {
            return DateTime.Now;
        }
    }

    public static object GetPropValue(string json, string propName)
    {
        Newtonsoft.Json.Linq.JObject jObject = Newtonsoft.Json.Linq.JObject.Parse(json);
        foreach (Newtonsoft.Json.Linq.JToken token in jObject.SelectTokens(propName))
        {
            return token;
        }
        return null;
    }

    public static string StripHTML(string input)
    {
        return System.Text.RegularExpressions.Regex.Replace(input, "<.*?>", String.Empty);
    }

    public static bool IsValidPassword(string password)
    {
        //Password must be 8 characters including 1 uppercase letter, 1 special character, alphanumeric characters
        //return System.Text.RegularExpressions.Regex.Match(password, @"^(.{0,7}|[^0-9]*|[^A-Z])$").Success;
        //Password at least one upper case english letter • At least one lower case english letter • At least one digit • At least one special character • Minimum 8 in length
        //return System.Text.RegularExpressions.Regex.Match(password, @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$").Success;
        if (password.Length < 6)
        {
            return false;
        }
        else if (password.IndexOf(" ") > -1)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public static bool IsValidUsername(string username)
    {
        return System.Text.RegularExpressions.Regex.Match(username, @"^(?=[a-zA-Z])[-\w.]{0,23}([a-zA-Z\d]|(?<![-.])_)$").Success;
    }

    public static bool IsPhoneNumber(string number)
    {
        return System.Text.RegularExpressions.Regex.Match(number, @"^(\+[0-9]{9})$").Success;
    }

    public static bool IsHomePage()
    {
        if (string.Compare(HttpContext.Current.Request.Url.LocalPath, "/default.aspx") == 0 || string.Compare(HttpContext.Current.Request.Url.LocalPath, "/") == 0)
        {
            return true;
        }
        return false;
    }

    public static bool IsValidEmail(string email)
    {
        try
        {
            var addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }

    public static string GetHostURL()
    {
        return System.Configuration.ConfigurationManager.AppSettings["WebSiteUrl"];
    }

    /// <summary>
    /// Save file from upload
    /// </summary>
    /// Return explain:
    /// <param name="message">Message from upload file</param>
    /// <param name="fileName">Uploaded File name</param>
    /// /// <param name="result">Result in boolean</param>
    /// <returns>List of KeyValuePair string and object</returns>
    /// <example>Helper.SaveFileFromUpload(subPath, fulImageUpload, new string[] { ".jpg", ".gif", ".png"});</example>
    /// <get>string message = list.First(kvp => kvp.Key == "message").Value.ToString();</get>
    /// <get>string isSuccess = list.First(kvp => kvp.Key == "result").Value.ToString();</get>
    /// <get>string fileName = result.First(kvp => kvp.Key == "fileName").Value.ToString();</get>
    public static List<KeyValuePair<string, object>> SaveFileFromUpload(string subPath, FileUpload ful, string[] extensions)
    {
        try
        {
            bool exists = System.IO.Directory.Exists(HttpContext.Current.Server.MapPath(subPath));
            if (!exists)
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(subPath));

            subPath = HttpContext.Current.Server.MapPath(subPath);

            string result = "";

            // Get the name of the file to upload.
            string fileName = ful.FileName;

            string ext = System.IO.Path.GetExtension(fileName).ToLower();
            if (extensions.Contains(ext)) {

                // Create the path and file name to check for duplicates.
                string pathToCheck = subPath + fileName;

                // Create a temporary file name to use for checking duplicates.
                string tempfileName = "";

                // Check to see if a file already exists with the
                // same name as the file to upload.        
                if (System.IO.File.Exists(pathToCheck))
                {
                    int counter = 2;
                    while (System.IO.File.Exists(pathToCheck))
                    {
                        // if a file with this name already exists,
                        // prefix the filename with a number.
                        tempfileName = counter.ToString() + fileName;
                        pathToCheck = subPath + tempfileName;
                        counter++;
                    }

                    fileName = tempfileName;

                    // Notify the user that the file name was changed.
                    result = "A file with the same name already exists." +
                        "<br />Your file was saved as " + fileName;
                }
                else
                {
                    // Notify the user that the file was saved successfully.
                    result = "Your file was uploaded successfully.";
                }

                // Append the name of the file to upload to the path.
                subPath += fileName;

                // Call the SaveAs method to save the uploaded
                // file to the specified directory.
                ful.SaveAs(subPath);


                var list = new List<KeyValuePair<string, object>>();
                list.Add(new KeyValuePair<string, object>("message", result));
                list.Add(new KeyValuePair<string, object>("fileName", fileName));
                list.Add(new KeyValuePair<string, object>("result", true));
                return list;
            } else
            {
                var list = new List<KeyValuePair<string, object>>();
                list.Add(new KeyValuePair<string, object>("message", "Invalid file extension!"));
                list.Add(new KeyValuePair<string, object>("fileName", null));
                list.Add(new KeyValuePair<string, object>("result", false));
                return list;
            }
        } catch (Exception ex)
        {
            var list = new List<KeyValuePair<string, object>>();
            list.Add(new KeyValuePair<string, object>("message", ex.Message));
            list.Add(new KeyValuePair<string, object>("fileName", null));
            list.Add(new KeyValuePair<string, object>("result", false));
            return list;
        }
    }
}
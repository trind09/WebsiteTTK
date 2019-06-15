using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

/// <summary>
/// Summary description for UploadImageService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class UploadImageService : System.Web.Services.WebService
{

    public UploadImageService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string RemoveImage()
    {
        // convert postdata to dictionary
        string id = HttpContext.Current.Request.QueryString["id"];
        string image = HttpContext.Current.Request.QueryString["image"];
        string table_name = HttpContext.Current.Request.QueryString["table"];

        if (table_name == "products")
        {
            int product_id = -1;
            Int32.TryParse(id, out product_id);
            if (product_id > 0)
            {
                using (var context = new WebsiteTTKEntities())
                {
                    IQueryable<product> qProductsTable = from t in context.products
                                                         where t.product_id == product_id
                                                         select t;
                    product objPro = qProductsTable.FirstOrDefault();
                    if (objPro != null)
                    {
                        try
                        {
                            List<string> strList = objPro.product_images.Split(';').ToList();
                            strList.RemoveAll(x => x.StartsWith(@image));
                            objPro.product_images = string.Join(";", strList);
                            ProductHelper.UpdateProducts(new List<product> { objPro }, true);
                            File.Delete(Server.MapPath("~/" + image));
                            return "Remove image successful!";
                        }
                        catch
                        {
                            return "Image doesn't exist!";
                        }
                    }
                }
            }
        }
        return "Image doesn't exist!";
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string UploadImage(object images)
    {
        string a = images + "";
        return "";
    }

}

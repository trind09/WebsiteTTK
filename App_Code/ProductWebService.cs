using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

/// <summary>
/// Summary description for ProductWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ProductWebService : System.Web.Services.WebService
{

    public ProductWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    // var data = {};
    //data.ids = recent_product_ids.join('|');
    //$.ajax({
    //type: "POST",
    //        url: currentHostUrl + "/WebServices/ProductWebService.asmx/HelloWorld",
    //        cache: false,
    //        contentType: "application/json; charset=utf-8",
    //        data: JSON.stringify(data),
    //        dataType: "json",
    //        success: ShowProductsViewedRecently,
    //        error: ajaxFailed
    //    });
    public List<ProductCurrency> HelloWorld(string ids)
    {
        int[] product_ids = Array.ConvertAll(ids.Split('|'), int.Parse);
        ProductControllerModel model = ProductController.GetProductCurrency(product_ids);
        return model.ProductItems;
    }

}

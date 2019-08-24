using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        int category_id = 0;
        Int32.TryParse(Request.QueryString["category_id"], out category_id);
        int store_id = 0;
        Int32.TryParse(Request.QueryString["store_id"], out store_id);
        string search_val = Request.QueryString["search_val"];
        if (category_id > 0)
        {
            //Get product data
            ProductControllerModel model = ProductController.GetProductByCategory(category_id);
            if (model != null)
            {
                //Throw data to client for script to generate the interface of product
                var productDetailJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model);
                Server_Data.InnerText = productDetailJson;
            }
        }
        else if (store_id > 0)
        {
            //Get product data
            ProductControllerModel model = ProductController.GetProductByCategory(0, store_id);
            if (model != null)
            {
                //Throw data to client for script to generate the interface of product
                var productDetailJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model);
                Server_Data.InnerText = productDetailJson;
            }
        }
        else if (!String.IsNullOrEmpty(search_val))
        {
            var searchResult = Helper.GetPlainTextFromHtml(search_val);
            //Get product data
            ProductControllerModel model = ProductController.GetProductByCategory(0, 0, searchResult);
            if (model != null)
            {
                //Throw data to client for script to generate the interface of product
                var productDetailJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(model);
                Server_Data.InnerText = productDetailJson;
            }
        }
    }
}
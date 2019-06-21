using System;
using System.Web.Script.Serialization;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;

public partial class admin_ImageUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string images = Request.QueryString["images"];
            //string[] imageItems = images.Split(';');
            //foreach (var item in imageItems)
            //{

            //}
            //Get product data
            ShowData();
        }
    }

    private void ShowData()
    {
        using (var context = new WebsiteTTKEntities())
        {
            string id = Request.QueryString["id"];
            string table_name = Request.QueryString["table_name"];
            if (table_name == "products")
            {
                int product_id = -1;
                Int32.TryParse(id, out product_id);
                if (product_id > 0)
                {
                    IQueryable<product> qProductsTable = from t in context.products where t.product_id == product_id
                                                         select t;
                    product objPro = qProductsTable.FirstOrDefault();
                    if (objPro != null)
                    {
                        if (objPro.product_images != null)
                        {
                            Images_Data.InnerText = objPro.product_images;
                        }
                        else
                        {
                            Images_Data.InnerText = "";
                        }
                    }
                }
            }

            string hostURL = Helper.GetHostURL();
            Service_URL.InnerText = hostURL + "/admin/Services/UploadImageService.asmx";
            Service_URL_Name.InnerText = "/Services/UploadImageService.asmx";
            Host_URL.InnerText = hostURL;
        }
    }

    protected void lbnSubmit_Click(object sender, EventArgs e)
    {
        if (fulImageUpload.HasFile)
        {
            using (var context = new WebsiteTTKEntities())
            {
                string id = Request.QueryString["id"];
                string table_name = Request.QueryString["table_name"];

                if (table_name == "products")
                {
                    int product_id = -1;
                    Int32.TryParse(id, out product_id);
                    if (product_id > 0)
                    {
                        IQueryable<product> qProductsTable = from t in context.products
                                                             where t.product_id == product_id
                                                             select t;
                        product objPro = qProductsTable.FirstOrDefault();
                        if (objPro != null)
                        {
                            string subPath = "~/admin/img/" + product_id + "/";

                            List<KeyValuePair<string, object>> result = Helper.SaveFileFromUpload(subPath, fulImageUpload, new string[] { ".jpg", ".gif", ".png", ".jpeg" });
                            string message = result.First(kvp => kvp.Key == "message").Value.ToString();
                            string isSuccess = result.First(kvp => kvp.Key == "result").Value.ToString();
                            if (Boolean.Parse(isSuccess))
                            {
                                string fileName = result.First(kvp => kvp.Key == "fileName").Value.ToString();

                                if (objPro.product_images != null)
                                {
                                    objPro.product_images = objPro.product_images + ";admin/img/" + product_id + "/" + fileName;
                                }
                                else
                                {
                                    objPro.product_images = "admin/img/" + product_id + "/" + fileName;
                                }
                                ProductHelper.UpdateProducts(new List<product> { objPro }, true);
                                lblUploadResult.Text = "<br/>" + message;
                            }
                            else
                            {
                                lblUploadResult.Text = "<br/>" + message;
                            }
                        } else
                        {
                            lblUploadResult.Text = "<br/>Product id " + product_id + " doesn't exist!";
                        }
                    }
                }
            }
        }
        ShowData();
    }
}
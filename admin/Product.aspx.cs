using System;
using System.Web.Script.Serialization;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;

public partial class admin_Product :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PushDataToClient();
        }
    }

    protected void btnApplyAllChanges_Click(object sender, EventArgs e)
    {
        //Create product list from json posted from client
        List<product> products = new List<product>();
        var productsJson = Product_Data_To_Post_To_Server.Text;
        dynamic productsResponse = JsonConvert.DeserializeObject(productsJson);
        if (productsResponse.Count > 0)
        {
            List<object> productObjects = productsResponse.ToObject<List<object>>();
            foreach (var obj in productObjects)
            {
                product item = new product();

                int product_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "product_id") + "", out product_id);
                item.product_id = product_id;

                item.product_name = Helper.GetPropValue(obj + "", "product_name") + "";
                item.product_description = Helper.GetPropValue(obj + "", "product_description") + "";
                item.product_images = Helper.GetPropValue(obj + "", "product_images") + "";

                int brand_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "brand_id") + "", out brand_id);
                item.brand_id = brand_id;

                int category_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "category_id") + "", out category_id);
                item.category_id = category_id;

                short model_year = -1;
                short.TryParse(Helper.GetPropValue(obj + "", "model_year") + "", out model_year);
                item.model_year = model_year;

                decimal list_price = -1;
                decimal.TryParse(Helper.GetPropValue(obj + "", "model_year") + "", out list_price);
                item.list_price = list_price;

                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");

                item.create_by = Helper.GetPropValue(obj + "", "create_by") + "";

                bool is_publish = true;
                bool.TryParse(Helper.GetPropValue(obj + "", "is_publish") + "", out is_publish);
                item.is_publish = is_publish;

                products.Add(item);
            }
        }

        //Delete records from product
        //Get product ids from json posted from client
        var deletedIdsJson = txtDeletedIds.Text;
        dynamic deletedIdsResponse = JsonConvert.DeserializeObject(deletedIdsJson);
        if (deletedIdsResponse.Count > 0)
        {
            List<int> deletedIds = deletedIdsResponse.ToObject<List<int>>();

            if (deletedIds.Count > 0)
            {
                foreach (var id in deletedIds)
                {
                    var found = products.Find(x => x.product_id == id);
                    if (found != null) products.Remove(found);
                }
                ProductHelper.DeleteProductByIds(deletedIds);
            }
        }

        ProductHelper.UpdateProducts(products);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            IQueryable<product> qProductsTable = from t in context.products
                                         select t; // can you confirm if your context has Tables or MyTables?
            var listOfProducts = qProductsTable.Select(s => new {
                s.product_id,
                s.product_name,
                s.product_description,
                s.product_images,
                s.brand_id,
                s.category_id,
                s.model_year,
                s.list_price,
                s.create_date,
                s.create_by,
                s.is_publish
            }).ToList();
            var productsJson = new JavaScriptSerializer().Serialize(listOfProducts);
            Products_Data.InnerText = productsJson;

            //Get brand data
            IQueryable<brand> qBrandsTable = from t in context.brands
                                         select t; // can you confirm if your context has Tables or MyTables?
            var listOfBrand = qBrandsTable.Select(s => new {
                s.brand_id,
                s.brand_name,
                s.brand_description,
                s.images,
                s.create_date
            }).ToList();
            var brandsJson = new JavaScriptSerializer().Serialize(listOfBrand);
            Brand_Data.InnerText = brandsJson;

            //Get Category data
            IQueryable<category> qCategoriesTable = from t in context.categories
                                             select t; // can you confirm if your context has Tables or MyTables?
            var listOfCategories = qCategoriesTable.Select(s => new {
                s.category_id,
                s.category_name,
                s.category_description,
                s.images,
                s.create_date,
                s.parent_id
            }).ToList();
            var categoriesJson = new JavaScriptSerializer().Serialize(listOfCategories);
            Category_Data.InnerText = categoriesJson;
        }
    }
}
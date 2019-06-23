using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Brand : System.Web.UI.Page
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
        List<brand> brands = new List<brand>();
        var brandsJson = Server_Data1.Text;
        dynamic brandsResponse = JsonConvert.DeserializeObject(brandsJson);
        if (brandsResponse != null)
        {
            List<object> brandObjects = brandsResponse.ToObject<List<object>>();
            foreach (var obj in brandObjects)
            {
                brand item = new brand();

                int brand_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "brand_id") + "", out brand_id);
                item.brand_id = brand_id;

                item.brand_name = Helper.GetPropValue(obj + "", "brand_name") + "";
                item.brand_description = Helper.GetPropValue(obj + "", "brand_description") + "";
                item.images = Helper.GetPropValue(obj + "", "images") + "";
                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");

                brands.Add(item);
            }
        }

        //Delete records from product
        //Get product ids from json posted from client
        var deletedIdsJson = txtDeletedIds.Text;
        dynamic deletedIdsResponse = JsonConvert.DeserializeObject(deletedIdsJson);
        if (deletedIdsResponse != null)
        {
            List<int> deletedIds = deletedIdsResponse.ToObject<List<int>>();

            if (deletedIds.Count > 0)
            {
                foreach (var id in deletedIds)
                {
                    var found = brands.Find(x => x.brand_id == id);
                    if (found != null) brands.Remove(found);
                }
                BrandHelper.DeleteBrandByIds(deletedIds);
            }
        }

        BrandHelper.Updatebrands(brands);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<brand> qTable = from t in context.brands
                                         select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new {
                s.brand_id,
                s.brand_name,
                s.brand_description,
                s.images,
                s.create_date,
            }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}
 
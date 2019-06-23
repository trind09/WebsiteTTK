using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Category : System.Web.UI.Page
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
        List<category> categorys = new List<category>();
        var categorysJon = Server_Data1.Text;
        dynamic categorysResponse = JsonConvert.DeserializeObject(categorysJon);
        if (categorysResponse.Count > 0)
        {
            List<object> categorysObjects = categorysResponse.ToObject<List<object>>();
            foreach (var obj in categorysObjects)
            {
                category item = new category();

                int category_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "category_id") + "", out category_id);
                item.category_id = category_id;

                item.category_name = Helper.GetPropValue(obj + "", "category_name") + "";
                item.category_description = Helper.GetPropValue(obj + "", "category_description") + "";
                item.images = Helper.GetPropValue(obj + "", "images") + "";
                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");

                int parent_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "parent_id") + "", out parent_id);
                item.parent_id = parent_id;

                categorys.Add(item);
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
                    var found = categorys.Find(x => x.category_id == id);
                    if (found != null) categorys.Remove(found);
                }
                CategoryHepler.DeleteCategoryByIds(deletedIds);
            }
        }

        CategoryHepler.Updatecategorys(categorys);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<category> qTable = from t in context.categories
                                       select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new {
                s.category_id,
                s.category_name,
                s.category_description,
                s.images,
                s.create_date,
                s.parent_id
            }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}

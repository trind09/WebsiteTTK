using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Store : System.Web.UI.Page
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
        List<store> stores = new List<store>();
        var storesJon = Server_Data1.Text;
        dynamic storesResponse = JsonConvert.DeserializeObject(storesJon);
        if (storesResponse != null)
        {
            List<object> storeObjects = storesResponse.ToObject<List<object>>();
            foreach (var obj in storeObjects)
            {
                store item = new store();

                int store_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "store_id") + "", out store_id);
                item.store_id = store_id;

                item.store_name = Helper.GetPropValue(obj + "", "store_name") + "";
                item.phone = Helper.GetPropValue(obj + "", "phone") + "";
                item.email = Helper.GetPropValue(obj + "", "email") + "";
                item.street = Helper.GetPropValue(obj + "", "street") + "";
                item.city = Helper.GetPropValue(obj + "", "city") + "";
                item.zip_code = Helper.GetPropValue(obj + "", "zip_code") + "";

                stores.Add(item);
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
                    var found = stores.Find(x => x.store_id == id);
                    if (found != null) stores.Remove(found);
                }
                StoreHelper.DeleteStoreByIds(deletedIds);
            }
        }

        StoreHelper.Updatestores(stores);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<store> qTable = from t in context.stores
                                       select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new
            {
                s.store_id,
                s.store_name,
                s.phone,
                s.email,
                s.street,
                s.city,
                s.zip_code,
            }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}
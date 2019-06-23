using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Customer : System.Web.UI.Page
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
        List<customer> customers = new List<customer>();
        var customersJon = Server_Data1.Text;
        dynamic customersResponse = JsonConvert.DeserializeObject(customersJon);
        if (customersResponse != null)
        {
            List<object> customerObjects = customersResponse.ToObject<List<object>>();
            foreach (var obj in customerObjects)
            {
                customer item = new customer();

                int customer_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "customer_id") + "", out customer_id);
                item.customer_id = customer_id;

                item.first_name = Helper.GetPropValue(obj + "", "first_name") + "";
                item.last_name = Helper.GetPropValue(obj + "", "last_name") + "";
                item.phone = Helper.GetPropValue(obj + "", "phone") + "";
                item.email = Helper.GetPropValue(obj + "", "email") + "";
                item.street = Helper.GetPropValue(obj + "", "street") + "";
                item.city = Helper.GetPropValue(obj + "", "city") + "";
                item.zip_code = Helper.GetPropValue(obj + "", "zip_code") + "";
                item.address = Helper.GetPropValue(obj + "", "address") + "";


               

                customers.Add(item);
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
                    var found = customers.Find(x => x.customer_id == id);
                    if (found != null) customers.Remove(found);
                }
                CustomerHelper.DeleteCustomerByIds(deletedIds);
            }
        }

        CustomerHelper.Updatecustomers(customers);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<customer> qTable = from t in context.customers
                                          select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new {
                s.customer_id,
                s.first_name,
                s.last_name,
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
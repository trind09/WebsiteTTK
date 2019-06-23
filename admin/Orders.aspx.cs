using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Orders : System.Web.UI.Page
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
        List<order> orders = new List<order>();
        var ordersJon = Server_Data1.Text;
        dynamic ordersResponse = JsonConvert.DeserializeObject(ordersJon);
        if (ordersResponse != null)
        {
            List<object> orderObjects = ordersResponse.ToObject<List<object>>();
            foreach (var obj in orderObjects)
            {
                order item = new order();

                int order_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_id") + "", out order_id);
                item.order_id = order_id;

                int customer_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_id") + "", out customer_id);
                item.customer_id = customer_id;

                Int32 order_status = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_status") + "", out order_status);
                item.customer_id = customer_id;

                item.order_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "order_date") + "") ?? DateTime.Now.ToLocalTime();
                item.required_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "required_date") + "") ?? DateTime.Now.ToLocalTime();

                item.shipped_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "shipped_date") + "");

                int store_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "store_id") + "", out store_id);
                item.store_id = store_id;

                int staff_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "staff_id") + "", out staff_id);
                item.staff_id = staff_id;

                orders.Add(item);
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
                    var found = orders.Find(x => x.order_id == id);
                    if (found != null) orders.Remove(found);
                }
                OrderHelper.DeleteOrderByIds(deletedIds);
            }
        }

        OrderHelper.Updateorders(orders);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<order> qTable = from t in context.orders
                                          select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new {
                s.order_id,
                s.customer_id,
                s.order_status,
                s.order_date,
                s.required_date,
                s.shipped_date,
                s.store_id,
                s.staff_id,
            }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}
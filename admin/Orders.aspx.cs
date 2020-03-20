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

                int order_id = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_id") + "", out order_id);
                item.order_id = order_id;

                item.customer_id = Helper.GetPropValue(obj + "", "order_id") + "";

                Int32 order_status = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_status") + "", out order_status);
                item.order_status = order_status;

                item.order_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "order_date") + "") ?? DateTime.Now.ToLocalTime();
                item.required_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "required_date") + "") ?? DateTime.Now.ToLocalTime();

                item.shipped_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "shipped_date") + "");

                int store_id = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "store_id") + "", out store_id);
                item.store_id = store_id;

                int staff_id = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "staff_id") + "", out staff_id);
                item.staff_id = staff_id;

                int order_discount = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "order_discount") + "", out order_discount);
                item.order_discount = order_discount;

                bool order_discount_is_fixed = true;
                bool.TryParse(Helper.GetPropValue(obj + "", "order_discount_is_fixed") + "", out order_discount_is_fixed);
                item.order_discount_is_fixed = order_discount_is_fixed;

                int delivery_id = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "delivery_id") + "", out delivery_id);
                item.delivery_id = delivery_id;

                int currency_id = 0;
                Int32.TryParse(Helper.GetPropValue(obj + "", "currency_id") + "", out currency_id);
                item.currency_id = currency_id;

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
            try
            {
                var orders = context.orders.ToList();
                var json = new JavaScriptSerializer().Serialize(orders);
                Server_Data.InnerText = json;
            }
            catch (Exception ex) {
                LogHelper.Log("WebsiteTTK\\admin\\Orders.aspx.cs", LogHelper.ErrorType.Error, ex);
            }
        }
    }
}
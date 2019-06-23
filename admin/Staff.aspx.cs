using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Staff : System.Web.UI.Page
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
        List<staff> staffs = new List<staff>();
        var staffsJon = Server_Data1.Text;
        dynamic staffsResponse = JsonConvert.DeserializeObject(staffsJon);
        if (staffsResponse != null)
        {
            List<object> staffObjects = staffsResponse.ToObject<List<object>>();
            foreach (var obj in staffObjects)
            {
                staff item = new staff();

                int staff_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "staff_id") + "", out staff_id);
                item.staff_id = staff_id;

                item.first_name = Helper.GetPropValue(obj + "", "first_name") + "";
                item.last_name = Helper.GetPropValue(obj + "", "last_name") + "";
                item.email = Helper.GetPropValue(obj + "", "email") + "";
                item.phone = Helper.GetPropValue(obj + "", "phone") + "";

                byte active = 0;
                Byte.TryParse(Helper.GetPropValue(obj + "", "active") + "", out active);
                item.active = active;

                int store_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "store_id") + "", out store_id);
                item.store_id = store_id;

                item.address = Helper.GetPropValue(obj + "", "address") + "";

                staffs.Add(item);
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
                    var found = staffs.Find(x => x.staff_id == id);
                    if (found != null) staffs.Remove(found);
                }
                StaffHelper.DeleteStaffByIds(deletedIds);
            }
        }

        StaffHelper.Updatestaffs(staffs);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<staff> qTable = from t in context.staffs
                                       select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new
            {
                s.staff_id,
                s.first_name,
                s.last_name,
                s.phone,
                s.email,
                s.active,
                s.store_id,
                s.address,
            }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}

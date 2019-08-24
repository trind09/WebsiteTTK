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
        List<Customer> customers = new List<Customer>();
        var customersJon = Server_Data1.Text;
        dynamic customersResponse = JsonConvert.DeserializeObject(customersJon);
        if (customersResponse != null)
        {
            List<object> customerObjects = customersResponse.ToObject<List<object>>();
            foreach (var obj in customerObjects)
            {
                Customer item = new Customer();

                AspNetUser aspUser = new AspNetUser();
                aspUser.Id = Helper.GetPropValue(obj + "", "customer_id") + "";

                item.FirstName = Helper.GetPropValue(obj + "", "first_name") + "";
                item.LastName = Helper.GetPropValue(obj + "", "last_name") + "";
                item.Street = Helper.GetPropValue(obj + "", "street") + "";
                item.City = Helper.GetPropValue(obj + "", "city") + "";
                item.ZipCode = Helper.GetPropValue(obj + "", "zip_code") + "";
                item.Address = Helper.GetPropValue(obj + "", "address") + "";
                item.Password = Helper.GetPropValue(obj + "", "password") + "";

                aspUser.PhoneNumber = Helper.GetPropValue(obj + "", "phone") + "";
                aspUser.Email = Helper.GetPropValue(obj + "", "email") + "";
                aspUser.EmailConfirmed = true;
                item.AspNetUser = aspUser;

                customers.Add(item);
            }
        }

        //Delete records from product
        //Get product ids from json posted from client
        var deletedIdsJson = txtDeletedIds.Text;
        dynamic deletedIdsResponse = JsonConvert.DeserializeObject(deletedIdsJson);
        if (deletedIdsResponse != null)
        {
            List<string> deletedIds = deletedIdsResponse.ToObject<List<string>>();

            if (deletedIds.Count > 0)
            {
                foreach (var id in deletedIds)
                {
                    var found = customers.Find(x => x.AspNetUser.Id == id);
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
            List<Customer> customers = CustomerHelper.GetAllCustomer();
            //var list = qTable.Select(s => new {
            //    s.customer_id,
            //    s.first_name,
            //    s.last_name,
            //    s.phone,
            //    s.email,
            //    s.street,
            //    s.city,
            //    s.zip_code,
            //}).ToList();
            var json = new JavaScriptSerializer().Serialize(customers);
            Server_Data.InnerText = json;
        }
    }
}
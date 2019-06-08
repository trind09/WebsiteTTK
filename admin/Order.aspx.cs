using System;
using System.Web.Script.Serialization;
using System.Linq;


public partial class admin_Order : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<Order> qTable = from t in context.Orders
                                         select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new { s.ID, s.ProductID, s.CreatedDate, s.PriceTotal }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}
using System;
using System.Web.Script.Serialization;
using System.Linq;

public partial class admin_Product :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<Product> qTable = from t in context.Products
                                         select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new { s.ID, s.Title, s.Description, s.Status, s.Publish, s.Images, s.RelativeProductIds, s.Price, s.Currency, s.CreatedDate }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }
}
using System;
using System.Web.Script.Serialization;
using System.Linq;

public partial class admin_Product :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (var context = new WebsiteTTKEntities())
        {
            IQueryable<product> qTable = from t in context.products
                                         select t; // can you confirm if your context has Tables or MyTables?
            var list = qTable.Select(s => new { s.product_id, s.product_name, s.product_description, s.product_images, s.brand_id,
                s.category_id, s.model_year, s.list_price, s.create_date, s.create_by, s.is_publish }).ToList();
            var json = new JavaScriptSerializer().Serialize(list);
            Server_Data.InnerText = json;
        }
    }

    protected void btnApplyAllChanges_Click(object sender, EventArgs e)
    {
        var text = Server_Data1.InnerText;
        string a = "a";
    }
}
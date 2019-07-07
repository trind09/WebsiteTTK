using System;
using System.Web.Script.Serialization;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;

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
        //Create category list from json posted from client
        List<category> categories = new List<category>();
        var categoriesJson = Category_Data_To_Post_To_Server.Text;
        dynamic categoriesResponse = JsonConvert.DeserializeObject(categoriesJson);
        if (categoriesResponse.Count > 0)
        {
            List<object> categoryObjects = categoriesResponse.ToObject<List<object>>();
            foreach (var obj in categoryObjects)
            {
                category item = new category();

                int category_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "category_id") + "", out category_id);
                item.category_id = category_id;

                item.category_name = Helper.GetPropValue(obj + "", "category_name") + "";
                item.category_description = Helper.GetPropValue(obj + "", "category_description") + "";
                item.category_url = Helper.GetPropValue(obj + "", "category_url") + "";

                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");

                int parent_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "parent_id") + "", out parent_id);
                item.parent_id = parent_id;

                bool is_publish = true;
                bool.TryParse(Helper.GetPropValue(obj + "", "is_publish") + "", out is_publish);
                item.is_publish = is_publish;

                bool is_menu = true;
                bool.TryParse(Helper.GetPropValue(obj + "", "is_menu") + "", out is_menu);
                item.is_menu = is_menu;

                categories.Add(item);
            }
        }

        //Delete records from category
        //Get category ids from json posted from client
        var deletedIdsJson = txtDeletedIds.Text;
        dynamic deletedIdsResponse = JsonConvert.DeserializeObject(deletedIdsJson);
        if (deletedIdsResponse.Count > 0)
        {
            List<int> deletedIds = deletedIdsResponse.ToObject<List<int>>();

            if (deletedIds.Count > 0)
            {
                foreach (var id in deletedIds)
                {
                    var found = categories.Find(x => x.category_id == id);
                    if (found != null) categories.Remove(found);
                }
                CategoryHelper.DeleteCategoryByIds(deletedIds);
            }
        }

        CategoryHelper.UpdateCategories(categories);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get category data
            IEnumerable<category> qCategoriesTable = (from s in context.categories.AsEnumerable()
                     select new category
                     {
                         category_id = s.category_id,
                         category_name = s.category_name,
                         category_description = s.category_description,
                         category_images = s.category_images,
                         category_url = s.category_url,
                         create_date = s.create_date,
                         parent_id = s.parent_id,
                         is_publish = s.is_publish,
                         is_menu = s.is_menu
                     });

            var categoriesJson = new JavaScriptSerializer().Serialize(qCategoriesTable.ToList());
            Categories_Data.InnerText = categoriesJson;

            //Because the parent categories are also retrieved from the same category table. So we set parent ctegory dropdownlist items as same as items from category table
            Parent_Category_Data.InnerText = categoriesJson;
        }
    }
}
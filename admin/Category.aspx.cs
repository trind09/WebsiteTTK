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

                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");

                int parent_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "parent_id") + "", out parent_id);
                item.parent_id = parent_id;

                bool is_publish = true;
                bool.TryParse(Helper.GetPropValue(obj + "", "is_publish") + "", out is_publish);
                item.is_publish = is_publish;

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
            IQueryable<category> qCategoriesTable = from t in context.categories
                                                 select t; // can you confirm if your context has Tables or MyTables?
            var listOfCategories = qCategoriesTable.Select(s => new {
                s.category_id,
                s.category_name,
                s.category_description,
                s.category_images,
                s.create_date,
                s.parent_id,
                s.is_publish
            }).ToList();
            var categoriesJson = new JavaScriptSerializer().Serialize(listOfCategories);
            Categories_Data.InnerText = categoriesJson;

            //Get brand data
            IQueryable<category> qParent_CategorysTable = from t in context.categories
                                             select t; // can you confirm if your context has Tables or MyTables?
            var listOfParentCategories = qParent_CategorysTable.Select(s => new {
                s.category_id,
                s.category_name,
                s.category_description,
                s.category_images,
                s.create_date,
                s.parent_id,
                s.is_publish
            }).ToList();
            var parentcCategoriesJson = new JavaScriptSerializer().Serialize(listOfParentCategories);
            Parent_Category_Data.InnerText = parentcCategoriesJson;
        }
    }
}
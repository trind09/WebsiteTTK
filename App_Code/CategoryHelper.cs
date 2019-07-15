using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CategoryHelper
/// </summary>
public class CategoryHelper
{
    public CategoryHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void DeleteCategoryByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.procategories.SingleOrDefault(b => b.category_id == id);
                if (result != null)
                {
                    context.procategories.Attach(result);
                    context.procategories.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void UpdateCategories(List<procategory> categories, bool isUpdateCategoryImages = false)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (procategory item in categories)
            {
                var result = context.procategories.SingleOrDefault(b => b.category_id == item.category_id);
                if (result != null)
                {
                    result.category_name = item.category_name;
                    result.category_description = item.category_description;
                    if (isUpdateCategoryImages)
                    {
                        result.category_images = item.category_images;
                    }
                    result.category_url = item.category_url;
                    result.create_date = item.create_date;
                    result.parent_id = item.parent_id;
                    result.is_publish = item.is_publish;
                    result.is_menu = item.is_menu;
                    result.is_label = item.is_label;
                    result.store_id = item.store_id;

                    try
                    {
                        context.SaveChanges();
                    } catch (Exception ex)
                    {
                        LogHelper.Log("App_Code\\CategoryHelper.cs", LogHelper.ErrorType.Error, ex);
                    }
                }
                else
                {
                    context.procategories.Add(new procategory
                    {
                        category_name = item.category_name,
                        category_description = item.category_description,
                        category_images = item.category_images,
                        category_url = item.category_url,
                        create_date = item.create_date,
                        parent_id = item.parent_id,
                        is_publish = item.is_publish,
                        is_menu = item.is_menu,
                        is_label = item.is_label,
                        store_id = item.store_id
                    });

                    try
                    {
                        context.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        LogHelper.Log("App_Code\\CategoryHelper.cs", LogHelper.ErrorType.Error, ex);
                    }
                }
            }
        }
    }

    public static List<procategory> GetCategoryByStoreId(int? store_id)
    {
        using (var context = new WebsiteTTKEntities())
        {
            return (from s in context.procategories.AsEnumerable()
             where s.store_id == store_id
             select new procategory
             {
                 category_id = s.category_id,
                 category_name = s.category_name,
                 category_description = s.category_description,
                 category_images = s.category_images,
                 category_url = s.category_url,
                 create_date = s.create_date,
                 parent_id = s.parent_id,
                 is_publish = s.is_publish,
                 is_menu = s.is_menu,
                 is_label = s.is_label,
                 store_id = s.store_id
             }).ToList();
        }
    }

    public static procategory GetCategoryById(int category_id)
    {
        using (var context = new WebsiteTTKEntities())
        {
            var result = context.procategories.SingleOrDefault(b => b.category_id == category_id);
            if (result != null)
            {
                procategory item = new procategory();
                item.category_id = result.category_id;
                item.category_name = result.category_name;
                item.category_description = result.category_description;
                item.category_images = result.category_images;
                item.category_url = result.category_url;
                item.create_date = result.create_date;
                item.parent_id = result.parent_id;
                item.is_publish = result.is_publish;
                item.is_menu = result.is_menu;
                item.is_label = result.is_label;
                item.store_id = result.store_id;

                return item;
            }
            return null;
        }
    }
}
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
                var result = context.categories.SingleOrDefault(b => b.category_id == id);
                if (result != null)
                {
                    context.categories.Attach(result);
                    context.categories.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void UpdateCategories(List<category> categories, bool isUpdateCategoryImages = false)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (category item in categories)
            {
                var result = context.categories.SingleOrDefault(b => b.category_id == item.category_id);
                if (result != null)
                {
                    result.category_name = item.category_name;
                    result.category_description = item.category_description;
                    if (isUpdateCategoryImages)
                    {
                        result.category_images = item.category_images;
                    }
                    result.create_date = item.create_date;
                    result.parent_id = item.parent_id;
                    result.is_publish = item.is_publish;

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
                    context.categories.Add(new category
                    {
                        category_name = item.category_name,
                        category_description = item.category_description,
                        category_images = item.category_images,
                        create_date = item.create_date,
                        parent_id = item.parent_id,
                        is_publish = item.is_publish
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
}
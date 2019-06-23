using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CategoryHepler
/// </summary>
public class CategoryHepler
{
    public CategoryHepler()
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

    public static void Updatecategorys(List<category> categorys)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (category item in categorys)
            {
                var result = context.categories.SingleOrDefault(b => b.category_id == item.category_id);
                if (result != null)
                {
                    result.category_name = item.category_name;
                    result.category_description = item.category_description;
                    result.images = item.images;
                    result.create_date = item.create_date;
                    result.parent_id = item.parent_id;
                    context.SaveChanges();
                }
                else
                {
                    context.categories.Add(new category
                    {
                        category_name = item.category_name,
                        category_description = item.category_description,
                        images = item.images,
                        create_date = item.create_date,
                        parent_id = item.parent_id
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatecategorys()
    {
        throw new NotImplementedException();
    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BrandHelper
/// </summary>
public class BrandHelper
{
    public BrandHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void DeleteBrandByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.brands.SingleOrDefault(b => b.brand_id == id);
                if (result != null)
                {
                    context.brands.Attach(result);
                    context.brands.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatebrands(List<brand> brands)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (brand item in brands)
            {
                var result = context.brands.SingleOrDefault(b => b.brand_id == item.brand_id);
                if (result != null)
                {
                    result.brand_name = item.brand_name;
                    result.brand_description = item.brand_description;
                    result.images = item.images;
                    result.create_date = item.create_date;
                    context.SaveChanges();
                }
                else
                {
                    context.brands.Add(new brand
                    {
                        brand_name = item.brand_name,
                        brand_description = item.brand_description,
                        images = item.images,
                        create_date = item.create_date,
                      
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatebrands()
    {
        throw new NotImplementedException();
    }

    
}
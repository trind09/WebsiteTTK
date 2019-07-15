using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProductHelper
/// </summary>
public class ProductHelper
{
    public ProductHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void DeleteProductByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.products.SingleOrDefault(b => b.product_id == id);
                if (result != null)
                {
                    context.products.Attach(result);
                    context.products.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void UpdateProducts(List<product> products, bool isUpdateProductImages = false)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (product item in products)
            {
                var result = context.products.SingleOrDefault(b => b.product_id == item.product_id);
                if (result != null)
                {
                    result.product_name = item.product_name;
                    result.product_description = item.product_description;
                    if (isUpdateProductImages)
                    {
                        result.product_images = item.product_images;
                    }
                    result.brand_id = item.brand_id;
                    result.category_id = item.category_id;
                    result.colour_id = item.colour_id;
                    result.model_year = item.model_year;
                    result.list_price = item.list_price;
                    result.create_date = item.create_date;
                    result.create_by = item.create_by;
                    result.is_publish = item.is_publish;
                    result.is_featured = item.is_featured;
                    result.is_sale = item.is_sale;
                    result.is_new = item.is_new;
                    result.is_gift = item.is_gift;
                    result.currency_id = item.currency_id;

                    context.SaveChanges();
                } else
                {
                    context.products.Add(new product {
                        product_name = item.product_name,
                        product_description = item.product_description,
                        product_images = item.product_images,
                        brand_id = item.brand_id,
                        category_id = item.category_id,
                        colour_id = item.colour_id,
                        model_year = item.model_year,
                        list_price = item.list_price,
                        create_date = item.create_date,
                        create_by = item.create_by,
                        is_publish = item.is_publish,
                        is_featured = item.is_featured,
                        is_sale = item.is_sale,
                        is_new = item.is_new,
                        is_gift = item.is_gift,
                        currency_id = item.currency_id
                    });

                    context.SaveChanges();
                }
            }
        }
    }
}
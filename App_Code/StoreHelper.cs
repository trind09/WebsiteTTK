using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for StoreHelper
/// </summary>
public class StoreHelper
{
    public StoreHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteStoreByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.stores.SingleOrDefault(b => b.store_id == id);
                if (result != null)
                {
                    context.stores.Attach(result);
                    context.stores.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }
    public static void Updatestores(List<store> stores)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (store item in stores)
            {
                var result = context.stores.SingleOrDefault(b => b.store_id == item.store_id);
                if (result != null)
                {
                    result.store_name  = item.store_name;
                    result.phone = item.phone;
                    result.email = item.email;
                    result.street = item.street;
                    result.city = item.city;
                    result.zip_code = item.zip_code;
                    context.SaveChanges();
                }
                else
                {
                    context.stores.Add(new store
                    {
                        store_id = item.store_id,
                        store_name = item.store_name,
                        phone = item.phone,
                        email = item.email,
                        street = item.street,
                        city = item.city,
                        zip_code = item.zip_code,
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatestores()
    {
        throw new NotImplementedException();
    }
}
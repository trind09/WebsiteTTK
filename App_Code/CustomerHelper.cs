using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CustomerHelper
/// </summary>
public class CustomerHelper
{
    public CustomerHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteCustomerByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.customers.SingleOrDefault(b => b.customer_id == id);
                if (result != null)
                {
                    context.customers.Attach(result);
                    context.customers.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatecustomers(List<customer> customers)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (customer item in customers)
            {
                var result = context.customers.SingleOrDefault(b => b.customer_id == item.customer_id);
                if (result != null)
                {
                    result.first_name = item.first_name;
                    result.last_name = item.last_name;
                    result.phone = item.phone;
                    result.email = item.email;
                    result.street = item.street;
                    result.city = item.city;
                    result.phone = item.phone;
                    result.zip_code = item.zip_code;
                    result.address = item.address;
                    context.SaveChanges();
                }
                else
                {
                    context.customers.Add(new customer
                    {
                        first_name = item.first_name,
                        last_name = item.last_name,
                        phone = item.phone,
                        email = item.email,
                        street = item.street,
                        city = item.city,
                        zip_code = item.zip_code,
                        address = item.address,
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatecustomers()
    {
        throw new NotImplementedException();
    }
}
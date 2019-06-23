using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OrderHelper
/// </summary>
public class OrderHelper
{
    public OrderHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteOrderByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.orders.SingleOrDefault(b => b.order_id == id);
                if (result != null)
                {
                    context.orders.Attach(result);
                    context.orders.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }
    public static void Updateorders(List<order> orders)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (order item in orders)
            {
                var result = context.orders.SingleOrDefault(b => b.order_id == item.order_id);
                if (result != null)
                {
                    result.customer_id = item.customer_id;
                    result.order_status = item.order_status;
                    result.order_date = item.order_date;
                    result.required_date = item.required_date;
                    result.shipped_date = item.shipped_date;
                    result.store_id = item.store_id;
                    result.staff_id = item.staff_id;
                    context.SaveChanges();
                }
                else
                {
                    context.orders.Add(new order
                    {
                        order_id = item.order_id,
                        order_status = item.order_status,
                        order_date = item.order_date,
                        required_date = item.required_date,
                        shipped_date = item.shipped_date,
                        store_id = item.store_id,
                        staff_id = item.staff_id,
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updateorders()
    {
        throw new NotImplementedException();
    }
}
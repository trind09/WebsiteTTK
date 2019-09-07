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
                    result.order_discount = item.order_discount;
                    result.order_discount_is_fixed = item.order_discount_is_fixed;
                    result.delivery_id = item.delivery_id;
                    result.currency_id = item.currency_id;
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
                        order_discount = item.order_discount,
                        order_discount_is_fixed = item.order_discount_is_fixed,
                        delivery_id = item.delivery_id,
                        currency_id = item.currency_id
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    /// <summary>
    /// Get new created order of customer
    /// </summary>
    /// <param name="userId">user id</param>
    /// <returns></returns>
    public static order GetNewCreatedOrder(string userId)
    {
        try
        {
            using (var context = new WebsiteTTKEntities())
            {
                return context.orders.FirstOrDefault(x => x.customer_id == userId && x.order_status == (int)OrderStatus.Status.New);
            }
        } catch (Exception ex)
        {
            LogHelper.Log("App_Code\\Helper\\OrderHelper.cs", LogHelper.ErrorType.Error, ex);
            return null;
        }
    }
}
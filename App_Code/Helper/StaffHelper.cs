using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for StaffHelper
/// </summary>
public class StaffHelper
{
    public StaffHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteStaffByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.staffs.SingleOrDefault(b => b.staff_id == id);
                if (result != null)
                {
                    context.staffs.Attach(result);
                    context.staffs.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }
    public static void Updatestaffs(List<staff> staffs)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (staff item in staffs)
            {
                var result = context.staffs.SingleOrDefault(b => b.staff_id == item.staff_id);
                if (result != null)
                {
                    result.first_name = item.first_name;
                    result.last_name = item.last_name;
                    result.phone = item.phone;
                    result.email = item.email;
                    result.phone = item.phone;
                    result.active = item.active;
                    result.store_id = item.store_id;
                    result.manager_id = item.manager_id;
                    result.address = item.address;
                    context.SaveChanges();
                }
                else
                {
                    context.staffs.Add(new staff
                    {
                        staff_id = item.staff_id,
                        first_name = item.first_name,
                        last_name = item.last_name,
                        phone = item.phone,
                        email = item.email,
                        active = item.active,
                        store_id = item.store_id,
                        manager_id = item.manager_id,
                        address = item.address,
                    });

                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatestaffs()
    {
        throw new NotImplementedException();
    }
}
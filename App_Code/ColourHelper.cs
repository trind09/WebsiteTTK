using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ColourHelper
/// </summary>
public class ColourHelper
{
    public ColourHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void DeleteColourByIds(List<int> deletedIds)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (var id in deletedIds)
            {
                var result = context.colours.SingleOrDefault(b => b.colour_id == id);
                if (result != null)
                {
                    context.colours.Attach(result);
                    context.colours.Remove(result);
                    context.SaveChanges();
                }
            }
        }
    }

    public static void Updatecolours(List<colour> colours, bool isUpdateProductImages = false)
    {
        using (var context = new WebsiteTTKEntities())
        {
            foreach (colour item in colours)
            {
                var result = context.colours.SingleOrDefault(b => b.colour_id == item.colour_id);
                if (result != null)
                {
                    result.colour_name = item.colour_name;
                    result.colour_description = item.colour_description;
                    result.create_date = item.create_date;

                    context.SaveChanges();
                }
                else
                {
                    context.colours.Add(new colour
                    {
                        colour_name = item.colour_name,
                        colour_description = item.colour_description,
                        create_date = item.create_date,
                    });

                    context.SaveChanges();
                }
            }
        }
    }
}
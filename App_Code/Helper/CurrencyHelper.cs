using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CurrencyHelper
/// </summary>
public class CurrencyHelper
{
    public CurrencyHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static currency GetCurrencyById(int? currency_id)
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            var currency = context.currencies.FirstOrDefault(x => x.currency_id == currency_id);
            return currency;
        }
    }
}
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
            IQueryable<currency> qCurrenciesTable = from t in context.currencies
                                                 where t.currency_id == currency_id
                                                  select t; // can you confirm if your context has Tables or MyTables?
            var listOfCurrencies = qCurrenciesTable.Select(s => new currency
            {
                currency_id = s.currency_id,
                currency_name = s.currency_name,
                currency_code = s.currency_code,
                currency_symbol = s.currency_symbol
            }).ToList();

            if (listOfCurrencies.Count > 0)
            {
                return listOfCurrencies.FirstOrDefault();
            }
            return null;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for HomeModel
/// </summary>
public class ProductCurrency
{
    public int product_id { get; set; }
    public string product_name { get; set; }
    public string product_description { get; set; }
    public string product_images { get; set; }
    public int brand_id { get; set; }
    public int category_id { get; set; }
    public int model_year { get; set; }
    public decimal list_price { get; set; }
    public DateTime? create_date { get; set; }
    public string create_by { get; set; }
    public bool? is_publish { get; set; }
    public bool? is_featured { get; set; }
    public bool? is_sale { get; set; }
    public bool? is_new { get; set; }
    public bool? is_gift { get; set; }
    public int? colour_id { get; set; }
    public int? currency_id { get; set; }
    public string currency_name { get; set; }
    public string currency_code { get; set; }
    public string currency_symbol { get; set; }
}
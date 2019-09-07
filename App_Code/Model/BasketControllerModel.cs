using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PasketControllerModel
/// </summary>
public class BasketControllerModel
{
    public ProductCurrency Product { get; set; }
    public procategory Category { get; set; }
    public store Store { get; set; }
    public order Order { get; set; }
    public List<OrderItem> OrderItems { get; set; }
    public double OrderTotal { get; set; }
    public double ShippingTotal { get; set; }
    public double TaxTotal { get; set; }
    public double TotalItem { get; set; }
    public double GrandTotal { get; set; }
    public string CurrencyCode { get; set; }
    public double TotalDiscount { get; set; }
}
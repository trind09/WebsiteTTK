using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for HomeModel
/// </summary>
public class ProductControllerModel
{
    public List<ProductCurrency> FeaturedProducts { get; set; }
    public ProductCurrency Product { get; set; }
    public procategory Category { get; set; }
    public List<CategoryProduct> Categories { get; set; }
    public List<BrandProduct> Brands { get; set; }
    public List<ColourProduct> Colours { get; set; }
    public List<ProductCurrency> RelativeProducts { get; set; }
    public List<ProductCurrency> ProductItems { get; set; }
    public int TotalProducts { get; set; }
    public store Store { get; set; }
    public List<wishlist> Wishlists { get; set; }
    public string Message { get; set; }
    public bool Success { get; set; }
    public ResultCode ResultCode { get; set; }
    public order Order { get; set; }
    public List<OrderItem> OrderItems { get; set; }
    public List<order_items> order_items { get; set; }
}
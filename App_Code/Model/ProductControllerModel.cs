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
}
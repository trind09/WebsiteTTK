using System;

public class CategoryProduct
{
    public int category_id { get; set; }
    public string category_name { get; set; }
    public string category_description { get; set; }
    public string category_images { get; set; }
    public string category_url { get; set; }
    public DateTime? create_date { get; set; }
    public int? parent_id { get; set; }
    public bool? is_publish { get; set; }
    public bool? is_menu { get; set; }
    public bool? is_label { get; set; }
    public int? store_id { get; set; }
    public string store_name { get; set; }
    public int product_count { get; set; }
}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PushDataToClient();
        }
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            IQueryable<product> qProductsTable = from t in context.products where t.is_featured == true
                                                 select t; // can you confirm if your context has Tables or MyTables?
            var listOfProducts = qProductsTable.Select(s => new {
                s.product_id,
                s.product_name,
                s.product_description,
                s.product_images,
                s.brand_id,
                s.category_id,
                s.colour_id,
                s.model_year,
                s.list_price,
                s.create_date,
                s.create_by,
                s.is_publish,
                s.is_featured,
                s.is_sale,
                s.is_new,
                s.is_gift
            }).ToList();

            var product_slider = "";
            foreach (var item in listOfProducts)
            {
                var product_image = "img/no_image.jpg";
                var itemHtml = "<div class='item'><div class='product'><div class='flip-container'><div class='flipper'>";
                int counter = 0;
                int image_counter = 0;
                if (item.product_images != null && item.product_images != "")
                {
                    var images = item.product_images.Split(';');
                    for (int i = 0; i < images.Length; i++)
                    {
                        var image = images[i];
                        if (image != "")
                        {
                            if (counter == 0)
                            {
                                product_image = image; //Set the first image of this product. Which could use as the fron image
                                itemHtml += "<div class='front'><a href='/product-detail.aspx?product_id=" + item.product_id + "'>"
                                    + "<img src='" + image + "' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                                image_counter++;
                            }
                            else if (counter == 1)
                            {
                                itemHtml += "<div class='back'><a href='/product-detail.aspx?product_id=" + item.product_id + "'>"
                                    + "<img src='" + image + "' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                                image_counter++;
                            }
                            counter++;
                        }
                    }
                    if (image_counter == 1)
                    {
                        itemHtml += "<div class='back'><a href='/product-detail.aspx?product_id=" + item.product_id + "'>"
                                    + "<img src='img/no_image.jpg' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                    }
                }
                else
                {
                    for (int i = 0; i < 2; i++)
                    {
                        if (i == 0)
                        {
                            itemHtml += "<div class='front'><a href='/product-detail.aspx?product_id=" + item.product_id + "'>"
                                + "<img src='img/no_image.jpg' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                        }
                        else if (i == 1)
                        {
                            itemHtml += "<div class='back'><a href='/product-detail.aspx?product_id=" + item.product_id + "'>"
                                + "<img src='img/no_image.jpg' alt='" + item.product_name + "' class='img-fluid'></a></div>";
                        }
                    }
                }
                itemHtml += "</div></div><a href='/product-detail.aspx?product_id=" + item.product_id + "' class='invisible'>"
                    + "<img src='" + product_image + "' alt='" + item.product_name + "' class='img-fluid'></a><div class='text'>"
                    + "<h3><a href='/product-detail.aspx?product_id=" + item.product_id + "'>" + item.product_name + "</a></h3>"
                    + "<p class='price'><del></del>" + item.list_price + "đ</p></div>";

                if (item.is_sale != null)
                {
                    if (item.is_sale.Value)
                    {
                        itemHtml += "<div class='ribbon sale'><div class='theribbon'>SALE</div><div class='ribbon-background'></div></div>";
                    }
                }

                if (item.is_new != null)
                {
                    if (item.is_new.Value)
                    {
                        itemHtml += "<div class='ribbon new'><div class='theribbon'>NEW</div><div class='ribbon-background'></div></div>";
                    }
                }

                if (item.is_gift != null)
                {
                    if (item.is_gift.Value)
                    {
                        itemHtml += "<div class='ribbon gift'><div class='theribbon'>GIFT</div><div class='ribbon-background'></div></div>";
                    }
                }

                //End of product item
                itemHtml += "</div></div>";
                product_slider += itemHtml;
            }
            ttk_shop_slider.InnerHtml = product_slider;
        }
    }
}
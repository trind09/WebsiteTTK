using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeliveryModel
/// </summary>
public class DeliveryModel
{
    public List<delivery_methods> DeliveryMethods { get; set; }
    public delivery_methods DeliveryMethod { get; set; }
    public currency Currency { get; set; }
    public string UserId { get; set; }
}
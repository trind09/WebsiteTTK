using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OrderStatus
/// </summary>
public class OrderStatus
{
    public enum Status
    {
        New,
        Canceled,
        OnHold,
        PendingPayment,
        PaymentReceived,
        Refunded,
        OrderInvoiced,
        OrderShipped,
        Complete,
        OrderArchived,
        Closed
    }
}
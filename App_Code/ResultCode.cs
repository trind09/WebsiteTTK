using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ResultCode
/// </summary>
public class ResultCode
{
    private ResultCode(object[] value) { Value = value; }

    public object[] Value { get; set; }

    public static ResultCode NotLogin { get { return new ResultCode(new object[] {0, "Please login!"}); } }
    public static ResultCode LoginToWishlist { get { return new ResultCode(new object[] { 1, "Please login to save this product to your wishlist!" }); } }
    public static ResultCode AddToWishlistSuccess { get { return new ResultCode(new object[] { 2, "Product added to wishlist successful!" }); } }
    public static ResultCode AddToWishlistFail { get { return new ResultCode(new object[] { 3, "Add to wishlist fail!" }); } }
    public static ResultCode ProductDoesNotExist { get { return new ResultCode(new object[] { 4, "Product doesn't exist!" }); } }

    public static List<ResultCode> GetResultSet()
    {
        List<ResultCode> list = new List<ResultCode>();
        list.Add(NotLogin);
        list.Add(LoginToWishlist);
        list.Add(AddToWishlistSuccess);
        list.Add(AddToWishlistFail);
        list.Add(ProductDoesNotExist);
        return list;
    }
}
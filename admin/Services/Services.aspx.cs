using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Services_Services : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string CallMe()
    {
        var list = new List<KeyValuePair<string, int>>();
        list.Add(new KeyValuePair<string, int>("Cat", 1));
        list.Add(new KeyValuePair<string, int>("Dog", 2));
        list.Add(new KeyValuePair<string, int>("Rabbit", 4));

        JavaScriptSerializer js = new JavaScriptSerializer();
        string jsonData = js.Serialize(list);
        return jsonData;
    }
}
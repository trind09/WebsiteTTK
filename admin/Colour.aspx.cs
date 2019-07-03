using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Colour : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PushDataToClient();
        }
    }

    protected void btnApplyAllChanges_Click(object sender, EventArgs e)
    {
        //Create product list from json posted from client
        List<colour> colours = new List<colour>();
        var coloursJson = Colour_Data_To_Post_To_Server.Text;
        dynamic coloursResponse = JsonConvert.DeserializeObject(coloursJson);
        if (coloursResponse.Count > 0)
        {
            List<object> colourObjects = coloursResponse.ToObject<List<object>>();
            foreach (var obj in colourObjects)
            {
                colour item = new colour();

                int colour_id = -1;
                Int32.TryParse(Helper.GetPropValue(obj + "", "colour_id") + "", out colour_id);
                item.colour_id = colour_id;

                item.colour_name = Helper.GetPropValue(obj + "", "colour_name") + "";
                item.colour_description = Helper.GetPropValue(obj + "", "colour_description") + "";

                item.create_date = Helper.ConverToDateTime(Helper.GetPropValue(obj + "", "create_date") + "");


                colours.Add(item);
            }
        }

        //Delete records from product
        //Get product ids from json posted from client
        var deletedIdsJson = txtDeletedIds.Text;
        dynamic deletedIdsResponse = JsonConvert.DeserializeObject(deletedIdsJson);
        if (deletedIdsResponse.Count > 0)
        {
            List<int> deletedIds = deletedIdsResponse.ToObject<List<int>>();

            if (deletedIds.Count > 0)
            {
                foreach (var id in deletedIds)
                {
                    var found = colours.Find(x => x.colour_id == id);
                    if (found != null) colours.Remove(found);
                }
                ColourHelper.DeleteColourByIds(deletedIds);
            }
        }

        ColourHelper.Updatecolours(colours);
        PushDataToClient();
    }

    //Push data to client
    private void PushDataToClient()
    {
        using (var context = new WebsiteTTKEntities())
        {
            //Get product data
            IQueryable<colour> qColoursTable = from t in context.colours
                                               select t; // can you confirm if your context has Tables or MyTables?
            var listOfColours = qColoursTable.Select(s => new
            {
                s.colour_id,
                s.colour_name,
                s.colour_description,
                s.create_date,
            }).ToList();
            var coloursJson = new JavaScriptSerializer().Serialize(listOfColours);
            Colour_Data.InnerText = coloursJson;


        }
    }
}
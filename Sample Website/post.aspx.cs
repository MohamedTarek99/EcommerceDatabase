using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class post : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void postproduct(object sender, EventArgs e)
    {
        string user = (string)(Session["username"]);


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("postProduct", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        Decimal amount = 0;

        //To read the input from the 
        try
        {
             amount = Convert.ToDecimal(price.Text);
        }
        catch(Exception error)
        {
            Response.Write(error.Message);
            return;
        }
        String desc = description.Text;
        String Color = color.Text;
        String name = productname.Text;
        string Category = category.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@vendorusername", user));
        cmd.Parameters.Add(new SqlParameter("@product_name", name));
        cmd.Parameters.Add(new SqlParameter("@product_description", desc));
        cmd.Parameters.Add(new SqlParameter("@color", Color));
        cmd.Parameters.Add(new SqlParameter("@price", amount));
        cmd.Parameters.Add(new SqlParameter("@category", Category));




        Int32 rows = 0;

        conn.Open();

        rows = cmd.ExecuteNonQuery();

        if (rows < 1)
        {
            Response.Write("Your account is not activated!");
        }
        else
        {
            Response.Write("Product posted!");
        }




        conn.Close();



    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class cartpage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = (string)(Session["username"]);


        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("viewMyCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        conn.Open();

        cmd.Parameters.Add(new SqlParameter("@customer", user));
        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            //Get the value of the attribute name in the Company table
            string productname = rdr.GetString(rdr.GetOrdinal("product_name"));
            //Get the value of the attribute field in the Company table
            string description = rdr.GetString(rdr.GetOrdinal("product_description"));
            Decimal price = (Decimal)rdr.GetSqlDecimal(rdr.GetOrdinal("price"));
            Decimal final_price = (Decimal)rdr.GetSqlDecimal(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            Int32 serial = (Int32)rdr.GetInt32(rdr.GetOrdinal("serial_no"));

            //Create a new label and add it to the HTML form
            Label lbl_CompanyName = new Label();
            lbl_CompanyName.Text = "  <br /> <br />" + "product name:" + productname + " description:" + description + " color:" + color + " price:" + price + " finalPrice:" + final_price + "  ";
            form1.Controls.Add(lbl_CompanyName);



            Button A = new Button();
            A.Text = "remove from cart";
            A.Visible = true;

            A.Click += delegate (object sender1, EventArgs e1) { remove(sender1, e1, serial); };

            form1.Controls.Add(A);
        }



    }

    protected void remove(object sender, EventArgs e, Int32 serial)
    {


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removefromCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 

        string user = (string)(Session["username"]);


        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));


        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("cartpage.aspx", true);




    }


    protected void makeorder(object sender, EventArgs e)
    {


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("makeOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        Boolean success = true;

        string user = (string)(Session["username"]);


        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
                }
        catch (SqlException)
        {
            success = false;
            Response.Write("There are no products in your carts");
        }
        conn.Close();

        if (success) {
            Response.Redirect("orderpage.aspx", true);
        }
    }
}
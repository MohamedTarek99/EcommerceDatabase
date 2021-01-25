using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class vendor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        string user = (string)(Session["username"]);

        SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@vendorUsername", user));


        conn.Open();

        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        { //Get the value of the attribute name in the Company table
            string productname = rdr.GetString(rdr.GetOrdinal("product_name"));
            //Get the value of the attribute field in the Company table
            string description = rdr.GetString(rdr.GetOrdinal("product_description"));
            string category = rdr.GetString(rdr.GetOrdinal("category"));
            Decimal price = (Decimal)rdr.GetSqlDecimal(rdr.GetOrdinal("price"));
            Decimal final_price = (Decimal)rdr.GetSqlDecimal(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            Int32 serial = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
            Boolean avaliablity = rdr.GetBoolean(rdr.GetOrdinal("avaliable"));
            Int32 rate =  rdr.GetInt32(rdr.GetOrdinal("rate"));
            string vendoruser = rdr.GetString(rdr.GetOrdinal("vendor_username"));
            string customer;
            string order;
            
          if(rdr.IsDBNull(rdr.GetOrdinal("customer_username")))
            {
                customer = "NULL";
            }
            else
            {
                customer = rdr.GetString(rdr.GetOrdinal("customer_username"));

            }
            
            if (rdr.IsDBNull(rdr.GetOrdinal("customer_order_id")))
            {
                order = "null";
            }
            else
            {
                 order = Convert.ToString(rdr.GetInt32(rdr.GetOrdinal("customer_order_id")));
            }


            //Create a new label and add it to the HTML form
            Label product = new Label();
            product.Text = "  <br /> <br />" +"Serial: "+serial+ "   Product name: " + productname + "   description: " + description + "   color: " + color + "   price: " + price + "   finalPrice: " + final_price + "   Availability: " + avaliablity + "   rate:" + rate+"  vendor:"+vendoruser+"    customerUsername:"+customer+"    customer_order_id:"+order;
            form1.Controls.Add(product);
        }




    }

    protected void addoffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addOffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        Int32 Amount = 0;
        try
        {
             Amount = Convert.ToInt32(amount.Text);
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }
        String Date = date.Text;


        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@offeramount", Amount));
        try
        {
            cmd.Parameters.Add(new SqlParameter("@expiry_date", Date));
        }
        catch (SqlException)
        {
            Response.Write("Invalid input");
            return;
        }
     
            conn.Open();
            cmd.ExecuteNonQuery();
       

            Response.Write("Offer Created");
        

        conn.Close();
       





    }
    protected void applyoffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("applyOffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlCommand cmd1 = new SqlCommand("checkOfferonProduct", conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        //To read the input from the 
        Boolean success = true;
        Int32 Serial = 0;
        Int32 Offer = 0;
        string user = (string)(Session["username"]);
        try
        {
             Serial = Convert.ToInt32(serial.Text);
             Offer = Convert.ToInt32(offer.Text);
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }

        //pass parameters to the stored procedure

        cmd.Parameters.Add(new SqlParameter("@serial", Serial));
        cmd.Parameters.Add(new SqlParameter("@vendorname", user));
        cmd.Parameters.Add(new SqlParameter("@offerid", Offer));


        cmd1.Parameters.Add(new SqlParameter("@serial", Serial));


        SqlParameter active = cmd1.Parameters.Add("@activeoffer", SqlDbType.Bit);
        active.Direction = ParameterDirection.Output;




        int rows = 0;
     
            conn.Open();
            cmd1.ExecuteNonQuery();

      Boolean active1 = Convert.ToBoolean(active.Value);

        if (active1)
        {
            Response.Write("This product already has an active offer!");
        }
        else
        {
            try
            {
                rows=cmd.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                Response.Write("Please recheck the serial number and the offer id that you entered!");
                success = false;
            }

            if (success)
            {
                if (rows <= 0)
                {
                    Response.Write("Please recheck the serial number and the offer id that you entered!");
                }
                else
                {
                    Response.Redirect("vendor.aspx", true);

                }
            }



        }

        conn.Close();
       

        




    }
    protected void addphone(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addMobile", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        String mobile = phone.Text;
        Boolean success = true;

        string user = (string)(Session["username"]);

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@username", user));
        cmd.Parameters.Add(new SqlParameter("@mobile_number", mobile));

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {

            Response.Write("This number is already added");
            success = false;
        }

        conn.Close();
        if (success == true)
        {
            Response.Write("Number added successfully");
        }






    }




    protected void checkoffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        Int32 ID = 0;
        //To read the input from the 
        try
        {
             ID = Convert.ToInt32(id.Text);
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@offerid", ID));

        Int32 rows = 0;
        conn.Open();
        rows=cmd.ExecuteNonQuery();
        if (rows < 1)
        {
            Response.Write("This offer did not expire yet");
        }
        else
        {
            Response.Redirect("vendor.aspx", true);
        }


      


        conn.Close();






    }

}
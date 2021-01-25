using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        string user = (string)(Session["username"]);

        SqlCommand cmd = new SqlCommand("reviewOrders", conn);
        cmd.CommandType = CommandType.StoredProcedure;



        conn.Open();
        
        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        { //Get the value of the attribute name in the Company table
            Int32 order =  rdr.GetInt32(rdr.GetOrdinal("order_no"));
            //Get the value of the attribute field in the Company table
            DateTime date = rdr.GetDateTime(rdr.GetOrdinal("order_date"));
            string status = rdr.GetString(rdr.GetOrdinal("order_status"));
            string customer = rdr.GetString(rdr.GetOrdinal("customer_name"));
            string total;
            string credit;
            string cash;
            string days;
            string time;
            string giftcard;
            string delivery;
            string card;
            string type;

            if (rdr.IsDBNull(rdr.GetOrdinal("total_amount")))
            {
                total = "NULL";
            }
            else
            {
                total = Convert.ToString(rdr.GetSqlDecimal(rdr.GetOrdinal("total_amount")));
            }

            if (rdr.IsDBNull(rdr.GetOrdinal("cash_amount")))
            {
                cash = "NULL";
            }
            else
            {
                cash = Convert.ToString(rdr.GetSqlDecimal(rdr.GetOrdinal("credit_amount")));

            }

            if (rdr.IsDBNull(rdr.GetOrdinal("credit_amount")))
            {
                credit = "NULL";
            }
            else
            {
                credit = Convert.ToString(rdr.GetSqlDecimal(rdr.GetOrdinal("credit_amount")));
            }

               if (rdr.IsDBNull(rdr.GetOrdinal("remaining_days")))
            {
                days = "NULL";
            }
            else
            {
                days = Convert.ToString(rdr.GetInt32(rdr.GetOrdinal("remaining_days")));
            }

            if (rdr.IsDBNull(rdr.GetOrdinal("time_limit")))
            {
                time = "NULL";
            }
            else
            {
                time = Convert.ToString(rdr.GetInt32(rdr.GetOrdinal("time_limit")));
            }

            if (rdr.IsDBNull(rdr.GetOrdinal("Gift_Card_code_used")))
            {
                giftcard = "NULL";
            }
            else
            {
                giftcard =(rdr.GetString(rdr.GetOrdinal("Gift_Card_code_used")));
            }

          

            if (rdr.IsDBNull(rdr.GetOrdinal("payment_type")))
            {
                type = "NULL";
            }
            else
            {
                type = (rdr.GetString(rdr.GetOrdinal("payment_type")));
            }

            if (rdr.IsDBNull(rdr.GetOrdinal("delivery_id")))
            {
                delivery = "NULL";
            }
            else
            {
                delivery = Convert.ToString(rdr.GetInt32(rdr.GetOrdinal("delivery_id")));
            }
            if (rdr.IsDBNull(rdr.GetOrdinal("creditCard_number")))
            {
                card = "NULL";
            }
            else
            {
                card = (rdr.GetString(rdr.GetOrdinal("creditCard_number")));
            }


            //Create a new label and add it to the HTML form
            Label product = new Label();
            product.Text = "  <br /> <br />" + "Order_no: " + order + "   order_date: " + date + "   total_amount: " + total + "   cash_amount : " + cash + "   credit_amount: " + credit + "   payment_type: " + type + "   order_status: " + status + "   remaining_days:" + days + "   time_limit:" + time + "    Gift_Card_code_used:" + giftcard + "    customer_name:" + customer+ "    delivery_id:" + delivery+ "    creditCard_number:" + card;
            form1.Controls.Add(product);
        }




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


    protected void activate(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("activateVendors", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        string vendor = username.Text;
        string user = (string)(Session["username"]);
        Int32 rows = 0;
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@admin_username", user));
        cmd.Parameters.Add(new SqlParameter("@vendor_username", vendor));

      
            conn.Open();
            rows=cmd.ExecuteNonQuery();


        conn.Close();

        if (rows < 1)
        {
            Response.Write("Invalid vendor username");
        }
        else
        {
            Response.Write("Vendor activated");
        }
     




    }




    protected void update(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("updateOrderStatusInProcess", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        int id = 0;
        //To read the input from the 
        try
        {
            id = Convert.ToInt32(order_id.Text);
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }
        Int32 rows = 0;
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@order_no", id));


        conn.Open();
        rows = cmd.ExecuteNonQuery();


        conn.Close();

        if (rows < 1)
        {
            Response.Write("Invalid order id!");
        }
        else
        {
            Response.Redirect("admin.aspx", true);
        }





    }


    protected void createDeal(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        Int32 Amount = 0;
        //To read the input from the 

        String Date = date.Text;
        string user = (string)(Session["username"]);

        try
        {
            Amount = Convert.ToInt32(amount.Text);

        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }

        Int32 rows = 0;
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@expiry_date", Date));
        cmd.Parameters.Add(new SqlParameter("@deal_amount", Amount));
        cmd.Parameters.Add(new SqlParameter("@admin_username", user));




        conn.Open();
        try
        {
            rows = cmd.ExecuteNonQuery();
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }

        conn.Close();

        Response.Write("Deal created!");      




    }

    protected void addDeal(object sender, EventArgs e)
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
        Int32 Deal = 0;

        string user = (string)(Session["username"]);
        try
        {
             Serial = Convert.ToInt32(serial.Text);
             Deal = Convert.ToInt32(deal.Text);
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
            return;
        }
        //pass parameters to the stored procedure

        cmd.Parameters.Add(new SqlParameter("@serial", Serial));
        cmd.Parameters.Add(new SqlParameter("@vendorname", user));
        cmd.Parameters.Add(new SqlParameter("@offerid", Deal));


        cmd1.Parameters.Add(new SqlParameter("@serial", Serial));


        SqlParameter active = cmd1.Parameters.Add("@checkTodaysDealOnProduct", SqlDbType.Bit);
        active.Direction = ParameterDirection.Output;




        int rows = 0;

        conn.Open();
        cmd1.ExecuteNonQuery();

        Boolean active1 = Convert.ToBoolean(active.Value);

        if (active1)
        {
            Response.Write("This product already has an active deal!");
        }
        else
        {
            try
            {
                rows = cmd.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                Response.Write("Please recheck the serial number and the deal id that you enter!");
                success = false;
            }

            if (success)
            {
                if (rows < 0)
                {
                    Response.Write("Please recheck the serial number and the deal id that you entered!");
                }
                else
                {
                    Response.Write("Todays deal added to product");

                }
            }



        }

        conn.Close();







    }


    protected void checkdeal(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removeExpiredDeal", conn);
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
        cmd.Parameters.Add(new SqlParameter("@deal_iD", ID));

        Int32 rows = 0;
        conn.Open();
       
            rows = cmd.ExecuteNonQuery();
        
        if (rows < 1)
        {
            Response.Write("This deal did not expire yet");
        }
        else
        {
            Response.Write("This expired deal was removed successfully");
            ;
        }





        conn.Close();






    }



}
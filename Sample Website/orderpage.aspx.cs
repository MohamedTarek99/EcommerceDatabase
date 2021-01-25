using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class orderpage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        string user = (string)(Session["username"]);

        SqlCommand cmd = new SqlCommand("showuserorder", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@customername", user));


        conn.Open();

        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            Int32 order = (Int32)rdr.GetInt32(rdr.GetOrdinal("order_no"));

            Decimal price = (Decimal)rdr.GetSqlDecimal(rdr.GetOrdinal("total_amount"));


            //Create a new label and add it to the HTML form
            Label orderlabel = new Label();
            orderlabel.Text = "  <br /> <br />" + "order number:" + order + " price:" + price + "  ";
            form1.Controls.Add(orderlabel);



            Button A = new Button();
            A.Text = "cancel";
            A.Visible = true;

            A.Click += delegate (object sender1, EventArgs e1) { cancelOrder(sender1, e1, order); };

            form1.Controls.Add(A);
        }





    }

    protected void cancelOrder(object sender, EventArgs e, Int32 order)
    {


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("cancelOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@orderid",order));
     
        Int32 rows = 0;


        conn.Open();
        rows = cmd.ExecuteNonQuery();



        if (rows < 1)
        {
            Response.Write("This order cannot be canceled");
        }
        else
        {

            Response.Redirect("orderpage.aspx", true);
        }



    }


    protected void paycash(object sender, EventArgs e)
    {
        string user = (string)(Session["username"]);


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;
        Decimal cashamount = 0;
        Int32 order = 0;

        //To read the input from the 
        try
        {
            cashamount = Convert.ToDecimal(cash.Text);
            order = Convert.ToInt32(orderc.Text);
        }catch(Exception error)
        {
            Response.Write(error.Message);
            return;
        }
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@orderID",order ));
        cmd.Parameters.Add(new SqlParameter("@cash", cashamount));
        cmd.Parameters.Add(new SqlParameter("@credit",DBNull.Value));





        Int32 rows = 0;

        
            conn.Open();
            rows = cmd.ExecuteNonQuery();


        conn.Close();

        if (rows <1)
        {
            Response.Write("Invalid order number");

        }
        else
        {
            Response.Write("Payment successful");
        }


        }






    protected void paycredit(object sender, EventArgs e)
    {
        string user = (string)(Session["username"]);


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlCommand cmd1 = new SqlCommand("ChooseCreditCard", conn);
        cmd1.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        Decimal creditamount = 0;
        Int32 order = 0;
        try
        {
            creditamount = Convert.ToDecimal(credit.Text);
            order = Convert.ToInt32(ordercr.Text);
        }catch(Exception error)
        {
            Response.Write(error.Message);
        }
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@orderID", order));
        cmd.Parameters.Add(new SqlParameter("@cash", DBNull.Value));
        cmd.Parameters.Add(new SqlParameter("@credit", creditamount));
        String card = cardnumber.Text;
        cmd1.Parameters.Add(new SqlParameter("@creditcard", card));
        cmd1.Parameters.Add(new SqlParameter("@orderid", order));


        Int32 rows = 0;
        Boolean success = true;

        conn.Open();

        try
        {
            cmd1.ExecuteNonQuery();
        }
        catch(SqlException)
        {
            Response.Write("This card was not added! Please add it before using it");
            success = false;

        }
        if (success)
        {
            rows = cmd.ExecuteNonQuery();
            if (rows <1 )
            {
                Response.Write("Invalid order number");
            }
            else
            {
                Response.Write("Your payment was successful");
            }
        }

        conn.Close();



    }
}
    
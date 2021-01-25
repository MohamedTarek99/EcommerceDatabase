using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class CUSTOM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        conn.Open();

        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            //Get the value of the attribute name in the Company table
            string productname = rdr.GetString(rdr.GetOrdinal("product_name"));
            //Get the value of the attribute field in the Company table
            string description = rdr.GetString(rdr.GetOrdinal("product_description"));
            string category= rdr.GetString(rdr.GetOrdinal("category"));
           Decimal price= (Decimal) rdr.GetSqlDecimal(rdr.GetOrdinal("price"));
           Decimal final_price = (Decimal) rdr.GetSqlDecimal(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            Int32 serial =(Int32) rdr.GetInt32(rdr.GetOrdinal("serial_no"));
            String wishlistname = wishlistdesired.Text;

            //Create a new label and add it to the HTML form
            Label lbl_CompanyName = new Label();
            lbl_CompanyName.Text = "  <br /> <br />" + "name:" + productname + " description:" + description + " color:" + color + " price:" + price + " finalPrice:" + final_price + "  ";             
            form1.Controls.Add(lbl_CompanyName);


          
            Button A = new Button();
            A.Text = "add to cart";
            A.Visible = true;

            A.Click += delegate (object sender1, EventArgs e1) { addtocart(sender1, e1, serial); };
            
            form1.Controls.Add(A);

            Label space = new Label();
            space.Text = "  ";
            Label space1 = new Label();
            space1.Text = "  ";
            form1.Controls.Add(space);
            Button addtowish = new Button();
            addtowish.Text = "add to wishlist";
            addtowish.Click += delegate (object sender1, EventArgs e1) { addtowishlist(sender1, e1, serial,wishlistname); };
            form1.Controls.Add(addtowish);
            form1.Controls.Add(space1);
            Button removefromwatchlist = new Button();
            removefromwatchlist.Text="Remove from watchlist";
            removefromwatchlist.Click += delegate (object sender1, EventArgs e1) { removefromwishlist(sender1, e1, serial, wishlistname); };
            form1.Controls.Add(removefromwatchlist);
        }
        //this is how you retrive data from session variable.
        string field1 = (string)(Session["field1"]);
        Response.Write(field1);
    }





    protected void addtocart(object sender, EventArgs e, Int32 serial)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addToCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        Boolean success = true;

        string user = (string)(Session["username"]);
    
      //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));




        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {

            Response.Write("Product is already in cart");
            success = false;

        }
        conn.Close();
        if (success == true)
        {
            Response.Write("Product added to cart");
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
        cmd.Parameters.Add(new SqlParameter("@mobile_number",mobile));

        try { 
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


    protected void addtowishlist(object sender, EventArgs e,Int32 serial,string name)
    {


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        String wish = wishlistdesired.Text;
        Boolean success = true;

        string user = (string)(Session["username"]);


        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", name));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));


        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {

            Response.Write("You either dont have a wishlist with this name or you already added this product to this wishlist");
            success = false;
        }
        if (success == true)
        {
            Response.Write("Product added");
        }



    }


    protected void removefromwishlist(object sender, EventArgs e, Int32 serial, string name)
    {


        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removeFromWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        String wish = wishlistdesired.Text;

        string user = (string)(Session["username"]);


        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", name));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        Int32 rows = 0;

       
            conn.Open();
            rows=cmd.ExecuteNonQuery();
       

          
        if (rows < 1)
        {
            Response.Write("Either you dont have a wishlist with this name or this product is not in this wishlist");
        }
        else { 
        
            Response.Write("Product removed");
        }



    }


    protected void createwishlist(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("createWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        String mobile = wish.Text;
        Boolean success = true;

        string user = (string)(Session["username"]);

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@name", mobile));

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {

            Response.Write("You already have a wishlist with this name");
            success = false;
        }

        conn.Close();
        if (success == true)
        {
            Response.Write("Wishlist created");
        }





    }


    protected void addcreditcard(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addcreditcard", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        Boolean success = true;

        string user = (string)(Session["username"]);
        string number = creditnumber.Text;
        string cardcvv = cvv.Text;
        string carddate = date.Text;
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@creditcardnumber", number));
        cmd.Parameters.Add(new SqlParameter("@expirydate", carddate));
        cmd.Parameters.Add(new SqlParameter("@cvv", cardcvv));
        cmd.Parameters.Add(new SqlParameter("@customername", user));
       


        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {

            Response.Write("This credit card is already added");
            success = false;
        }

        conn.Close();
        if (success == true)
        {
            Response.Write("Credit card added");
        }






    }

}

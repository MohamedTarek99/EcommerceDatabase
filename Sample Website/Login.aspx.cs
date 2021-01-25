using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    
    // The page_load method is called before loading the corresponding HTML file to the browser
    protected void Page_Load(object sender, EventArgs e)
    {
        RegistervendorHyperLink.NavigateUrl = "vendorRegister.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        RegistercustomerHyperLink.NavigateUrl = "customerRegister.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);

    }

    protected void login(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("userLogin", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string username = txt_username.Text;
        string password = txt_password.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));


        //Save the output from the procedure
        SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
        success.Direction = ParameterDirection.Output;
        SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
        type.Direction = ParameterDirection.Output;

        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
       

        if (success.Value.ToString().Equals("1"))
        {
            Session["username"] = username;

            if (type.Value.ToString().Equals("0")) {
                Response.Redirect("customerpage.aspx", true);
            }
            if (type.Value.ToString().Equals("1"))
            {
                Response.Redirect("vendor.aspx", true);
            }
            if (type.Value.ToString().Equals("2"))
            {
                Response.Redirect("admin.aspx", true);
            }


      
        }
        else
        {

            Response.Write("Login failed!");
        }
    }
}


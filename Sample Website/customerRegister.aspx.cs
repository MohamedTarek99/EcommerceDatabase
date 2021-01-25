using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class customerRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void register(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("customerRegister", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the 
        string username = UserName.Text;
        string email = Email.Text;
        string password = Password.Text;
        string firstname = fname.Text;
        string lastname = lname.Text;
       
        Boolean success = true;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        cmd.Parameters.Add(new SqlParameter("@email", email));
        cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
        cmd.Parameters.Add(new SqlParameter("@last_name", lastname));


        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("The username you choosed is already taken");
            success = false;
        }

        conn.Close();
        if (success == true)
        {
            Response.Write("Registeration successful");
        }






    }
}
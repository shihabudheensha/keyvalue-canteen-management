using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;
using PasswordHash = HashPassword.PasswordHash;
public partial class KYC_Signup : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    
    [System.Web.Services.WebMethod]
    public static bool RegisterUser(string first_name, string last_name, string email, string password)
    {
       
        OleDbDataReader dr;

        bool is_email_exist = true;

        int count = 0;

        string ConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        using (OleDbConnection conn = new OleDbConnection(ConnString))
        {
            string SqlString = "select count(*) as email_count from canteen_users where email=?";
            using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
            {
                cmd.Parameters.Add(new OleDbParameter("?", email));
                conn.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    count = Convert.ToInt32(dr["email_count"]);
                }
                dr.Close();
            }
            if (count == 0)
            {
                is_email_exist = false;
                SqlString = "insert into canteen_users (first_name,last_name,email,password) values(?,?,?,?)";
                using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
                {
                    cmd.Parameters.Add(new OleDbParameter("?",first_name));
                    cmd.Parameters.Add(new OleDbParameter("?", last_name));
                    cmd.Parameters.Add(new OleDbParameter("?", email));
                    

                    string saltHashReturned = PasswordHash.CreateHash(password);
                    int commaIndex = saltHashReturned.IndexOf(":");
                    string extractedString = saltHashReturned.Substring(0, commaIndex);
                    commaIndex = saltHashReturned.IndexOf(":");
                    extractedString = saltHashReturned.Substring(commaIndex+1);
                    commaIndex = extractedString.IndexOf(":");
                    string salt = extractedString.Substring(0,commaIndex);

                    commaIndex = extractedString.IndexOf(":");
                    extractedString = extractedString.Substring(commaIndex+1);
                    string hash = extractedString;

                    // from first : column to second : is the salt
                    // from second : to end is hash

                    cmd.Parameters.Add(new OleDbParameter("?", saltHashReturned));

                    cmd.ExecuteNonQuery();
                }
            }
        }

        return is_email_exist;
    }
}
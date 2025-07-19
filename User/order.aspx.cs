using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;

public partial class CanteenManagement_User_order : System.Web.UI.Page
{
    public int userId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Uid"] == null)
        {
            string login_url = "Login.aspx";
            Response.Write("<script>window.top.location.replace('" + login_url + "');</script>");
        }
        userId = Convert.ToInt32(Session["Uid"]);
        
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<MealItem> GetAllMeals()
    {
        List<MealItem> meals = new List<MealItem>();

        string ConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(ConnString))
        {
            string SqlString = "SELECT * FROM Meals ORDER BY MealId DESC";
            using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
            {
                conn.Open();
                using (OleDbDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        MealItem meal = new MealItem();

                        meal.MealId = Convert.ToInt32(dr["MealId"]);
                        meal.MealName = dr["MealName"].ToString();
                        meal.Price = Convert.ToDecimal(dr["Price"]);
                        meal.Availability = 1;
                        meal.ImageUrl = dr["ImageUrl"].ToString();

                        meals.Add(meal);
                    }
                }
            }
        }

        return meals;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string insertOrder(int student_id, int meal_id, int quantity, decimal total_price)
    {
        bool is_inserted = false;

        try
        {
            string ConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (OleDbConnection conn = new OleDbConnection(ConnString))
            {
                string SqlString = "INSERT INTO orders (student_id, meal_id, quantity, total_price, order_time) VALUES (?, ?, ?, ?, ?)";
                using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
                {
                    cmd.Parameters.Add(new OleDbParameter("?", student_id));
                    cmd.Parameters.Add(new OleDbParameter("?", meal_id));
                    cmd.Parameters.Add(new OleDbParameter("?", quantity));
                    cmd.Parameters.Add(new OleDbParameter("?", total_price));
                    cmd.Parameters.Add(new OleDbParameter("?", DateTime.Now)); // or leave NULL if DB default

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    is_inserted = true;
                }
            }
        }
        catch (Exception ex)
        {

            return ex.ToString();
        }

        return "";
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string InsertFullOrder(int student_id, List<CartItem> cartItems)
    {
        string output = "";
        /*foreach (CartItem item in cartItems)
        {
            output += "Meal ID:"+item.meal_id;
        }*/

        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int orderId = 0;

        try
        {
            using (OleDbConnection conn = new OleDbConnection(connString))
            {
                conn.Open();

                // 1. Insert into orders table (calculate total order price and quantity)
                decimal totalPrice = 0;
                int totalQty = 0;
                int mealId = 0;
                string orderInsertSql = "INSERT INTO orders (student_id, quantity, total_price, order_time,meal_id) VALUES (?, ?, ?, ?,?)";
                using (OleDbCommand cmd = new OleDbCommand(orderInsertSql, conn))
                {
                    cmd.Parameters.AddWithValue("?", student_id);
                    cmd.Parameters.AddWithValue("?", totalQty);
                    cmd.Parameters.AddWithValue("?", totalPrice);
                    cmd.Parameters.AddWithValue("?", DateTime.Now);
                    cmd.Parameters.AddWithValue("?", mealId);
                    cmd.ExecuteNonQuery();

                    // Get the inserted order ID
                    cmd.CommandText = "SELECT @@IDENTITY";
                    orderId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // 2. Insert each item into order_items table
                foreach (var item in cartItems)
                {
                    string itemInsertSql = "INSERT INTO order_items (order_id, meal_id, quantity, total_price) VALUES (?, ?, ?, ?)";
                    using (OleDbCommand itemCmd = new OleDbCommand(itemInsertSql, conn))
                    {
                        itemCmd.Parameters.AddWithValue("?", orderId);
                        itemCmd.Parameters.AddWithValue("?", item.meal_id);
                        itemCmd.Parameters.AddWithValue("?", item.quantity);
                        itemCmd.Parameters.AddWithValue("?", item.total_price);
                        itemCmd.ExecuteNonQuery();
                    }
                }

                return "Order placed successfully with Order ID: " + orderId;
            }
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
       
    }
    public class CartItem
    {
        public int meal_id { get; set; }
        public int quantity { get; set; }
        public decimal total_price { get; set; }
    }
    public class MealItem
    {
        public int MealId { get; set; }
        public string MealName { get; set; }
        public decimal Price { get; set; }
        public int Availability { get; set; }
        public string ImageUrl { get; set; }
    }
    

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<usrKyc> GetKyc(string status)
    {
        List<usrKyc> kyc = new List<usrKyc>();

        OleDbDataReader dr;
        string ConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(ConnString))
        {
            string SqlString = "select * from kyc_users where KYC_status=? and user_type=0 order by user_id desc";
            using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
            {
                string dob = "";

                cmd.Parameters.Add(new OleDbParameter("?", status));
                conn.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    usrKyc usrkyc = new usrKyc();

                    usrkyc.full_name = dr.GetString(dr.GetOrdinal("full_name"));
                    usrkyc.usrID = Convert.ToInt32(dr["user_id"]);
                    usrkyc.address = dr.GetString(dr.GetOrdinal("address"));
                    usrkyc.Aadhar = dr.GetString(dr.GetOrdinal("Aadhar"));
                    usrkyc.pan = dr.GetString(dr.GetOrdinal("pan"));
                    usrkyc.voter_id = dr.GetString(dr.GetOrdinal("voter_id"));
                    usrkyc.KYC_status = dr.GetString(dr.GetOrdinal("KYC_status"));

                    if (dr["dob"] != System.DBNull.Value)
                    {
                        dob = Convert.ToDateTime(dr["dob"].ToString()).ToString("dd MMM yyyy");
                    }
                    usrkyc.dob = dob;

                    kyc.Add(usrkyc);
                }
                dr.Close();
            }
        }

        return kyc;
    }

    public class usrKyc
    {
        public int usrID { get; set; }
        public string full_name { get; set; }
        public string address { get; set; }
        public string Aadhar { get; set; }
        public string pan { get; set; }
        public string voter_id { get; set; }
        public string KYC_status { get; set; }
        public string dob { get; set; } // formatted as "dd MMM yyyy"
    }

}
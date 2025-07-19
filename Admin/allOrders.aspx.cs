using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;

public partial class CanteenManagement_Admin_allOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<OrderItem> GetAllOrders()
    {
        List<OrderItem> orders = new List<OrderItem>();

        string ConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        using (OleDbConnection conn = new OleDbConnection(ConnString))
        {
            string SqlString = @"
            SELECT 
    o.order_id,
    u.first_name,
    o.order_time,
    SUM(oi.quantity) AS TotalItems,
    SUM(oi.total_price) AS TotalAmount
FROM orders o
LEFT JOIN canteen_users u ON o.student_id = u.user_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 
    o.order_id, u.first_name, o.order_time
ORDER BY o.order_id DESC";

            using (OleDbCommand cmd = new OleDbCommand(SqlString, conn))
            {
                conn.Open();
                using (OleDbDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        OrderItem order = new OrderItem();

                        order.OrderId = Convert.ToInt32(dr["order_id"]);
                        order.StudentName = dr["first_name"].ToString();
                        order.MealName = "";
                        order.Quantity = 0;
                        order.TotalPrice = 0;
                        order.OrderTime = Convert.ToDateTime(dr["order_time"]).ToString("yyyy-MM-dd");
                        order.TotalItems = Convert.ToInt32(dr["TotalItems"]);
                        order.TotalAmount = Convert.ToDecimal(dr["TotalAmount"]);
                        orders.Add(order);
                    }
                }
            }
        }

        return orders;
    }

    public class OrderItem
    {
        public int OrderId { get; set; }
        public string StudentName { get; set; }
        public string MealName { get; set; }
        public int Quantity { get; set; }
        public decimal TotalPrice { get; set; }
        public string OrderTime { get; set; } // Keep as string for easy JS formatting
        public int TotalItems { get; set; }
        public decimal TotalAmount { get; set; }
    }
}
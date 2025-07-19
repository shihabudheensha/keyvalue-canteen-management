<%@ Page Language="C#" AutoEventWireup="true" CodeFile="allOrders.aspx.cs" Inherits="CanteenManagement_Admin_allOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Orders</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- DataTables CSS (Optional) -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <div class="container mt-5">
    <h2 class="mb-4 text-center">📦 Meal Orders Overview</h2>
    
    <div class="table-responsive">
      <table id="ordersTable" class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>Order ID</th>
            <th>Student Name</th>
            <th>Total Price (₹)</th>
             <th>Total Items</th>
            <th>Order Date</th>
          </tr>
        </thead>
        <tbody id="data-tbl">
          <!-- Example static row -->
          <!--<tr>
            <td>#1005</td>
            <td>Kiran</td>
            <td>Biriyani</td>
            <td>1</td>
            <td>300.00</td>
            <td>2025-07-18 10:25 AM</td>
          </tr>-->
          <!-- Repeat rows dynamically here via backend or JS -->
        </tbody>
      </table>
    </div>
  </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

     <!--- Jquery Popup box ---------->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css" />

    <!-- Theme js -->
    
        <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" rel="stylesheet" />
   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
        <script>
            var data = {};
            $.ajax({
                url: 'allOrders.aspx/GetAllOrders',
                method: 'post',
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "json",
                success: function (data) {
                    console.log(data.d)
                    renderTbl(data.d)
                },
                error: function (err) {
                    console.log(err)
                }
            });
            function renderTbl(data) {
                var str = "";
                for (i = 0; i < data.length; i++) {
                    str += '<tr><td>#' + (1000 + data[i].OrderId) + '</td>'
                    str += '<td>' + data[i].StudentName + '</td>'
                    str += '<td>' + data[i].TotalAmount + '</td>'
                    str += '<td>' + data[i].TotalItems + '</td>'
                    str += '<td>' + data[i].OrderTime + '</td><tr>'
                    

                }
                $("#data-tbl").html(str);
            }
        </script>
    </div>
    </form>
</body>
</html>

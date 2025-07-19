<%@ Page Language="C#" AutoEventWireup="true" CodeFile="order.aspx.cs" Inherits="CanteenManagement_User_order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Menu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>

    <style>
    body {
      background-color: #f8f9fa;
    }
    .meal-card {
      border-radius: 1rem;
      transition: transform 0.2s ease;
    }
    .meal-card:hover {
      transform: scale(1.02);
    }
    .order-btn {
      border-radius: 1.5rem;
    }
    .topbar {
      background-color: #fff;
      border-bottom: 1px solid #ddd;
    }
    .dropdown-toggle::after {
      display: none;
    }
    .meal-img {
      border-top-left-radius: 1rem;
      border-top-right-radius: 1rem;
      height: 180px;
      object-fit: cover;
      width: 100%;
    }
     .rigth-section {
                position: absolute;
    top: 77px;
    max-height: calc(100% - 30px);
    background-color: #fff;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    z-index: 10;
    min-width: 350px;
    width:auto;
    right: 15px;
    min-height: 500px;
    border-radius: 10px;
    border: solid 2px #747474;
    
         }
         .rigth-section .info-hdr {
            height: 40px;
            background-color: #747474;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            padding-left:10px;
            padding-right:10px;
         }
         .info-hdr .ttl{
            float: left;
    color: #fff;
    margin-top: 10px;
         }
         .info-hdr .close-btn {
          float: right;
    cursor: pointer;
    color: #fff;
    font-size: 17px;
    margin-top: 8px;
         }
         .right-section-content {
              padding: 10px;
    max-height: calc(100% - 40px);
    overflow: auto;
    position: relative;
    overflow-x: hidden;
         }
          .cart-img {
      width: 80px;
      height: 80px;
      object-fit: cover;
      border-radius: 8px;
    }
    .cart-item {
      border-bottom: 1px solid #ddd;
      padding: 15px 0;
    }
  </style>

</head>
<body>
    <form id="form1" runat="server">
    <div>
          <!-- Topbar -->
  <nav class="navbar navbar-expand-lg navbar-light topbar px-3 py-2">
    <div class="container-fluid">
      <span class="navbar-brand fw-bold">🍽️ Canteen Menu</span>
      <div class="dropdown ms-auto">
        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-person-circle fs-4"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
          <li><a class="dropdown-item" href="#">Edit Profile</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item text-danger" href="#">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Meal Cards -->
  <div class="container py-4">

      
        <div class="rigth-section">
            <div class="info-hdr">
                <div class="ttl">Cart info</div>
                <div class="close-btn"><i class="fa fa-times" aria-hidden="true"></i></div>
            </div>
            <div class="right-section-content">
                   <div id="cartItems">
                      

                      <!--<div class="row cart-item align-items-center">
                        <div class="col-3 text-center">
                          <img src="https://aws.rimpexpmis.com/shahanad/CanteenManagement/images/payampori.jpg" alt="Payampori" class="cart-img">
                        </div>
                        <div class="col-5">
                          <h6 class="mb-1">Payampori</h6>
                          <p class="mb-0 text-muted">Price: ₹15</p>
                        </div>
                        <div class="col-4">
                          <input type="number" class="form-control quantity" data-price="15" value="1" min="1">
                        </div>
                      </div>--->

                     
                      <!-- Add more items here -->
                    </div>

                    <!-- Order Summary -->
                    <div class="text-end mt-4">
                      <h5>Total: ₹<span id="totalPrice">0</span></h5>
                      <button id="place-order" class="btn btn-success mt-2" type="button">Place Order</button>
                    </div>
            </div>
        </div>

    <div class="row g-4" id="meals">

     
      <!--<div class="col-md-4 col-sm-6">
        <div class="card meal-card shadow-sm">
          <img src="../images/meal.jpg" alt="Biriyani" class="meal-img"/>
          <div class="card-body">
            <h5 class="card-title">Meal</h5>
            <p class="card-text mb-1"><strong>Price:</strong> ₹40</p>
            <p class="card-text text-success"><strong>Available</strong></p>
            <button class="btn btn-primary w-100 order-btn">Order</button>
          </div>
        </div>
      </div>

     
      <div class="col-md-4 col-sm-6">
        <div class="card meal-card shadow-sm">
          <img src="../images/chai.jpg" alt="Meals" class="meal-img"/>
          <div class="card-body">
            <h5 class="card-title">Chai</h5>
            <p class="card-text mb-1"><strong>Price:</strong> ₹10</p>
           <p class="card-text text-success"><strong>Available</strong></p>
            <button class="btn btn-primary w-100 order-btn">Order</button>
          </div>
        </div>
      </div>

      
      <div class="col-md-4 col-sm-6">
        <div class="card meal-card shadow-sm">
          <img src="../images/payampori.jpg" alt="Parotta" class="meal-img"/>
          <div class="card-body">
            <h5 class="card-title">Payampori</h5>
            <p class="card-text mb-1"><strong>Price:</strong> ₹15</p>
            <p class="card-text text-success"><strong>Available</strong></p>
            <button class="btn btn-primary w-100 order-btn">Order</button>
          </div>
        </div>
      </div>-->

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
            var userId = <%=userId%>;

            var data = {
                status : "pending",
            };

            var carData = [];

            $.ajax({
                url: 'order.aspx/GetAllMeals',
                method: 'post',
                contentType: "application/json",
                data:JSON.stringify(data),
                dataType: "json",
                success: function (data) {
                    console.log(data.d)
                    renderMenu(data.d)
                },
                error: function (err) {
                    console.log(err)
                }
            });

            function renderMenu(data) {
                str = '';
                for (i = 0; i < data.length; i++) {
                    str += '<div class="col-md-3 col-sm-6"> <div class="card meal-card shadow-sm">'
                    str += ' <img src="' + data[i].ImageUrl+ '"  class="meal-img"/>'
                    str += ' <div class="card-body"><h5 class="card-title">' + data[i].MealName + '</h5>'
                    str += '<p class="card-text mb-1"><strong>Price:</strong> ₹'+data[i].Price+'</p>'
                    str += ' <p class="card-text text-success"><strong>Available</strong></p>'
                    str += '<button meal-id="'+data[i].MealId+'" price='+data[i].Price+' type="button" class="btn btn-primary w-100 order-btn">Order</button>'
                    str+='<button style="margin-top:10px;" img='+data[i].ImageUrl+' name="'+data[i].MealName+'" meal-id="'+data[i].MealId+'" price='+data[i].Price+' type="button" class="btn btn btn-warning w-100 cart-btn">Add to Cart</button>'
                    str += ' </div></div> </div>'
                }
                $("#meals").html(str);

            }

            $('#meals').on('click', '.order-btn', function() {
                
                var data = {
                    student_id:userId,
                    meal_id:$(this).attr("meal-id"),
                    quantity:1,
                    total_price:$(this).attr("price"),
                 }
                console.log(data);

                $.ajax({
                    url: 'order.aspx/insertOrder',
                    method: 'post',
                    contentType: "application/json",
                    data:JSON.stringify(data),
                    dataType: "json",
                    success: function (data) {
                        console.log(data.d)
                        swal({
                            title: "Thank You",
                            text: "Your Order Placed",
                            icon: "success",
                        }).then((value) => {
                            
                         });
                    },
                    error: function (err) {
                        console.log(err)
                    }
                });
            });


            $('#meals').on('click', '.cart-btn', function() {

                var data = {
                    meal_id:$(this).attr("meal-id"),
                    quantity:1,
                    total_price:$(this).attr("price"),
                    img:$(this).attr("img"),
                    meal:$(this).attr("name")
                }
                carData.push(data)
                updateCart()
                console.log(carData);
            });

            function updateCart(){
                var str="";
                var total = 0;
                for(i=0;i<carData.length;i++){
                    str+='<div class="row cart-item align-items-center">'
                    str+=' <div class="col-3 text-center">'
                    str+='<img src="'+carData[i].img+'" alt="Payampori" class="cart-img">  </div>'
                    str+=' <div class="col-5"><h6 class="mb-1">'+carData[i].meal+'</h6> <p class="mb-0 text-muted">Price: ₹'+carData[i].total_price+'</p> </div></div>'
                    total+=parseInt(carData[i].total_price);
                }
                $("#cartItems").html(str);
                $("#totalPrice").html(total);
            }


            $("#place-order").click(function() {
               
                /*$.ajax({
                    type: "POST",
                    url: "order.aspx/InsertFullOrder",
                    data: JSON.stringify({ 
                        student_id: 123, 
                        cartJson: JSON.stringify(carData) 
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        alert(res.d);
                    },
                    error: function (err) {
                        console.error("Error placing order", err);
                    }
                });*/
                var cart =[];
                for(i=0;i<carData.length;i++){
                    cart.push({
                        meal_id:carData[i].meal_id,
                        quantity:carData[i].quantity,
                        total_price:carData[i].total_price,
                    })
                }
                var data = {
                    student_id:userId,
                    cartItems:cart,
                };

                $.ajax({
                    url: 'order.aspx/InsertFullOrder',
                    method: 'post',
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    dataType: "json",
                    success: function (data) {
                        console.log(data.d)
                        
                        swal({
                            title: "Thank You",
                            text: "Your Order Placed",
                            icon: "success",
                        }).then((value) => {
                            
                        });

                    },
                    error: function (err) {
                        console.log(err)
                    }
                });

            });
        </script>
    </div>
    </form>
</body>
</html>

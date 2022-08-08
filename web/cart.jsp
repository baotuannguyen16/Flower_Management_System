
<%@page import="java.util.Date"%>
<%@page import="java.util.Set"%>
<%@page import="thanhlh.dao.PlantDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="thanhlh.dto.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <!-- Title -->
        <title>View Cart</title>

        <!-- Favicon -->
        <link rel="icon" href="img/core-img/favicon.ico">

        <!-- Core Stylesheet -->
        <link rel="stylesheet" href="style.css">

    </head>

    <body>

        <jsp:include page="header.jsp" />

        <!-- ##### Breadcrumb Area Start ##### -->

        <%  int sumPrice = 0;
            String name = (String) session.getAttribute("name");
            if (name != null) {
        %>
        <h3>Welcome <%= session.getAttribute("name")%> come back</h3>
        <h3><a style='color:black' href="mainController?action=logout">Logout</a> </h3>
        <h3><a style='color:black' href="mainController?action=filterOrder">Personal page</a></h3>
        <%
            }%>


        <div class="breadcrumb-area">
            <!-- Top Breadcrumb Area -->
            <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(img/bg-img/24.jpg);">
                <h2>Cart</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cart</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- ##### Breadcrumb Area End ##### -->
        <%
            ArrayList<Plant> list = PlantDAO.getAllPlants();
            HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");


        %>
        <font style="color: green"><%= (request.getAttribute("WARNING") == null) ? "" : (String) request.getAttribute("WARNING")%> </font>
        <!-- ##### Cart Area Start ##### -->
        <div class="cart-area section-padding-0-100 clearfix">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="cart-table clearfix">
                            <%if (cart != null && !cart.isEmpty()) {
                                    Set<String> pids = cart.keySet();
                                    System.out.println(cart);%>
                            <table class="table table-responsive">
                                <thead>

                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>TOTAL</th>
                                        <th>Action</th>
                                        <th></th>
                                    </tr>                                    
                                </thead>
                                <%for (String pid : pids) {
                                        int quantity = cart.get(pid);
                                        for (Plant p : list) {
                                            if (String.valueOf(p.getId()).equals(pid)) {%>
                                <tbody>
                                    <tr><form action="mainController" method="post">
                                    <td class="cart_product_img">
                                        <a href="#"><img src='<%= p.getImgpath()%>' alt="Product"></a>
                                        <h5><%=p.getName()%></h5>
                                        <input type="hidden" value="<%= pid%>" name="pid"> 
                                    </td>
                                    <td><input type="number" value="<%= quantity%>" name="quantity"></td>
                                    <td class="price"><span><%=p.getPrice()%></span></td>
                                    <td class="total_price"><span><%=p.getPrice() * quantity%></span></td>
                                            <%  sumPrice += p.getPrice() * quantity;
                                                    }
                                                }%>
                                    <td><input type="submit" value="update" name="action">
                                        <input type="submit" value="delete" name="action"></td>
                                </form>
                                <%}%>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Coupon Discount -->
                    <div class="col-12 col-lg-6">
                        <div class="coupon-discount mt-70">
                            <h5>COUPON DISCOUNT</h5>
                            <p>Coupons can be applied in the cart prior to checkout. Add an eligible item from the booth of the seller that created the coupon code to your cart. Click the green "Apply code" button to add the coupon to your order. The order total will update to indicate the savings specific to the coupon code entered.</p>
                            <form action="#" method="post">
                                <input type="text" name="coupon-code" placeholder="Enter your coupon code">
                                <button type="submit">APPLY COUPON</button>
                            </form>
                        </div>
                    </div>

                    <!-- Cart Totals -->
                    <div class="col-12 col-lg-6">
                        <div class="cart-totals-area mt-70">
                            <h5 class="title--">TOTAL CARD INFORMATION</h5>
                            <div class="total d-flex justify-content-between">
                                <h5>Total</h5>
                                <h5><%= sumPrice%></h5>
                            </div>
                            <div class="total d-flex justify-content-between">
                                <h5>Order Date</h5>
                                <h5><%= (new Date()).toString()%></h5>
                            </div>

                            <form action="mainController" method="post">
                                <div class="checkout-btn">
                                    <input type="hidden" value="saveOrder" name="action">
                                    <!--                                    <a href="#" class="btn alazea-btn w-100">PROCEED TO CHECKOUT</a>-->
                                    <button type="submit" value="saveOrder" name="action" class="btn alazea-btn w-100">PROCEED TO CHECKOUT</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                <%} else {%>
                <div class="container">
                    <h1 style="color:red; text-align: center; margin-bottom: 32px; margin-top: -60px">Your cart is empty</h1>
                </div>
                <%}
                %>
            </div>
        </div>

        <!-- ##### Cart Area End ##### -->

        <!-- ##### Footer Area Start ##### -->
        <footer class="footer-area bg-img" style="background-image: url(img/bg-img/3.jpg);">
            <!-- Main Footer Area -->
            <div class="main-footer-area">
                <div class="container">
                    <div class="row">

                        <!-- Single Footer Widget -->
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="single-footer-widget">
                                <div class="footer-logo mb-30">
                                    <a href="#"><img src="img/core-img/logo.png" alt=""></a>
                                </div>
                                <p>Lorem ipsum dolor sit samet, consectetur adipiscing elit. India situs atione mantor</p>
                                <div class="social-info">
                                    <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                    <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                                    <a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
                                    <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                                    <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                                </div>
                            </div>
                        </div>

                        <!-- Single Footer Widget -->
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="single-footer-widget">
                                <div class="widget-title">
                                    <h5>QUICK LINK</h5>
                                </div>
                                <nav class="widget-nav">
                                    <ul>
                                        <li><a href="#">Purchase</a></li>
                                        <li><a href="#">FAQs</a></li>
                                        <li><a href="#">Payment</a></li>
                                        <li><a href="#">News</a></li>
                                        <li><a href="#">Return</a></li>
                                        <li><a href="#">Advertise</a></li>
                                        <li><a href="#">Shipping</a></li>
                                        <li><a href="#">Career</a></li>
                                        <li><a href="#">Orders</a></li>
                                        <li><a href="#">Policities</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                        <!-- Single Footer Widget -->
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="single-footer-widget">
                                <div class="widget-title">
                                    <h5>BEST SELLER</h5>
                                </div>

                                <!-- Single Best Seller Products -->
                                <div class="single-best-seller-product d-flex align-items-center">
                                    <div class="product-thumbnail">
                                        <a href="shop-details.html"><img src="img/bg-img/4.jpg" alt=""></a>
                                    </div>
                                    <div class="product-info">
                                        <a href="shop-details.html">Cactus Flower</a>
                                        <p>$10.99</p>
                                    </div>
                                </div>

                                <!-- Single Best Seller Products -->
                                <div class="single-best-seller-product d-flex align-items-center">
                                    <div class="product-thumbnail">
                                        <a href="shop-details.html"><img src="img/bg-img/5.jpg" alt=""></a>
                                    </div>
                                    <div class="product-info">
                                        <a href="shop-details.html">Tulip Flower</a>
                                        <p>$11.99</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Single Footer Widget -->
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="single-footer-widget">
                                <div class="widget-title">
                                    <h5>CONTACT</h5>
                                </div>

                                <div class="contact-information">
                                    <p><span>Address:</span> 505 Silk Rd, New York</p>
                                    <p><span>Phone:</span> +1 234 122 122</p>
                                    <p><span>Email:</span> info.deercreative@gmail.com</p>
                                    <p><span>Open hours:</span> Mon - Sun: 8 AM to 9 PM</p>
                                    <p><span>Happy hours:</span> Sat: 2 PM to 4 PM</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer Bottom Area -->
            <div class="footer-bottom-area">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="border-line"></div>
                        </div>
                        <!-- Copywrite Text -->
                        <div class="col-12 col-md-6">
                            <div class="copywrite-text">
                                <p>&copy; <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                </p>
                            </div>
                        </div>
                        <!-- Footer Nav -->
                        <div class="col-12 col-md-6">
                            <div class="footer-nav">
                                <nav>
                                    <ul>
                                        <li><a href="#">Home</a></li>
                                        <li><a href="#">About</a></li>
                                        <li><a href="#">Service</a></li>
                                        <li><a href="#">Portfolio</a></li>
                                        <li><a href="#">Blog</a></li>
                                        <li><a href="#">Contact</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- ##### Footer Area End ##### -->

        <!-- ##### All Javascript Files ##### -->
        <!-- jQuery-2.2.4 js -->
        <script src="js/jquery/jquery-2.2.4.min.js"></script>
        <!-- Popper js -->
        <script src="js/bootstrap/popper.min.js"></script>
        <!-- Bootstrap js -->
        <script src="js/bootstrap/bootstrap.min.js"></script>
        <!-- All Plugins js -->
        <script src="js/plugins/plugins.js"></script>
        <!-- Active js -->
        <script src="js/active.js"></script>
    </body>

</html>
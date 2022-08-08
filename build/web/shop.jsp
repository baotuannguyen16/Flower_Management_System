<%-- 
    Document   : shop
    Created on : Feb 21, 2022, 9:32:59 PM
    Author     : lehon
--%>

<%@page import="thanhlh.dao.PlantDAO"%>
<%@page import="thanhlh.dto.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <!-- Title -->
        <title>Plant-Shop</title>

        <!-- Favicon -->
        <link rel="icon" href="img/core-img/favicon.ico">

        <!-- Core Stylesheet -->
        <link rel="stylesheet" href="style.css">

    </head>

    <body>
        <jsp:include page="header.jsp" />
        <!-- ##### Breadcrumb Area Start ##### -->
        <div class="breadcrumb-area">
            <!-- Top Breadcrumb Area -->
            <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(img/bg-img/24.jpg);">
                <h2>Shop</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Shop</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- ##### Breadcrumb Area End ##### -->

        <!-- ##### Shop Area Start ##### -->
        <section class="shop-page section-padding-0-100">
            <div class="container">


                <div class="row">
                    <!-- Sidebar Area -->
                    <div class="col-12 col-md-4 col-lg-3">
                        <div class="shop-sidebar-area">



                            <!-- Shop Widget -->
                            <div class="shop-widget catagory mb-50">
                                <h4 class="widget-title">Categories</h4>

                                <div class="alazea-portfolio-filter">
                                    <div class="portfolio-filter">
                                        <button class="btn active" data-filter="*">All</button>
                                        <button class="btn" data-filter=".orchid">Orchid</button>
                                        <button class="btn" data-filter=".roses">Roses</button>
                                        <button class="btn" data-filter=".others">Others</button>
                                    </div>
                                </div>

                            </div>


                            <!-- Shop Widget -->
                            <div class="shop-widget best-seller mb-50">
                                <h4 class="widget-title">Best Seller</h4>
                                <div class="widget-desc">

                                    <!-- Single Best Seller Products -->
                                    <div class="single-best-seller-product d-flex align-items-center">
                                        <div class="product-thumbnail">
                                            <a href="shop-details.html"><img src="img/bg-img/4.jpg" alt=""></a>
                                        </div>
                                        <div class="product-info">
                                            <a href="shop-details.html">Cactus Flower</a>
                                            <p>$10.99</p>
                                            <div class="ratings">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
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
                                            <div class="ratings">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Single Best Seller Products -->
                                    <div class="single-best-seller-product d-flex align-items-center">
                                        <div class="product-thumbnail">
                                            <a href="shop-details.html"><img src="img/bg-img/34.jpg" alt=""></a>
                                        </div>
                                        <div class="product-info">
                                            <a href="shop-details.html">Recuerdos Plant</a>
                                            <p>$9.99</p>
                                            <div class="ratings">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- All Products Area -->
                    <div class="col-12 col-md-8 col-lg-9">
                        <div class="shop-products-area">
                            <div class="row alazea-portfolio">

                                <%
                                    String keyword = request.getParameter("txtsearch");
                                    String searchby = request.getParameter("searchby");
                                    ArrayList<Plant> list;
                                    String[] tmp = {"out of stock", "availble"};
                                    if (keyword == null && searchby == null)// when the page is loaded, all product will be displayed
                                    {
                                        list = PlantDAO.getPlants("", "");
                                    } else {
                                        list = PlantDAO.getPlants(keyword, searchby); //only get products by name/category
                                    }
                                    if (list != null && !list.isEmpty()) {
                                        for (Plant p : list) {
                                            if (p.getCatename().equalsIgnoreCase("orchid")) {%>

                                <!-- Single Product Area -->
                                <div class="col-12 col-sm-6 col-lg-4 all orchid single_portfolio_item">
                                    <div class="single-product-area mb-50">
                                        <!-- Product Image -->
                                        <div class="product-img">
                                            <a href="#"><img src='<%= p.getImgpath()%>'alt=""></a>
                                            <!-- Product Tag -->
                                            <div class="product-tag">
                                                <a href="#">Hot</a>
                                            </div>
                                            <div class="product-meta d-flex">
                                                <a href="#" class="wishlist-btn"><i class="icon_heart_alt"></i></a>
                                                <a href="mainController?action=addtocart&pid=<%= p.getId()%>" class="add-to-cart-btn">Add to cart</a>
                                                <a href="cart.jsp"><i class="arrow_left-right_alt"></i></a>
                                            </div>
                                        </div>
                                        <!-- Product Info -->
                                        <div class="product-info mt-15 text-center">
                                            <a href="shop-details.html">
                                                <p><%=p.getId()%></p>
                                            </a>
                                            <h5><%=p.getName()%></h5>
                                            <h6><%=p.getPrice()%>$</h6>
                                        </div>
                                    </div>
                                </div>
                                <%} else if (p.getCatename().equalsIgnoreCase("roses")) {%>

                                <div class="col-12 col-sm-6 col-lg-4 all roses single_portfolio_item">
                                    <div class="single-product-area mb-50">
                                        <!-- Product Image -->
                                        <div class="product-img">
                                            <a href="#"><img src='<%= p.getImgpath()%>'alt=""></a>
                                            <!-- Product Tag -->
                                            <div class="product-tag">
                                                <a href="#">Hot</a>
                                            </div>
                                            <div class="product-meta d-flex">
                                                <a href="#" class="wishlist-btn"><i class="icon_heart_alt"></i></a>
                                                <a href="mainController?action=addtocart&pid=<%= p.getId()%>" class="add-to-cart-btn">Add to cart</a>
                                                <a href="cart.jsp" class="compare-btn"><i class="arrow_left-right_alt"></i></a>
                                            </div>
                                        </div>
                                        <!-- Product Info -->
                                        <div class="product-info mt-15 text-center">
                                            <a href="shop-details.html">
                                                <p><%=p.getId()%></p>
                                            </a>
                                            <h5><%=p.getName()%></h5>
                                            <h6><%=p.getPrice()%>$</h6>
                                        </div>
                                    </div>
                                </div>

                                <%} else {%>
                                <div class="col-12 col-sm-6 col-lg-4 all others single_portfolio_item">
                                    <div class="single-product-area mb-50">
                                        <!-- Product Image -->
                                        <div class="product-img">
                                            <a href="#"><img src='<%= p.getImgpath()%>'alt=""></a>
                                            <!-- Product Tag -->
                                            <div class="product-tag">
                                                <a href="#">Hot</a>
                                            </div>
                                            <div class="product-meta d-flex">
                                                <a href="#" class="wishlist-btn"><i class="icon_heart_alt"></i></a>
                                                <a href="mainController?action=addtocart&pid=<%= p.getId()%>" class="add-to-cart-btn">Add to cart</a>
                                                <a href="cart.jsp" class="compare-btn"><i class="arrow_left-right_alt"></i></a>
                                            </div>
                                        </div>
                                        <!-- Product Info -->
                                        <div class="product-info mt-15 text-center">
                                            <a href="shop-details.html">
                                                <p><%=p.getId()%></p>
                                            </a>
                                            <h5><%=p.getName()%></h5>
                                            <h6><%=p.getPrice()%>$</h6>
                                        </div>
                                    </div>
                                </div>

                                <%   }
                                        }
                                    }
                                %>
                            </div>

                            <!-- Pagination -->
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-right"></i></a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ##### Shop Area End ##### -->

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

<%-- 
    Document   : header
    Created on : Jan 20, 2022, 7:48:07 AM
    Author     : Lenovo
--%>

<%@page import="thanhlh.dto.Account"%>
<%@page import="thanhlh.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <!-- Title -->
        <title>Alazea - Gardening &amp; Landscaping HTML Template</title>

        <!-- Favicon -->
        <link rel="icon" href="img/core-img/favicon.ico">

        <!-- Core Stylesheet -->
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <header>
            <!-- Preloader -->
            <div class="preloader d-flex align-items-center justify-content-center">
                <div class="preloader-circle"></div>
                <div class="preloader-img">
                    <img src="img/core-img/leaf.png" alt="">
                </div>
            </div>

            <!-- ##### Header Area Start ##### -->
            <header class="header-area">

                <!-- ***** Top Header Area ***** -->
                <div class="top-header-area">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="top-header-content d-flex align-items-center justify-content-between">
                                    <!-- Top Header Content -->
                                    <div class="top-header-meta">
                                        <a href="#" data-toggle="tooltip" data-placement="bottom" title="lehongthanhhy@gmail.com"><i class="fa fa-envelope-o" aria-hidden="true"></i> <span>Email: lehongthanhhy@gmail.com</span></a>
                                        <a href="#" data-toggle="tooltip" data-placement="bottom" title="0372227898"><i class="fa fa-phone" aria-hidden="true"></i> <span>Call VN: 0372227898</span></a>
                                    </div>

                                    <!-- Top Header Content -->
                                    <div class="top-header-meta d-flex">
                                        <!-- Language Dropdown -->
                                        <div class="language-dropdown">
                                            <div class="dropdown">
                                                <button class="btn btn-secondary dropdown-toggle mr-30" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Language</button>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                    <a class="dropdown-item" href="#">USA</a>
                                                    <a class="dropdown-item" href="#">UK</a>
                                                    <a class="dropdown-item" href="#">Bangla</a>
                                                    <a class="dropdown-item" href="#">Hindi</a>
                                                    <a class="dropdown-item" href="#">Spanish</a>
                                                    <a class="dropdown-item" href="#">Latin</a>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Login -->
                                        <div class="login">
                                            <a href="login.jsp"><i class="fa fa-user" aria-hidden="true"></i> <span>User</span></a>
                                        </div>
                                        <!-- Cart -->
                                        <div class="cart">
                                            <a href="cart.jsp"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span>Cart <span class="cart-quantity"></span></span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ***** Navbar Area ***** -->
                <div class="alazea-main-menu">
                    <div class="classy-nav-container breakpoint-off">
                        <div class="container">
                            <!-- Menu -->
                            <nav class="classy-navbar justify-content-between" id="alazeaNav">

                                <!-- Nav Brand -->
                                <a href="index.jsp" class="nav-brand"><img src="img/core-img/logo.png" alt=""></a>

                                <!-- Navbar Toggler -->
                                <div class="classy-navbar-toggler">
                                    <span class="navbarToggler"><span></span><span></span><span></span></span>
                                </div>

                                <!-- Menu -->
                                <div class="classy-menu">

                                    <!-- Close Button -->
                                    <div class="classycloseIcon">
                                        <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                                    </div>

                                    <!-- Navbar Start -->
                                    <div class="classynav">
                                        <ul>
                                            <li><a href="index.jsp">Home</a></li>
                                            <li><a href="about.html">About</a></li>
                                            <li><a href="#">Pages</a>
                                                <ul class="dropdown">
                                                    <li><a href="index.jsp">Home</a></li>
                                                    <li><a href="about.html">About</a></li>
                                                    <li><a href="shop.jsp">Shop</a>
                                                        <ul class="dropdown">
                                                            <li><a href="shop.jsp">Shop</a></li>
                                                            <li><a href="shop-details.html">Shop Details</a></li>
                                                            <li><a href="cart.html">Shopping Cart</a></li>
                                                            <li><a href="checkout.html">Checkout</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="portfolio.html">Portfolio</a>
                                                        <ul class="dropdown">
                                                            <li><a href="portfolio.html">Portfolio</a></li>
                                                            <li><a href="single-portfolio.html">Portfolio Details</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="blog.html">Blog</a>
                                                        <ul class="dropdown">
                                                            <li><a href="blog.html">Blog</a></li>
                                                            <li><a href="single-post.html">Blog Details</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="contact.html">Contact</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="shop.jsp">Shop</a></li>
                                            <li><a href="portfolio.html">Portfolio</a></li>
                                            <li><a href="contact.html">Contact</a></li>
                                        </ul>

                                        <!-- Search Icon -->
                                        <div id="searchIcon">
                                            <i class="fa fa-search" aria-hidden="true"></i>
                                        </div>

                                    </div>
                                    <!-- Navbar End -->
                                </div>
                            </nav>

                            <!-- Search Form -->
                            <div class="search-form">
                                <form action="mainController" method="post">
                                    <input type="text" name="txtsearch" id="search" placeholder="Type keywords &amp; press enter..." value="<%= (request.getParameter("txtsearch") == null) ? "" : request.getParameter("txtsearch")%>" required="">
                                    <input type="hidden" name="searchby" value="byname">
                                    <input type="hidden" name="action" value="search">
                                    <button type="submit" class="d-none"></button>
                                </form>
                                <!-- Close Icon -->
                                <div class="closeIcon"><i class="fa fa-times" aria-hidden="true"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <!-- ##### Header Area End ##### -->
        </header>
    </body>
</html>

<%-- 
    Document   : nguoidung
    Created on : Feb 25, 2022, 9:18:20 AM
    Author     : lehon
--%>

<%@page import="thanhlh.dto.Order"%>
<%@page import="thanhlh.dao.OrderDAO"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Manager</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css">
        <link rel="stylesheet" href="css/personal.css">
    </head>

    <body>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            boolean login;
            if (name == null) {
                login = false;
            } else {
                login = true;
            }
            //show content if login = true
            if (login) {
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container fixed"> <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                                  data-bs-target="#mynav" aria-controls="mynav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span> </button> <a class="navbar-brand" href="#">
                    <div class="d-flex">
                        <div class="d-flex align-items-center logo bg-purple">
                            <div class="fab fa-joomla h2 text-white"></div>
                        </div>
                        <div class="ms-3 d-flex flex-column">
                            <div class="h4">Account</div>
                            <div class="fs-6">Manager</div>
                        </div>
                    </div>
                </a>
                <div class="collapse navbar-collapse" id="mynav">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"> <a class="nav-link active" aria-current="page" href="mainController?action=filterOrder">All order <span
                                    class="fas fa-th-large px-1"></span></a> </li>
                        <li class="nav-item"> <a class="nav-link" href="mainController?action=filterOrder&status=1&email=<%=email%>">Processing Order</a> </li>
                        <li class="nav-item"> <a class="nav-link" href="mainController?action=filterOrder&status=2&email=<%=email%>">Completed Order</a> </li>
                        <li class="nav-item"> <a class="nav-link" href="mainController?action=filterOrder&status=3&email=<%=email%>">Canceled Order</a> </li>
                        <li class="nav-item"> <a class="nav-link" href="cart.jsp">

                            </a> </li>
                        <li class="nav-item"> <a class="nav-link" href="mainController?action=logout"> <span class="fas fa-user pe-2"></span>Log out </a> </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container mt-4">
            <div class="row">
                <div class="col-lg-3 my-lg-0 my-md-1">
                    <div id="sidebar" class="bg-purple">
                        <div class="h4 text-white">Account</div>
                        <ul>
                            <li class="active"> <a href="mainController?action=filterOrder" class="text-decoration-none d-flex align-items-start">
                                    <div class="fas fa-box pt-2 me-3"></div>
                                    <div class="d-flex flex-column">
                                        <div class="link">My Orders</div>
                                        <div class="link-desc">View & Manage orders and returns</div>
                                    </div>
                                </a> </li>
                            <li> <a href="cart.jsp" class="text-decoration-none d-flex align-items-start">
                                    <div class="fas fa-box-open pt-2 me-3"></div>
                                    <div class="d-flex flex-column">
                                        <div class="link">View Cart</div>
                                        <div class="link-desc">View & Manage orders and returns</div>
                                    </div>
                                </a> </li>
                            <li> <a href="shop.jsp" class="text-decoration-none d-flex align-items-start">
                                    <div class="far fa-address-book pt-2 me-3"></div>
                                    <div class="d-flex flex-column">
                                        <div class="link">List Product</div>
                                        <div class="link-desc">View & Manage Addresses</div>
                                    </div>
                                </a> </li>
                            <li> <a href="#" class="text-decoration-none d-flex align-items-start">
                                    <div class="far fa-user pt-2 me-3"></div>
                                    <div class="d-flex flex-column">
                                        <div class="link">Change Profile</div>
                                        <div class="link-desc">Change your profile details & password</div>
                                    </div>
                                </a> </li>
                            <li> <a href="#" class="text-decoration-none d-flex align-items-start">
                                    <div class="fas fa-headset pt-2 me-3"></div>
                                    <div class="d-flex flex-column">
                                        <div class="link">Help & Support</div>
                                        <div class="link-desc">Contact Us for help and support</div>
                                    </div>
                                </a> </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9 my-lg-0 my-1">
                    <div id="main-content" class="bg-white border">
                        <div class="d-flex flex-column">
                            <div class="h5">Welcome back: <%= name%></div>
                            <div>Logged in as: <%= email%></div>
                            <%if (request.getAttribute("messCheck") != null) {
                                    if (request.getAttribute("messCheck").equals("true")) {%>
                            <p style="color: green">Completely</p>
                            <%} else {%>
                            <p style="color:red">Failed</p>
                            <%}%>
                            <%}%>
                            <%
                                ArrayList<Order> list = OrderDAO.getOrders(email);
                                if (list != null && !list.isEmpty()) {
                            %> 
                            <c:choose>
                                <c:when test="${empty requestScope.ordersList}">
                                    <p style="color: red;">You don't have any order</p>
                                    <form action="mainController" method="post">
                                        <input type="hidden" name="action" value="filterOrder">
                                        <input type="submit" value="Back to lobby">
                                    </form>
                                </c:when>
                                <c:otherwise>
                                </div>
                                <div class="d-flex my-4 flex-wrap">
                                    <div class="box me-4 my-1 bg-light"> <img
                                            src="https://www.freepnglogos.com/uploads/box-png/cardboard-box-brown-vector-graphic-pixabay-2.png"
                                            alt="">
                                        <div class="d-flex align-items-center mt-2">
                                            <div class="tag">Orders placed</div>
                                            <div class="ms-auto number">10</div>
                                        </div>
                                    </div>
                                    <div class="box me-4 my-1 bg-light"> <img
                                            src="https://www.freepnglogos.com/uploads/shopping-cart-png/shopping-cart-campus-recreation-university-nebraska-lincoln-30.png"
                                            alt="">
                                        <div class="d-flex align-items-center mt-2">
                                            <div class="tag">Items in Cart</div>
                                            <div class="ms-auto number">10</div>
                                        </div>
                                    </div>
                                    <div class="box me-4 my-1 bg-light"> <img
                                            src="https://www.freepnglogos.com/uploads/love-png/love-png-heart-symbol-wikipedia-11.png"
                                            alt="">
                                        <div class="d-flex align-items-center mt-2">
                                            <div class="tag">Wishlist</div>
                                            <div class="ms-auto number">10</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-uppercase">My recent orders</div>


                                <c:forEach var="order" items="${requestScope.ordersList}" >
                                    <div class="order my-3 bg-light">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <div class="d-flex flex-column justify-content-between order-summary">
                                                    <div class="d-flex align-items-center">
                                                        <div class="text-uppercase">Order ID: <c:out value="${order.getOrderID()}"></c:out></div>
                                                            <div class="blue-label ms-auto text-uppercase">paid</div>
                                                        </div>
                                                        <div class="fs-8">Order Date: <c:out value="${order.getOrderDate()}"></c:out></div>
                                                        <div class="fs-8">Ship Date: 
                                                        <c:choose>
                                                            <c:when test="${empty order.getShipDate()}">
                                                                <c:out value="N/A"></c:out>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:out value="${order.getShipDate()}"></c:out>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </div>
                                                    <div class="rating d-flex align-items-center pt-1"> <img
                                                            src="https://www.freepnglogos.com/uploads/like-png/like-png-hand-thumb-sign-vector-graphic-pixabay-39.png"
                                                            alt=""><span class="px-2">Rating:</span> <span class="fas fa-star"></span>
                                                        <span class="fas fa-star"></span> <span class="fas fa-star"></span> <span
                                                            class="fas fa-star"></span> <span class="far fa-star"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-8">
                                                <div class="d-sm-flex align-items-sm-start justify-content-sm-between">
                                                    <div class="status">Status : <c:if test="${order.getStatus() eq 1}">
                                                            <c:out value="Processing"></c:out>
                                                                <div class="btn btn-primary text-uppercase">
                                                                    <form action="mainController" method="post" id="myform">
                                                                        <input type="hidden" name="ordID" value="${order.getOrderID()}">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <input type="button" value="Cancel order" onclick="myFunctionCan()" >
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${order.getStatus() eq 2}">
                                                            <c:out value="Completed"></c:out>
                                                        </c:if>

                                                        <c:if test="${order.getStatus() eq 3}">
                                                            <c:out value="Canceled"></c:out>
                                                                <div class="btn btn-primary text-uppercase">
                                                                    <form action="mainController" method="post" id="myformA">
                                                                        <input type="hidden" name="ordID" value="${order.getOrderID()}">
                                                                    <input type="hidden" name="action" value="again">
                                                                    <input type="button" value="Order again" onclick="myFunctionAgain()" >
                                                                </form>
                                                            </div>
                                                        </c:if></div>

                                                    <div class="btn btn-primary text-uppercase"><a style="color: black" href="orderDetail.jsp?orderid=<c:out value="${order.getOrderID()}"></c:out>">detail</a></div>
                                                    </div>
                                                    <div class="progressbar-track">
                                                    <c:if test="${order.getStatus() eq 1}">
                                                        <ul class="progressbar">
                                                            <li id="step-1" class="text-muted green"> <span class="fas fa-box"></span> 
                                                            </li>
                                                            <li id="step-2" class="text-muted green"> <span class="fas fa-truck"></span>
                                                            </li>
                                                            <li id="step-3" class="text-muted "> <span class="fas fa-check"></span>
                                                            </li>
                                                        </ul>
                                                        <div id="tracker"></div>
                                                    </c:if>
                                                    <c:if test="${order.getStatus() eq 2}">
                                                        <ul class="progressbar">
                                                            <li id="step-1" class="text-muted green"> <span class="fas fa-box"></span> 
                                                            </li>
                                                            <li id="step-2" class="text-muted green"> <span class="fas fa-truck"></span>
                                                            </li>
                                                            <li id="step-3" class="text-muted green"> <span class="fas fa-check"></span>
                                                            </li>
                                                        </ul>
                                                        <div id="tracker"></div>
                                                    </c:if>
                                                    <c:if test="${order.getStatus() eq 3}">
                                                        <ul class="progressbar">
                                                            <li id="step-1" class="text-muted green"> <span class="fas fa-box"></span> 
                                                            </li>
                                                            <li id="step-4" class="text-muted green"> <span class="fas fa-box-open"></span>
                                                            </li>

                                                        </ul>
                                                        <div id="tracker"></div>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <%} else {%>
                        <p style="color: red;">You don't have any order</p>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <% } else {%>
        <p style="color:red">You must login to view personal page</p>
        <%}%>

        <script>
            function myFunctionCan() {
                if (confirm("Are you sure you want to cancel your order?") == true) {
                    document.getElementById("myform").submit();

                } else {
                    return false;

                }
            }

            function myFunctionAgain() {
                if (confirm("Are you sure you want to order again?") == true) {
                    document.getElementById("myformA").submit();

                } else {
                    return false;

                }
            }

        </script>
    </body>

</html>

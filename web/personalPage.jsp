<%-- 
    Document   : personalPage
    Created on : Jan 20, 2022, 9:06:50 AM
    Author     : Lenovo
--%>

<%@page import="thanhlh.dto.Account"%>
<%@page import="thanhlh.dao.AccountDAO"%>
<%@page import="thanhlh.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thanhlh.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personal Page</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
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
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Welcome <%=name%> come back</h3>
            <h3><a style="color: black;" href="mainController?action=logout">Logout</a></h3>
        </section>

        <section> <!--load all order of the user at here--> 
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
                    <form action="mainController" method="post">
                        <input type="hidden" name="action" value="filterOrder">
                        <input type="submit" value="All Order">
                    </form>
                    <form action="mainController" method="post">
                        <input type="hidden" name="status" value="1">
                        <input type="hidden" name="email" value=<%=email%> >
                        <input type="hidden" name="action" value="filterOrder">
                        <input type="submit" value="Processing Order">
                    </form>
                    <form action="mainController" method="post">
                        <input type="hidden" name="status" value="2">
                        <input type="hidden" name="email" value=<%=email%> >
                        <input type="hidden" name="action" value="filterOrder">
                        <input type="submit" value="Completed Order">
                    </form>
                    <form action="mainController" method="post">
                        <input type="hidden" name="status" value="3">
                        <input type="hidden" name="email" value=<%=email%> >
                        <input type="hidden" name="action" value="filterOrder">
                        <input type="submit" value="Canceled Order">
                    </form>

                    <table class="order">
                        <tr><th> Order ID</th>
                            <th> Order Date</th>
                            <th> Ship Date</th>
                            <th> Order's status</th>
                            <th> Action</th>

                        </tr>
                        <c:forEach var="order" items="${requestScope.ordersList}" >
                            <tr><td><c:out value="${order.getOrderID()}"></c:out></td>
                                <td><c:out value="${order.getOrderDate()}"></c:out></td>
                                <td><c:out value="${order.getShipDate()}"></c:out></td>
                                <td> <c:if test="${order.getStatus() eq 1}">
                                        <c:out value="processing"></c:out>
                                    </c:if>
                                    <c:if test="${order.getStatus() eq 2}">
                                        <c:out value="completed"></c:out>
                                    </c:if>

                                    <c:if test="${order.getStatus() eq 3}">
                                        <c:out value="canceled"></c:out>
                                    </c:if>
                                    <br/><c:if test="${order.getStatus() eq 1}">
                                        <form action="mainController" method="post" id="myform">
                                            <input type="hidden" name="ordID" value="${order.getOrderID()}">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="button" value="Cancel order" onclick="myFunctionCan()" >
                                        </form>
                                    </c:if>
                                    <c:if test="${order.getStatus() eq 3}">
                                        <form action="mainController" method="post" id="myformA">
                                            <input type="hidden" name="ordID" value="${order.getOrderID()}">
                                            <input type="hidden" name="action" value="again">
                                            <input type="button" value="Order again" onclick="myFunctionAgain()" >
                                        </form>
                                    </c:if>
                                </td>                               
                                <td><a style="color: black" href="orderDetail.jsp?orderid=<c:out value="${order.getOrderID()}"></c:out>">detail</a></td>
                                </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
            <%} else {%>
            <p style="color: red;">You don't have any order</p>
            <%}%>

        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
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

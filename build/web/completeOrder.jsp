<%-- 
    Document   : personalPage
    Created on : Jan 20, 2022, 9:06:50 AM
    Author     : Lenovo
--%>

<%@page import="thanhlh.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thanhlh.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complete Order</title>
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            if (name == null) {
        %>

        <p><font color='red'>you must login to view personal page</font></p>
        <p></p>

        <%} else {

        %>

        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Welcome <%=name%> come back</h3>
            <h3><a style="color: black;" href="mainController?action=logout">Logout</a></h3>
        </section>
        <section> <!--load all order of the user at here--> 

            <%
                ArrayList<Order> list = OrderDAO.getOrders((String) session.getAttribute("email"));
                String[] status = {"", "processing", "completed", "canceled"};
                int count = 0;
                if (list != null && !list.isEmpty()) {
                    for (Order ord : list) {
                        if (request.getParameter("type").equals("com")) {
                            if (ord.getStatus() == 2) {
                                count++;%> 

            <table class="order">
                <tr><td>Order ID</td><td>Order Date</td><td>Ship Date</td><td>Order's status</td><td>action</td></tr>
                <tr><td><%= ord.getOrderID()%></td>
                    <td><%= ord.getOrderDate()%></td>
                    <td><%= ord.getShipDate()%></td>
                    <td><%= status[ord.getStatus()]%>
                        <br/><% if (ord.getStatus() == 1)%><a style="color: black" href="#">cancel order</a>
                    </td>
                    <td><a style="color: black" href="orderDetail.jsp?orderid=<%= ord.getOrderID() %>">detail</a></td></tr>
            </table>
            <%}%>
            <%}%>

            <%      }
            }   
            %>
            <%if (count == 0) {%>
            <p style="color:red;">You don't have any order</p>
            <%}%>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <% }%>
    </body>
</html>

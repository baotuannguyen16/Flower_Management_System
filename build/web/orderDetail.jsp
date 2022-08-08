<%-- 
    Document   : personalPage
    Created on : Jan 20, 2022, 9:06:50 AM
    Author     : Lenovo
--%>

<%@page import="thanhlh.dto.OrderDetail"%>
<%@page import="thanhlh.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thanhlh.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
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
            <a style="color: black" href="mainController?action=filterOrder">View all orders</a>
        </section>
        <section> <!--load all order of the user at here--> 
            <% String orderid = request.getParameter("orderid");
                if (orderid != null) {
                    int orderID = Integer.parseInt(orderid.trim());
                    ArrayList<OrderDetail> list = OrderDAO.getOrderDetail(orderID);
                    if (list != null && !list.isEmpty()) {
                        int money = 0;
                        for (OrderDetail detail : list) {%>
            <table class="order">
                <tr><td>Order ID</td><td>Plant ID</td><td>Plant name</td><td>Image</td><td>quantity</td></tr>
                <tr><td><%= detail.getOrderID()%></td><td><%= detail.getPlantID()%></td>
                    <td><%= detail.getPlantName()%></td>
                    <td><img src ='<%= detail.getImgPath()%>' class='plantimg'/> <br/> <%= detail.getPrice()%></td>
                    <td><%= detail.getQuantity()%></td>
                    <% money = money + detail.getPrice() * detail.getQuantity(); %>
                </tr>
            </table>
            <% } //end for %>
            <h3> Total money: <%=  money%></h3>
            <% }
            }//end if 
            else {
            %>
            <p>You don't have any order</p>
            <%
                }

                //end if
            %>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <% }%>
    </body>
</html>

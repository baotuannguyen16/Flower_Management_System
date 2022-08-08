<%-- 
    Document   : viewCart
    Created on : Feb 12, 2022, 9:14:19 AM
    Author     : lehon
--%>

<%@page import="thanhlh.dto.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thanhlh.dao.PlantDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <%  int sumPrice = 0;
                String name = (String) session.getAttribute("name");
                if (name != null) {
            %>
            <h3>Welcome <%= session.getAttribute("name")%> come back</h3>
            <h3><a style='color:black' href="mainController?action=logout">Logout</a> </h3>
            <h3><a style='color:black' href="mainController?action=filterOrder">Personal page</a></h3>
            <%
                }%>
            <font><%= (request.getAttribute("WARNING") == null) ? "" : (String) request.getAttribute("WARNING")%> </font>
            <table width="100%" class="shopping">
                <tr><td>Product ID</td><td>Quantity</td><td>Price</td><td>Image</td><td>Action</td></tr>
                <%
                    ArrayList<Plant> list = PlantDAO.getAllPlants();
                    HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");
                    if (cart != null) {
                        Set<String> pids = cart.keySet();
                        for (String pid : pids) {
                            int quantity = cart.get(pid);

                %>
                <form action="mainController" method="post">
                    <tr><td><input type="hidden" value="<%= pid%>" name="pid"><a style="color:black"href="getPlantServlet?pid=<%= pid%>"><%= pid%></a></td>
                        <td><input type="number" value="<%= quantity%>" name="quantity"></td>
                            <%for (Plant p : list) {
                                    if (String.valueOf(p.getId()).equals(pid)) {
                            %>
                        <td><%= p.getPrice()%></td>
                        <td><img src='<%= p.getImgpath()%>' class='plantimg' /></td>
                            <%  sumPrice += p.getPrice() * quantity;
                                    }
                                }%>
                        <td><input type="submit" value="update" name="action">
                            <input type="submit" value="delete" name="action"></td>
                    </tr>
                </form>
                <%}
                } else {
                %>
                <tr><td>Your cart is empty</td></tr>
                <%}
                %>
                <tr><td>Total money: <%= sumPrice%></td></tr>
                <tr><td>Order Date: <%= (new Date()).toString()%> </td></tr>
                <tr><td>Ship Date: N/A </td></tr>
            </table>
        </section>
        <section>
            <form action="mainController" method="post">
                <input type="submit" value="saveOrder" name="action" class="submitorder">
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>

<%-- 
    Document   : header_loginedUser
    Created on : Jan 20, 2022, 9:01:34 AM
    Author     : Lenovo
--%>

<%@page import="thanhlh.dto.Account"%>
<%@page import="thanhlh.dao.AccountDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="mycss.css" type="text/css"/>
    </head>
    <body>

        <%  String emailAD = (String) session.getAttribute("email");
            Account acc = AccountDAO.getAccountByEmail(emailAD);%>
        <nav>
            <ul>
                <%if (acc.getRole() == 1) {%>
                <li><a href="AdminIndex.jsp">Lobby</a></li>         
                    <%}%>
                <li><a href="mainController?action=filterOrder">Manage Order</a></li>
                <li><a href="changeProfile.jsp">Change Profile</a></li>
                <li><a href="cart.jsp">View Cart</a></li>
                <li><a href="shop.jsp">List Product</a></li>
                <form action="mainController" method="post">
                    from<input type="date" name="from"> to <input type="date" name="to">
                    <input type="hidden" name="action" value="searchByDate">
                    <input type="submit" value="search">
                </form>
            </ul>
        </nav>
    </body>
</html>

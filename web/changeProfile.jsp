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
        <title>Change Profile</title>
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
            <h1>Change Profile</h1><br>
            <%if (request.getAttribute("result") != null) {
                    if (request.getAttribute("result").equals("Succeeded")) {%>
            <p style="color:green">Succeeded</p>
            <%} else {%>
            <p style="color:red">Wrong password, please try again</p>
            <%}%>
            <%}%>


            <form action="mainController" method="post">
                <label for="fname">Full name</label><br>
                <input type="text" id="fname" name="txtname" required=""><br><br>
                <label for="phone">Phone</label><br>
                <input type="text" id="phone" name="txtphone" required=""><br><br>
                <label for="pass">Password</label><br>
                <input type="password" id="pass" name="txtpass" required=""><br><br>
                <input type="hidden" name="txtmail" value="<%= session.getAttribute("email")%>">
                <input type="submit" value="change" name="action">
            </form> 

        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <% }%>
    </body>
</html>

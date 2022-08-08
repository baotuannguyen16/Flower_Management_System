<%-- 
    Document   : adminPage
    Created on : Feb 10, 2022, 1:25:18 PM
    Author     : lehon
--%>

<%@page import="thanhlh.dao.AccountDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thanhlh.dto.Account"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Page</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <%String name = (String) session.getAttribute("name");
            if (name == null) {%>
        <p><font color="red">You must login to view personal page</font></p>
        <p></p>
        <%
        } else {
        %>
        <c:import url="header_loginedAdmin.jsp"></c:import>
            <section class="right">
                <img width="100%" height="100%" src="images/background.jpg" alt="MISSING JPG" />
            </section>
        <%            }
        %>
    </body>
</html>

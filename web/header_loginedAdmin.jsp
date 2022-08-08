<%-- 
    Document   : header_loginedAdmin.jsp
    Created on : Feb 16, 2022, 9:32:35 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin page</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <header>
            <ul>
                <li><a href="mainController?action=manageAccounts">Manage Accounts</a></li>
                <li><a href="mainController?action=filterOrder">Manage Orders</a></li>
                <li><a href="index.jsp">Manage Plants</a></li>
                <li><a href="ManageCategories.jsp">Manage categories</a></li>
                <li>Welcome ${sessionScope.name} | <a href="mainController?action=logout">Logout</a></li>
            </ul>
        </header>
    </body>
</html>

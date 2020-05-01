<%-- 
    Document   : index.jsp
    Created on : Apr 28, 2020, 4:45:59 PM
    Author     : silen
--%>
<%@page import="com.cs336FinalProject.pkg.ApplicationDB"%>
<%
	ApplicationDB d = new ApplicationDB();
	d.getConnection();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration</title>
</head>
<body>

<%
	//TODO: set null values pulled from db in forms to '' and when sending '' send NULL
		  
%>
	<form method="get" action="viewCustomers.jsp">
		<input type="submit" value="View All Customers">
	</form>
	
	<form method="get" action="viewEmployees.jsp">
		<input type="submit" value="View All Employees">
	</form>

</body>
</html>
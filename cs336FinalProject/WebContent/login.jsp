<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
</head>
<body>
	<%
		String logoutSuccessful = request.getParameter("logoutSuccessful") == null ? "" : request.getParameter("logoutSuccessful");
		if(logoutSuccessful.equals("1")){
			session.setAttribute("username", null);
		}
	%>
	Login
	<form method="post" action="loginSuccess.jsp">
		<%
			String loginFailed = request.getParameter("loginFailed") == null ? "" : request.getParameter("loginFailed");
			if(loginFailed.equals("1")) out.print("<span color='red'>Username or Password not recognized</span><br/>");
		%>
		Username: <input type="text" name="username">
		<br/>
		Password: <input type="text" name="password">
		<br/>
		<input type="submit" value="Login">
	</form>
	
	New Users
	<form method="get" action="newCustomer.jsp">
		<input type="submit" value="New Customer">
	</form>
	<br/>
	<form method="get" action="newEmployee.jsp">
		<input type="submit" value="New Employee">
	</form>

</body>
</html>


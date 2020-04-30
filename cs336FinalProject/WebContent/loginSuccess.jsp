<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TrainSystem</title>
</head>
<body>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			
			String username = request.getParameter("username") == null ? "" : request.getParameter("username");
			String password = request.getParameter("password") == null ? "" : request.getParameter("password");
			
			Statement sqlStatement = connection.createStatement();
			
			String sqlText = "SELECT * FROM SiteUsers WHERE Username='" + username + "' AND Password='" + password + "'";
			
			ResultSet result = sqlStatement.executeQuery(sqlText);
			
			if(!result.next()){
				db.closeConnection(connection);
				response.sendRedirect("login.jsp?loginFailed=1");
			}else{
				out.print("Login Successful!");
				session.setAttribute("username", result.getObject("username"));
				
				if(session.getAttribute("username").equals("admin")){
					response.sendRedirect("adminHome.jsp");
				}
			}
			db.closeConnection(connection);
			
		} catch(Exception e){
			out.print(e);
		}
	%>
	
	<form method="get" action="login.jsp?logoutSuccessful=1">
		<input type="submit" value="Log Out">
	</form>
</body>
</html>
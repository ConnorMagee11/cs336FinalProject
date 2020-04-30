<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New Customer</title>
</head>
<body>

	<%
		//TODO: we need to accomodate more fields here
		String username = request.getParameter("username") == null ? "" : request.getParameter("username");
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		
		if(username.equals("") || password.equals("") || email.equals(""))
			out.print("Please Enter Sufficient information to create a new customer account");
		else{
			try{
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				Statement statement1 = conn.createStatement();
				
				String userSql = "INSERT INTO SiteUsers" + 
				             " (Username,Password) " +
						     " VALUES " +
				             " ('" + username + "','" + password + "');";
				
				String customerSql = "INSERT INTO Customers" +
						" (Email, Username, Password) " +
						" VALUES " + 
						" ('" + email + "','" + username + "','" + password +"')";
				
				statement1.execute(userSql);
				statement1.execute(customerSql);
			
				db.closeConnection(conn);
				
				response.sendRedirect("login.jsp");
			
			} catch(Exception e){
				out.print(e);
			}
		}
	%>
	
	<form method="post" action="newCustomer.jsp">
		Username: <input type="text" name="username">
		<br/>
		Password: <input type="text" name="password">
		<br/>
		Email: <input type="text" name="email">
		<br/>
		<input type="submit" value="Submit">
	</form>

</body>
</html>
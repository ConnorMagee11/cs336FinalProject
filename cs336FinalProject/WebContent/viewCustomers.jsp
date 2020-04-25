<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration - Customers</title>
</head>
<body>
	<h2>Customers</h2>
	<%
		if(!session.getAttribute("username").equals("admin")){
			response.sendRedirect("notAuthorized.jsp");
		}
	
		String unametodelete = request.getParameter("unametodelete");
		
		if(unametodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				String customerSQL = "DELETE FROM Customers WHERE + Username='" + unametodelete + "'";
				String siteUserSQL = "DELETE FROM SiteUsers WHERE + Username='" + unametodelete + "'";
				
				statement.executeUpdate(customerSQL);
				statement.executeUpdate(siteUserSQL);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	<form method="get" action="adminHome.jsp">
		<input type="submit" value="Back to Administration Home">
	</form>
	<table cellpadding="3px" cellspacing="3px">
		<tr>
			<th>Username</th>
			<th>Password</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email</th>
			<th>Address</th>
			<th>City</th>
			<th>State</th>
			<th>ZipCode</th>
			<th>Phone Number</th>
			<th></th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("SELECT * FROM Customers");
				
				while(results.next()){
					String html = "<tr>" + 
								  "<td>" + results.getObject("Username") + "</td>" +
								  "<td>" + results.getObject("Password") + "</td>" +
								  "<td>" + results.getObject("FirstName") + "</td>" +
								  "<td>" + results.getObject("LastName") + "</td>" +
								  "<td>" + results.getObject("Email") + "</td>" +
								  "<td>" + results.getObject("Address") + "</td>" +
								  "<td>" + results.getObject("City") + "</td>" +
								  "<td>" + results.getObject("State") + "</td>" +
								  "<td>" + results.getObject("Zipcode") + "</td>" +
								  "<td>" + results.getObject("PhoneNumber") + "</td>" +
								  "<td><form method='get' action='editCustomer.jsp'>" +
								  "<input type='hidden' name='unametoedit' value='" + results.getObject("Username") + "'>" +
								  "<input type='submit' value='edit'></form></td>" +
								  "<td><form method='get' action='viewCustomers.jsp'>" +
								  "<input type='hidden' name='unametodelete' value='" + results.getObject("Username") + "'>" +
								  "<input type='submit' value='delete'></form></td>" +
								  "</tr>";
					out.print(html);
				}
				
				db.closeConnection(connection);
				
			} catch(Exception e){
				out.print(e);
			}
		%>
	</table>
	<br/>
	<form method="get" action="newCustomer.jsp">
		<input type="submit" value="Add Customer">
	</form>

</body>
</html>
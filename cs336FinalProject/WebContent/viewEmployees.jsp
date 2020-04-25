<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration - Employees</title>
</head>
<body>
	<h2>Employees</h2>
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
				
				String employeeSQL = "DELETE FROM Employees WHERE + Username='" + unametodelete + "'";
				String siteUserSQL = "DELETE FROM SiteUsers WHERE + Username='" + unametodelete + "'";
				
				statement.executeUpdate(employeeSQL);
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
			<th>Social Security Number</th>
			<th>Customer Service Representative ID</th>
			<th>Manager ID</th>
			<th></th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("SELECT * FROM Employees");
				
				while(results.next()){
					String html = "<tr>" + 
								  "<td>" + results.getObject("Username") + "</td>" +
								  "<td>" + results.getObject("Password") + "</td>" +
								  "<td>" + results.getObject("FirstName") + "</td>" +
								  "<td>" + results.getObject("LastName") + "</td>" +
								  "<td>" + results.getObject("ssn") + "</td>" +
								  "<td>" + results.getObject("csrId") + "</td>" +
								  "<td>" + results.getObject("managerId") + "</td>" +
								  "<td><form method='get' action='editEmployee.jsp'>" +
								  "<input type='hidden' name='unametoedit' value='" + results.getObject("Username") + "'>" +
								  "<input type='submit' value='edit'></form></td>" +
								  "<td><form method='get' action='viewEmployees.jsp'>" +
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
	<form method="get" action="newEmployee.jsp">
		<input type="submit" value="Add Employee">
	</form>

</body>
</html>
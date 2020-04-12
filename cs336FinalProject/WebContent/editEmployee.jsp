<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Employee</title>
</head>
<body>
	<form method="get" action="viewEmployees.jsp">
		<input type="submit" value="Back to all Employees">
	</form>
	<h2>Edit Employee <%=request.getParameter("unametoedit") %></h2>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String isPostback = request.getParameter("isPostback") == null ? "" : request.getParameter("isPostback");
			
			if(isPostback.equals("1")){
				String updateUserSQL = "UPDATE SiteUsers " +
									   "SET " +
									   "Username='" + request.getParameter("editUsername") + "', " + 
									   "Password='" + request.getParameter("editPassword") + "' " +
									   "WHERE Username='" + request.getParameter("unametoedit") + "';";
				statement.executeUpdate(updateUserSQL);
				
				String updateEmployeeSQL = "UPDATE Employees " + 
								   "SET " +
								   "FirstName='" + request.getParameter("editFirstName") + "', " +
								   "LastName='" + request.getParameter("editLastName") + "', " +
								   "ssn='" + request.getParameter("editSSN") + "', " +
								   "csrId='" + request.getParameter("editcsrId") + "', " +
								   "managerId='" + request.getParameter("editmanagerId") + "' " +
								   "WHERE Username='" + request.getParameter("editUsername") + "';";
				statement.executeUpdate(updateEmployeeSQL);
				response.sendRedirect("editEmployee.jsp?unametoedit=" + request.getParameter("editUsername"));
			}
			
			ResultSet results = statement.executeQuery("SELECT * FROM Employees WHERE Username='" + request.getParameter("unametoedit") + "';");
			
			if(results.next()){
	%>
				<form method="post" action="editEmployee.jsp?isPostback=1">
					<input type="hidden" name="unametoedit" value=<%=request.getParameter("unametoedit") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>Username: </td>
							<td><input type="text" name="editUsername" value=<%=results.getObject("Username") %>></td>
						</tr>
						<tr>
							<td>Password: </td>
							<td><input type="text" name="editPassword" value=<%=results.getObject("Password") %>></td>
						</tr>
						<tr>
							<td>First Name: </td>
							<td><input type="text" name="editFirstName" value=<%=results.getObject("FirstName") %>></td>
						</tr>
						<tr>
							<td>Last Name: </td>
							<td><input type="text" name="editLastName" value=<%=results.getObject("LastName") %>></td>
						</tr>
						<tr>
							<td>Social Security Number: </td>
							<td><input type="text" name="editSSN" value=<%=results.getObject("ssn") %>></td>
						</tr>
						<tr>
							<td>Customer Service Representative Id: </td>
							<td><input type="text" name="editcsrId" value=<%=results.getObject("csrId") %>></td>
						</tr>
						<tr>
							<td>Manager Id: </td>
							<td><input type="text" name="editmanagerId" value=<%=results.getObject("managerId") %>></td>
						</tr>
						<tr>
							<td><input type="submit" value="Submit"></td>
						</tr>
					</table>
				</form>
	<%			db.closeConnection(connection);
			}else {
				out.print("No such record exists. Please check the integrity of the database.");
			}
		} catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>
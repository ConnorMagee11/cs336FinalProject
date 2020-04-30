<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Customer</title>
</head>
<body>
	<form method="get" action="viewCustomers.jsp">
		<input type="submit" value="Back to all Customers">
	</form>
	<h2>Edit Customer <%=request.getParameter("unametoedit") %></h2>
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
				
				String updateCustomerSQL = "UPDATE Customers " + 
								   "SET " +
								   "FirstName='" + request.getParameter("editFirstName") + "', " +
								   "LastName='" + request.getParameter("editLastName") + "', " +
								   "Email='" + request.getParameter("editEmail") + "', " +
								   "Address='" + request.getParameter("editAddress") + "', " +
								   "City='" + request.getParameter("editCity") + "', " +
								   "State='" + request.getParameter("editState") + "', " +
								   "Zipcode='" + request.getParameter("editZipcode") + "', " +
								   "PhoneNumber='" + request.getParameter("editPhoneNumber") + "' " +
								   "WHERE Username='" + request.getParameter("editUsername") + "';";
				statement.executeUpdate(updateCustomerSQL);
				response.sendRedirect("editCustomer.jsp?unametoedit=" + request.getParameter("editUsername"));
			}
			
			ResultSet results = statement.executeQuery("SELECT * FROM Customers WHERE Username='" + request.getParameter("unametoedit") + "';");
			
			if(results.next()){
	%>
				<form method="post" action="editCustomer.jsp?isPostback=1">
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
							<td>Email: </td>
							<td><input type="text" name="editEmail" value=<%=results.getObject("Email") %>></td>
						</tr>
						<tr>
							<td>Address: </td>
							<td><input type="text" name="editAddress" value=<%=results.getObject("Address") %>></td>
						</tr>
						<tr>
							<td>City: </td>
							<td><input type="text" name="editCity" value=<%=results.getObject("City") %>></td>
						</tr>
						<tr>
							<td>State: </td>
							<td><input type="text" name="editState" value=<%=results.getObject("State") %>></td>
						</tr>
						<tr>
							<td>Zip Code: </td>
							<td><input type="text" name="editZipcode" value=<%=results.getObject("Zipcode") %>></td>
						</tr>
						<tr>
							<td>Phone Number: </td>
							<td><input type="text" name="editPhoneNumber" value=<%=results.getObject("PhoneNumber") %>></td>
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
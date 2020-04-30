
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Service Representative Adds Customer</title>
</head>
<body>
	<form method="post" action="AddNewReservationPage1.jsp">
	<input type="submit" value="Return to Add a Reservation for the Customer">
	</form>

	<h2>Add New Customer</h2>
	
	The fields username, password, and email must be filled out.
	
	<br/>
	<br/>
	
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String isPostback = request.getParameter("isPostback") == null ? "" : request.getParameter("isPostback");
			
			if(isPostback.equals("1")){
				int x=0;
				
				try
				{
					String updateUserSQL = "Insert into SiteUsers values (" +
									   "'" + request.getParameter("editUsername") + "', " + 
									   "'" + request.getParameter("editPassword") + "')";
					statement.executeUpdate(updateUserSQL);
				
						String updateCustomerSQL = "Insert into Customers (firstname, lastname, email, address, city, state, zipcode, username, password, phonenumber) values (" + 
								   "'" + request.getParameter("editFirstName") + "', " +
								   "'" + request.getParameter("editLastName") + "', " +
								   "'" + request.getParameter("editEmail") + "', " +
								   "'" + request.getParameter("editAddress") + "', " +
								   "'" + request.getParameter("editCity") + "', " +
								   "'" + request.getParameter("editState") + "', " +
								   "'" + request.getParameter("editZipcode") + "', " +
								   "'" + request.getParameter("editUsername") + "', " +
								   "'" + request.getParameter("editPassword") + "', " +
								   "'" + request.getParameter("editPhoneNumber") + "')" ;
						statement.executeUpdate(updateCustomerSQL);
						
						out.print("Customer Added Successfully!");
			
				}
				catch (Exception e)
				{
					out.print (" That username, password, or email already exists. Please enter new values for those fields.");
					
				}
	
			}	
			

	%>
				<form method="post" action="NewCustomer_CSR.jsp?isPostback=1">
					<input type="hidden" name="unametoedit">
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>Username:* </td>
							<td><input type="text" name="editUsername" ></td>
						</tr>
						<tr>
							<td>Password:* </td>
							<td><input type="text" name="editPassword" ></td>
						</tr>
						<tr>
							<td>Email:* </td>
							<td><input type="text" name="editEmail"></td>
						</tr>
						<tr>
							<td>First Name: </td>
							<td><input type="text" name="editFirstName" ></td>
						</tr>
						<tr>
							<td>Last Name: </td>
							<td><input type="text" name="editLastName" ></td>
						</tr>
						<tr>
							<td>Address: </td>
							<td><input type="text" name="editAddress"></td>
						</tr>
						<tr>
							<td>City: </td>
							<td><input type="text" name="editCity" ></td>
						</tr>
						<tr>
							<td>State: </td>
							<td><input type="text" name="editState"></td>
						</tr>
						<tr>
							<td>Zip Code: </td>
							<td><input type="text" name="editZipcode"></td>
						</tr>
						<tr>
							<td>Phone Number: </td>
							<td><input type="text" name="editPhoneNumber"></td>
						</tr>
						<tr>
							<td><input type="submit" value="Submit"></td>
						</tr>
					</table>
				</form>
	<%			db.closeConnection(connection);
		
		
		} catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>
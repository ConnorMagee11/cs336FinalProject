
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
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<h2>Edit Customer Information - Customer Representative Access</h2>
	
	Note: Customer Service Representatives Cannot Update a Customer's Username or Password.
	<br/>
	<br/>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String isPostback = request.getParameter("isPostback") == null ? "" : request.getParameter("isPostback");
			
			if(isPostback.equals("1")){
			
				
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
								   "WHERE email='" + request.getParameter("email") + "';";
				statement.executeUpdate(updateCustomerSQL);
				response.sendRedirect("EditReservationInfo.jsp?reservationid=" + request.getParameter("reservationid"));
			}
			
			ResultSet results = statement.executeQuery("SELECT * FROM Customers WHERE email='" + request.getParameter("email") + "';");
			
			if(results.next()){
	%>
				<form method="post" action="EditCustomerInfo_CSR.jsp?isPostback=1">
					<input type="hidden" name="email" value=<%=request.getParameter("email") %>>
					<input type='hidden' name="reservationid" value=<%=request.getParameter("rid")%>>
					<table cellpadding="3px" cellspacing="3px">
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
							<td><input type="submit" value="Submit and Return to Customer's Reservation Info"></td>
						</tr>
					</table>
				</form>
	<%			db.closeConnection(connection);
			}else {
				out.print("No such record exists. Please check the integrity of the database.");
			}
		} catch(Exception e){
			out.print("That email already exists. Please enter a new email.");
		}
	%>
</body>
</html>
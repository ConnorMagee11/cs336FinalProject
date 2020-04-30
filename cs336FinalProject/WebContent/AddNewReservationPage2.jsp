<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Reservation - Reservation Type</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
ADD NEW RESERVATION-CUSTOMER INFORMATION
<br/>
<br/>
Making a reservation for a customer is as simple as 1, 2, 3!
<br/>
<br/>
1. Enter customer email
<br/>
<b>2. Select the type of trip</b>
<br/>
3. Proceed to checkout
<br/>
Done!
<br/>
<br/>
<br/>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			String customeremail = request.getParameter("customeremail") == null ? "" : request.getParameter("customeremail");
			Statement sqlStatement = connection.createStatement();
			
			String sqlText = "SELECT * FROM Customers WHERE email='" + customeremail + "'";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			
			if(!result.next()){
				db.closeConnection(connection);
				response.sendRedirect("AddNewReservationPage1.jsp?customeremailFailed=1");

			}else{
				session.setAttribute("customeremail", customeremail);		
			}
			db.closeConnection(connection);
			
		} catch(Exception e){
			out.print(e);
		}
	%>
Make an one-way reservation between two stops.	
	<form method="post" action="AddNewReservationOneWayTrip.jsp">
		<input type="submit" value="Reserve a One-Way Trip">
	</form>
	<br/>
	
Make a round trip reservation between two stops.		
	<br/>
	<form method="post" action="AddNewRoundTrip.jsp">
		<input type="submit" value="Reserve a Round Trip">
	</form>
	<br/>
Buy a weekly train pass to make an unlimited number of trips between two stops for one week.
	<br/>
	<form method="post" action="AddWeeklyReservation.jsp">
		<input type="submit" value="Buy Weekly Pass">
	</form>
	<br/>
Buy a monthly train pass to make an unlimited number of trips between two stops for one month.
	<br/>
	<form method="post" action="AddMonthlyReservation.jsp">
		<input type="submit" value="Buy Monthly Pass">
	</form>
	
	<br/>
	<form method="post" action="AddNewReservationPage1.jsp">
		<input type="submit" value="Start Over">
	</form>

</body>
</html>
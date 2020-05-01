<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Customer Reservations_Customer Representative View</title>
</head>
<body>
	<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>

	<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			
			String transitline = request.getParameter("transitline") == null ? "" : request.getParameter("transitline");
			String train = request.getParameter("train") == null ? "" : request.getParameter("train");
			String title="List of Customers Who Made a Reservations on Transit Line: "+transitline+" and Train Number: "+train+"";
			out.println(title);
	%>
	<br/>
	<table cellpadding="3px" cellspacing="20px">
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Address</th>
			<th>Telephone</th>
			<th>E-mail</th>
			<th>Username</th>
		</tr>
	<br/>
	<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText = "select distinct c.* from Customers c, Reservations r, Multivalue_Reservations_Trips m, Trips t, Routes ro where r.CustomerEmail=c.Email and r.Reservationid=m.Reservationid and m.Tripid=t.tripid and t.Routeid=ro.Routeid and ro.name='" + transitline + "' and t.Trainid='"+ train + "' and r.rtype!='Weekly' and r.rtype!='Monthly'";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			
			while(result.next()){
				String html = "<tr>" + 
							"<td style='text-align:center'>" + result.getObject("FirstName") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("LastName") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Address") + ", "+ result.getObject("City") + " "+ result.getObject("State") + " "+ result.getObject("Zipcode") +   "</td>"
							 +"<td style='text-align:center'>" + result.getObject("phonenumber") + "</td>"
							 +"<td style='text-align:center'>" + result.getObject("email") + "</td>"
							+"<td style='text-align:center'>" + result.getObject("username") + "</td>";
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No customers exists for this search. Please try a different search.");
			}
		
			db.closeConnection(connection);
							
		} catch(Exception e){
			out.print(e);
		}
	%>

	<table>
	<form method="post" action="findCustomerReservations.jsp">
		<input type="submit" value="Do a New Search">
	</form>
	

</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.text.DateFormatSymbols" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration - Revenue Listing</title>
</head>
<body>
	<%
		if(!session.getAttribute("username").equals("admin")){
			response.sendRedirect("notAuthorized.jsp");
		}
	%>
	<h2>Revenue Listing</h2>
	<br/>
	<form method="get" action="adminHome.jsp">
		<input type="submit" value="Back to Administration Home">
	</form>
	<table>
		<tr>
			<th>Reservation ID</th>
			<th>Reservation Date</th>
			<th>Customer Email</th>
			<th>Customer Name</th>
			<th>Trip ID</th>
			<th>Route</th>
			<th>Starting City</th>
			<th>Destination City</th>
			<th>Fare Paid</th>
		</tr>
		<%
			float totalRevenue = 0.0f;
			try{
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				Statement statement = conn.createStatement();
				
				String selectStatement = 
					"SELECT " +  
						"r.ReservationId, " +
					    "r.ReservationDate, " +
					    "r.CustomerEmail, " +
					    "CONCAT(c.FirstName, ' ', c.LastName) CustomerName, " +
					    "t.tripId, " +
					    "rt.name RouteName, " +
					    "s.City SourceCity, " +
					    "d.City DestinationCity, " +
					    "m.FarePicked " +
					"FROM Trips t " +
					"INNER JOIN Multivalue_Reservations_Trips m ON t.TripId=m.TripId " +
					"INNER JOIN Reservations r ON m.ReservationId=r.ReservationId " +
					"INNER JOIN Routes rt ON t.RouteId=rt.RouteId " +
					"INNER JOIN Stations s ON t.SourceStationId=s.StationId " +
					"INNER JOIN Stations d ON t.DestinationStationId=d.StationId " +
					"INNER JOIN Customers c ON r.CustomerEmail=c.Email ";
				
				String whereClause = "";
				if(request.getParameter("routeId") != null){
					whereClause = "WHERE t.RouteId='" + request.getParameter("routeId") + "';";
				}else if(request.getParameter("stationId") != null){
					whereClause = "WHERE d.StationId='" + request.getParameter("stationId") + "';";
				}else{
					throw new Exception("Invalid Input Entered");
				}
				
				ResultSet results = statement.executeQuery(selectStatement + whereClause);
				
				while(results.next()){
					totalRevenue += results.getFloat("FarePicked");
					String html = 
						"<tr>" + 
							"<td>" + results.getObject("ReservationId") + "</td>" +
							"<td>" + results.getObject("ReservationDate") + "</td>" +
							"<td>" + results.getObject("CustomerEmail") + "</td>" +
							"<td>" + results.getObject("CustomerName") + "</td>" +
							"<td>" + results.getObject("tripId") + "</td>" +
							"<td>" + results.getObject("RouteName") + "</td>" +
							"<td>" + results.getObject("SourceCity") + "</td>" +
							"<td>" + results.getObject("DestinationCity") + "</td>" +
							"<td>" + results.getObject("FarePicked") + "</td>" +
						"</tr>";
					out.print(html);
				}
				
				db.closeConnection(conn);
			}catch(Exception e){
				out.print(e);
			}
		
		%>
	</table>
	<br/>
	Total Revenue: $<%=totalRevenue %>
</body>
</html>
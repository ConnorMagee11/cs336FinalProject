<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration - Reservations</title>
</head>
<body>
	<%
		if(!session.getAttribute("username").equals("admin")){
			response.sendRedirect("notAuthorized.jsp");
		}
	%>
	<form method="get" action="adminHome.jsp">
		<input type="submit" value="Back to Administration Home">
	</form>
	<table>
		<tr>
			<th>Reservation ID</th>
			<th>Reservation Date</th>
			<th>Total Fare</th>
			<th>Customer First Name</th>
			<th>Customer Last Name</th>
			<th>Customer Email</th>
			<th>Route</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Source Station</th>
			<th>Destination Station</th>
			<th>Train Number</th>
		</tr>
	<%
		float totalRevenue = 0.0f;
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement statement = conn.createStatement();
			
			String selectStatement = "SELECT " +
										"r.ReservationId, " +
										"r.ReservationDate, " +
										"r.total_fare, " +
										"r.CustomerEmail, " +
										"c.FirstName, " +
										"c.LastName, " +
										"t.StartTime, " +
									    "t.EndTime, " +
									    "rt.name Route, " +
									    "t.RouteId, " +
									    "s.StationName SourceStation, " +
									    "t.SourceStationId, " +
									    "d.StationName DestinationStation, " +
									    "t.DestinationStationId, " +
									    "t.TrainId TrainNumber " +
									 "FROM Reservations r " +
									 "INNER JOIN Customers c ON r.CustomerEmail=c.Email " + 
									 "INNER JOIN Multivalue_Reservations_Trips m ON r.ReservationId=m.ReservationId " +
									 "INNER JOIN Trips t ON m.TripId=t.TripId " +
									 "INNER JOIN Routes rt ON t.RouteId=rt.RouteId " +
									 "INNER JOIN Stations s ON t.SourceStationId=s.StationId " +
									 "INNER JOIN Stations d on t.DestinationStationId=d.StationId ";
			
			String whereClause = "";
			
			if(request.getParameter("custFirstName") != null && request.getParameter("custLastName") != null){
				whereClause = "WHERE c.FirstName='" + request.getParameter("custFirstName") + "' AND c.LastName='" + request.getParameter("custLastName") + "';";
			} else if(request.getParameter("routeId") != null && request.getParameter("trainId") != null){
				whereClause = "WHERE t.RouteId=" + request.getParameter("routeId") + " AND t.TrainId=" + request.getParameter("trainId") + ";";
			} else{
				throw new Exception("Invalid Input Entered");
			}
			
			ResultSet results = statement.executeQuery(selectStatement + whereClause);
			
			while(results.next()){
				totalRevenue += results.getFloat("total_fare");
				String html = "<tr>" +
								"<td>" + results.getObject("ReservationId") + "</td>" +
								"<td>" + results.getObject("ReservationDate") + "</td>" +
								"<td>" + results.getObject("total_fare") + "</td>" +
								"<td>" + results.getObject("FirstName") + "</td>" +
								"<td>" + results.getObject("LastName") + "</td>" +
								"<td>" + results.getObject("CustomerEmail") + "</td>" +
								"<td>" + results.getObject("Route") + "</td>" +
								"<td>" + results.getObject("StartTime") + "</td>" +
								"<td>" + results.getObject("EndTime") + "</td>" +
								"<td>" + results.getObject("SourceStation") + "</td>" +
								"<td>" + results.getObject("DestinationStation") + "</td>" +
								"<td>" + results.getObject("TrainNumber") + "</td>" +
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
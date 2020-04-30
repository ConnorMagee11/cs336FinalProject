<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration</title>
</head>
<body>
	<h2>Administration Home</h2>
	
	<form method="get" action="login.jsp?logoutSuccessful=1">
		<input type="submit" value="Log Out">
	</form>
</body>

	<%
		//TODO: set null values pulled from db in forms to '' and when sending '' send NULL
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement statement = conn.createStatement();
			
			String bestCustomerSQL = 
					"SELECT r.CustomerEmail, c.FirstName, c.LastName " +
					"FROM Reservations r " +
					"INNER JOIN Customers c ON r.CustomerEmail=c.Email " +
					"GROUP BY CustomerEmail " +
					"HAVING COUNT(ReservationId) = (" +
						"SELECT MAX(t1.resCount) " +
						"FROM (" +
							"SELECT COUNT(ReservationId) resCount " +
							"FROM Reservations " +
							"GROUP BY CustomerEmail" +
					    ") t1 " +
					");";
					
			ResultSet bestCustomerResults = statement.executeQuery(bestCustomerSQL);
			
			if(bestCustomerResults.next()){
	%>
	Best Customer: <%=bestCustomerResults.getObject("FirstName").toString() + " " + bestCustomerResults.getObject("LastName").toString() + " (" + bestCustomerResults.getObject("CustomerEmail").toString() + ")"%>
	<br/>
	<%
	
		String topFiveLinesSQL = 
			"SELECT r.name routeName, COUNT(m.tripId) reservations " +
			"FROM Multivalue_Reservations_Trips m " +
			"INNER JOIN Trips t ON m.tripId=t.tripId " +
			"INNER JOIN Routes r ON t.RouteId=r.RouteId " +
			"GROUP BY r.RouteId " +
			"ORDER BY reservations " +
			"LIMIT 5;";
			
		ResultSet topFiveLinesResults = statement.executeQuery(topFiveLinesSQL);
		
		out.print("<br/>Top Five Most Active Transit Lines <br/>");
		while(topFiveLinesResults.next()){
			out.print(topFiveLinesResults.getObject("routeName").toString() + "<br/>");
		}
			
			}
	%>
	<br/>
	<form method="post" action="adminViewReservations.jsp">
		Search Reservations by Customer Name
		<br/>
		First Name: <input type="text" name="custFirstName"/>
		<br/>
		Last Name: <input type="text" name="custLastName"/>
		<br/>
		<input type="submit" value="Search" />
	</form>
	<br/>
	<form method="post" action="adminViewReservations.jsp">
		Search Reservations by Route and Train Number<br/>
		Route:
		<select id="ddRoute" name="routeId">
		<%
			String routeSQL = "SELECT RouteId, name FROM Routes;";
			ResultSet routeResults = statement.executeQuery(routeSQL);
			
			while(routeResults.next()){
				out.print("<option value='" + routeResults.getInt("RouteId") + "'>" + routeResults.getString("name") + "</option>");
			}
		%>
		</select>
		<br/>
		Train Number:
		<select id="ddRoute" name="trainId">
		<%
			String trainSQL = "SELECT TrainId FROM Trains;";
			ResultSet trainResults = statement.executeQuery(trainSQL);
			
			while(trainResults.next()){
				out.print("<option value='" + trainResults.getInt("TrainId") + "'>" + trainResults.getInt("TrainId") + "</option>");
			}
		%>
		</select>
		<br/>
		<input type="submit" value="Search" />
	</form>
	<br/>
	<form method="post" action="listRevenue.jsp">
		List Revenue for Route:
		<select id="ddRoute2" name="routeId">
		<%
			ResultSet routeResults2 = statement.executeQuery(routeSQL);
			while(routeResults2.next()){
				out.print("<option value='" + routeResults2.getInt("RouteId") + "'>" + routeResults2.getString("name") + "</option>");
			}
		%>
		</select>
		<br/>
		<input type="submit" value="Go" />
	</form>
	<br/>
	<form method="post" action="listRevenue.jsp">
		List Revenue for Destination City:
		<select id="ddRoute2" name="stationId">
		<%
			String stationSQL = "SELECT StationId, City FROM Stations";
			ResultSet stationResults = statement.executeQuery(stationSQL);
			while(stationResults.next()){
				out.print("<option value='" + stationResults.getInt("stationId") + "'>" + stationResults.getString("City") + "</option>");
			}
		%>
		</select>
		<br/>
		<input type="submit" value="Go" />
	</form>	
	<%
		db.closeConnection(conn);
		} catch(Exception e){
			out.print(e); //TODO: take this out once debugging is over
			out.print("A database error occurred");
		}
	%>
	<br/>
	<form method="post" action="salesReport.jsp">
		View Sales Report for 
		<select id="ddSalesMonth" name="salesMonth">
			<option value="1">January</option>
			<option value="2">February</option>
			<option value="3">March</option>
			<option value="4">April</option>
			<option value="5">May</option>
			<option value="6">June</option>
			<option value="7">July</option>
			<option value="8">August</option>
			<option value="9">September</option>
			<option value="10">October</option>
			<option value="11">November</option>
			<option value="12">December</option>
		</select>
		2020 
		<br/>
		<input type="submit" value="Go">
	</form>
	<br/>
	<form method="get" action="viewCustomers.jsp">
		<input type="submit" value="View All Customers">
	</form>
	<br/>
	<form method="get" action="viewEmployees.jsp">
		<input type="submit" value="View All Employees">
	</form>

</body>
</html>
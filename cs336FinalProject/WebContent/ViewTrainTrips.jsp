<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Train Trip Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>

	<%
	
		String triptodelete = request.getParameter("tripid");
		
		if(triptodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				String command2 = "DELETE FROM Trips WHERE + tripid='" + triptodelete + "'";
				statement.executeUpdate(command2);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	
TRAIN SCHEDULE 
<br/>
<br/>

FUNCTIONS
<br/>
Edit Trip: Change information on a specific trip.
<br/>
Delete Trip: Will delete a specific trip. 
<br/>
Add Trip: Add information for a new trip.
<br/>
<br/>

	<table cellpadding="3px" border="1px" solid black>
		<tr>
			<th>Train ID</th>
			<th>Route Name</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Date/Time</th>
			<th>Arrival Date/Time</th>
			<th># Available Seats</th>
			<th>One Way Economy Fare</th>
			<th>One Way Business Fare</th>
			<th>One Way First Class Fare</th>
			<th>Age/Disability Discount</th>
			<th>Round Trip Discount</th>
			<th>Weekly Discount</th>
			<th>Monthly Discount</th>
			<th>Edit Trip</th>
			<th>Delete Trip</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select ts.trainid, ts.cars, ts.seats, t.availableseats, r.routeid, r.name, s.stationid, s.stationname, s.city, s.state,"+
						" s2.stationid, s2.stationname, s2.city, s2.state, t.tripid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime, t.economyfare,"+
						" t.businessfare, t.firstfare, t.ecddiscount, t.weekdiscount, t.monthdiscount, t.roundtripdiscount "+
						" from Trips t, Trains ts, Stations s, Stations s2, Routes r"+
						" where t.routeid=r.routeid"+
						" and t.trainid=ts.trainid"+
						" and t.sourcestationid=s.stationid"+
						" and t.destinationstationid=s2.stationid order by ts.trainid asc");
				
				while(results.next()){
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("ts.trainid") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("r.name") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("s.stationname") +" "+ results.getObject("s.city")+", "+results.getObject("s.state")+"</td>" +
							"<td style='text-align:center'>" + results.getObject("s2.stationname") +" "+ results.getObject("s2.city")+", "+results.getObject("s2.state")+"</td>" +
							"<td style='text-align:center'>" + results.getObject("starttime") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("endtime") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("t.availableseats") + "</td>" +
							"<td style='text-align:center'>" + "$"+ results.getObject("t.economyfare") + "</td>" +
							"<td style='text-align:center'>" + "$"+  results.getObject("t.businessfare") + "</td>" +
							"<td style='text-align:center'>" + "$"+ results.getObject("t.firstfare") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("t.ecddiscount") + "%"+ "</td>" +
							"<td style='text-align:center'>" + results.getObject("t.roundtripdiscount") + "%"+  "</td>" +
							"<td style='text-align:center'>" + results.getObject("t.weekdiscount") + "%"+  "</td>" +
							"<td style='text-align:center'>" + results.getObject("t.monthdiscount") + "%"+  "</td>" +
								  "<td><form method='get' action='EditTrainTrip.jsp'>" +
								  "<input type='hidden' name='tripid' value='" + results.getObject("t.tripid") + "'>" +
								  "<input type='submit' value='edit'></form></td>" +
								  "<td><form method='get' action='ViewTrainTrips.jsp'>" +
								  "<input type='hidden' name='tripid' value='" + results.getObject("t.tripid") + "'>" +
								  "<input type='submit' value='delete'></form></td>" +
								  "</tr>";
					out.print(html);
				}
				
				db.closeConnection(connection);
				
			} catch(Exception e){
				out.print(e);
			}
		%>
		
	<br/>
	</table>
		<br/>
	<form method="get" action="AddTrainTrip.jsp">
		<input type="submit" value="Add New Trip">
	</form>
	<br/>
	<form method="post" action="ViewTrainScheduleAttributes.jsp">
		<input type="submit" value="Return to Schedule Attributes Page">
	</form>

</body>
</html>
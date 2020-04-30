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
			
			String stationid = request.getParameter("stationname") == null ? "" : request.getParameter("stationname");
			String getstationname=("select * from Stations where stationid='"+stationid+"'");
			Statement sqlStatement7 = connection.createStatement();
			ResultSet getstationname1 = sqlStatement7.executeQuery(getstationname);
			getstationname1.first();
			
			String stationname=getstationname1.getString("StationName") +": " + getstationname1.getString("city") + ", "+ getstationname1.getString("state"); 
			
			String title="TRAIN SCHEDULE AT: "+ stationname+"";
			out.println(title);
	%>
	<br/>
	<table cellpadding="10px" cellspacing="3px">
		<tr>
			<th>Origin</th>
			<th>Destination</th>
			<th>Transit Line and Train Number</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Travel Time (min)</th>
			<th>Available Number of Seats</th>
			<th>Fare</th>
		</tr>
	<br/>
	<%
	//has origin as station
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText = "select distinct s2.*, t.availableseats, t.economyfare, t.businessfare, t.firstfare, s.*, r.name, t.trainid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime, TIMESTAMPDIFF(minute, t.starttime,t.endtime) from Stations s, Stations s2, Trips t, Routes r where s.stationid=t.destinationstationid and s2.stationid=t.sourcestationid and t.routeid=r.routeid and s2.stationid='"+stationid+"'";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			
			while(result.next()){
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + result.getString("s2.StationName") +": " + result.getString("s2.city") + ", "+ result.getString("s2.state") + "</td>"
							  +"<td style='text-align:center'>" + result.getString("s.StationName") +": " + result.getString("s.city") + ", "+ result.getString("s.state") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Name") + " #"+result.getObject("Trainid") +"</td>"
							  +"<td style='text-align:center'>" + result.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("t.availableseats") + "</td>"
							  +"<td style='text-align:center'>" + "E: $"+result.getObject("t.economyfare") + " B: $"+result.getObject("t.businessfare") + " F: $"+ result.getObject("t.firstfare") + "</td>"
							  ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are departing from this station. ");
			}
		
			
							
		} catch(Exception e){
			out.print(e);
		}
	%>
	<%
	//has destination as station
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText = "select distinct s2.*, s.*, r.name, t.trainid, t.StartTime, t.EndTime, TIMESTAMPDIFF(minute, t.starttime,t.endtime) from Stations s, Stations s2, Trips t, Routes r where s.stationid=t.destinationstationid and s2.stationid=t.sourcestationid and t.routeid=r.routeid and s.stationid='"+stationid+"'";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			
			while(result.next()){
				String html = "<tr>" + 
						   "<td style='text-align:center'>" + result.getString("s2.StationName") +": " + result.getString("s2.city") + ", "+ result.getString("s2.state") + "</td>"
							+"<td style='text-align:center'>" + result.getString("s.StationName") +": " + result.getString("s.city") + ", "+ result.getString("s.state") + "</td>"
							+"<td style='text-align:center'>" + result.getObject("Name") + " #"+result.getObject("Trainid") +"</td>"
							  +"<td style='text-align:center'>" + result.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"
							  ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are arriving to this station.");
			}
		
			db.closeConnection(connection);
							
		} catch(Exception e){
			out.print(e);
		}
	%>
	
	<table>
	<form method="post" action="findStation.jsp">
		<input type="submit" value="Do a New Search">
	</form>
	

</body>
</html>
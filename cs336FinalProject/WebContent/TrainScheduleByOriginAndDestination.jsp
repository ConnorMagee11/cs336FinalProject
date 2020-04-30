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
			
			String originid = request.getParameter("origin") == null ? "" : request.getParameter("origin");
			String getstationname=("select * from Stations where stationid='"+originid+"'");
			Statement sqlStatement7 = connection.createStatement();
			ResultSet getstationname1 = sqlStatement7.executeQuery(getstationname);
			getstationname1.first();
			
			String originname=getstationname1.getString("StationName") +": " + getstationname1.getString("city") + ", "+ getstationname1.getString("state");
			
			String destinationid = request.getParameter("destination") == null ? "" : request.getParameter("destination");
			String getstationname3=("select * from Stations where stationid='"+destinationid+"'");
			Statement sqlStatement8 = connection.createStatement();
			ResultSet getstationname4 = sqlStatement8.executeQuery(getstationname3);
			getstationname4.first();
			
			String destinationname=getstationname4.getString("StationName") +": " + getstationname4.getString("city") + ", "+ getstationname4.getString("state");
			
			
			
			String title="Train Scheule from "+ originname+" to "+destinationname;
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
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText= "select distinct s.*, s2.*, r.name, t.availableseats, t.economyfare, t.businessfare, t.firstfare, t.trainid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime, TIMESTAMPDIFF(minute, t.starttime,t.endtime) from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and t.routeid=r.routeid and s2.stationid='"+originid+"' and s.stationid='"+destinationid+"'";
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
						  +"<td style='text-align:center'>" + "E:$"+result.getObject("t.economyfare") + " B:$"+result.getObject("t.businessfare") + " F:$"+ result.getObject("t.firstfare") + "</td>"
							 ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are traveling between these two stations. ");
			}
		
			db.closeConnection(connection);
							
		} catch(Exception e){
			out.print(e);
		}
	%>

	<table>
	<form method="post" action="selectOriginandDestination.jsp">
		<input type="submit" value="Do a New Search">
	</form>
	

</body>
</html>
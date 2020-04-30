<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Reservation - Round Trip</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method='post' action="EditReservationInfo.jsp">
				<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
				<input type='hidden' name="tripid" value=<%=request.getParameter("tripid")%>>
				<input type="submit" value="Return to Customer's Reservation Details">
	</form>
	<br/>
EDIT RESERVATION-ROUND TRIP
<br/>
<br/>
<br/>

	<form method="post" action="EditRoundTrip.jsp?viewschedule=1">
	<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
	<input type='hidden' name="tripid" value=<%=request.getParameter("tripid")%>>
	<input type='hidden' name="tripid2" value=<%=request.getParameter("tripid2")%>>
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		
		String fail = request.getParameter("odd") == null ? "" : request.getParameter("odd");
		if(fail.equals("1")) 
		out.print("<span color='red'>An error occured. Please enter all fields correctly.</span><br/>");
			
		%>
		
			<u>Current Round Trip Reservation Details</u>
			
			<table cellpadding="3px" border="1px" solid black>
			<tr>
			<br/>
			<br/>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Train Line and Number</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Class</th>
			<th>Seat Number</th>
			</tr>	
		<% 
			Statement statement1 = connection.createStatement();
			ResultSet oneway=statement1.executeQuery("select r.reservationid, date_format(r.reservationdate,'%H:%i %p %m/%d/%Y') as rtime, ro.name, t.trainid, "+
				"s.stationname, s.city, s.state, s2.stationname, s2.city, s2.state, t.starttime, t.endtime, t.routeid, ts.seats, t.tripid, "+ 
				"date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, m.class, m.seatid, r.total_fare "+
				"from Reservations r, Trips t, Stations s, Stations s2, Routes ro, Multivalue_Reservations_Trips m, Trains ts "+
				"where r.reservationid=m.reservationid "+
				"and m.tripid=t.tripid and t.routeid=ro.routeid and t.trainid=ts.trainid "+
				"and t.sourcestationid=s.stationid and t.destinationstationid=s2.stationid "+
				"and r.reservationid='"+request.getParameter("reservationid")+"' order by starttime asc");
			
			
			while(oneway.next()){
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Name") + " "+ oneway.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Seatid") + "</td>";
				out.println(html);
			}
		
		
		%>

		<table>
		<br/>
		FIND NEW TRIP BASED ON
		<br/>
	
				Origin Station: 
	
		<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText=("select * from Stations");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
	
		<select name="origin" size=1>
		<%
		while(result.next())
		{
			String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
			%>
			<option value="<%=result.getString("StationID") %>"><%=train %></option>
		
		<%
		}
		%>
		</select>

		<%		

		} catch(Exception e){
			out.print(e);
		}
	%>
		
	<br/>
		
		Destination Station: 
		
		<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText=("select * from Stations");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
		<select name="destination" size=1>
		<%
		while(result.next())
		{
		String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
		%>
		<option value="<%=result.getString("StationID") %>"><%=train %></option>
		<%
		}
		%>
		</select>
		
		

		<%		
		} catch(Exception e){
			out.print(e);
		}
	%>
		<br/>
		
		
		Date of Departure:
		<input type="date" id="start" name="triptime1"
       		min="2020-01-01" max="2021-12-31">
		<br/>
		
		Date of Return:
		<input type="date" id="start" name="triptime2"
       		min="2020-01-01" max="2021-12-31">
		<br/>
		
		
		<input type="submit" value="Find Schedule">
		</form>
		<br/><br/>
		
		Note: changes will only be saved if you select BOTH an arrival and departure trip.
		<br/>
		<table>
		<br/>
		<%
		
		String view = request.getParameter("viewschedule") == null ? "" : request.getParameter("viewschedule");
		
		if(view.equals("1"))
		{
			String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
			String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
			String date=request.getParameter("triptime1") == null ? "" : request.getParameter("triptime1");
			String date2=request.getParameter("triptime2") == null ? "" : request.getParameter("triptime2");
			
			Statement one = connection.createStatement();
			ResultSet getorigininfo = one.executeQuery("Select * from Stations where stationid='" + origin+"'");
			getorigininfo.first();
			
			String originname=getorigininfo.getString("StationName") +": " + getorigininfo.getString("city") + ", "+ getorigininfo.getString("state");
			
			Statement two = connection.createStatement();
			ResultSet getdestinationinfo = two.executeQuery("Select * from Stations where stationid='" + destination+"'");
			getdestinationinfo.first();
			
			String destinationname=getdestinationinfo.getString("StationName") +": " + getdestinationinfo.getString("city") + ", "+ getdestinationinfo.getString("state");
			
			
		
			String title="Train Trips from "+ originname+" to "+destinationname+" on "+date;
			out.println(title);	
			out.print("<br/>");
		
		%>
	<table cellpadding="3px" cellspacing="20px">
		<tr>
			<th>Line</th>
			<th>Train Number</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Travel Time (min)</th>
			<th>Economy Fare</th>
			<th>Business Fare</th>
			<th>Economy Fare</th>
			<th>Select Trip</th>
		</tr>
	<%
	
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText= "select distinct t.tripid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, r.name, t.trainid, date_format(t.starttime,'%H:%i %p %d/%m/%Y') as starttime, date_format(t.endtime,'%H:%i %p %d/%m/%Y') as endtime, TIMESTAMPDIFF(minute, t.starttime,t.endtime), t.economyfare, t.businessfare, t.firstfare from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
			+"t.routeid=r.routeid and s2.stationid='"+origin+"' and s.stationid='"+destination+"' and date(t.starttime)='"+date+"' and t.availableseats>0";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			%>
			
				<form method='post' action="EditReservationInfo.jsp?changetrip=2">
				<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
				<input type='hidden' name="tripid1" value=<%=request.getParameter("tripid")%>>
				<input type='hidden' name="tripid2" value=<%=request.getParameter("tripid2")%>>

			<% 
			while(result.next()){
				String html = "<tr>" + 
						"<td style='text-align:center'>" + result.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("economyfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("businessfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("firstfare") + "</td>"+
							  "<td style='text-align:center'><input type='radio' name='tripid1new' value='" + result.getObject("tripid")+"'></td>"
							 ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are traveling between these two stations on the date of travel.");
			}
			
			out.println("<table>");
			title="Train Trips from "+ destinationname+" to "+originname+" on "+date2;
			out.println(title);	
			
			%>
			
				<br/>
	
	
	<table cellpadding="3px" cellspacing="20px">
		<tr>
			<th>Line</th>
			<th>Train Number</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Travel Time (min)</th>
			<th>Economy Fare</th>
			<th>Business Fare</th>
			<th>Economy Fare</th>
			<th>Select Trip</th>
		</tr>
			
			
			<% 
			
			Statement sqlStatement2 = connection.createStatement();
			
			String sqlText2= "select distinct t.tripid, r.name, t.trainid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, TIMESTAMPDIFF(minute, t.starttime,t.endtime), t.economyfare, t.businessfare, t.firstfare from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
			+"t.routeid=r.routeid and s2.stationid='"+destination+"' and s.stationid='"+origin+"' and date(t.starttime)='"+date2+"' and t.availableseats>0";
			ResultSet result2 = sqlStatement2.executeQuery(sqlText2);
			
			while(result2.next()){
				String h = "<tr>" + 
						"<td style='text-align:center'>" + result2.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("economyfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("businessfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("firstfare") + "</td>"+
							  "<td style='text-align:center'><input type='radio' name='tripid2new' value='" + result2.getObject("tripid")+"'></td>"
							 ;
				out.println(h);
			}
		
				
			if (!result2.first())
			{
				out.println("No trains are traveling between these two stations on the date of return.");
			}
			
			
			if (result.first() && result2.first())
			{
				%>
				<table>
				<input type="submit" value="Save Changes">
				</form>
				<% 
			}
			
			
				db.closeConnection(connection);
								
			} catch(Exception e){
				out.print(e);
			}
		}
		%>
		
	<br/>
	<br/>


</body>
</html>
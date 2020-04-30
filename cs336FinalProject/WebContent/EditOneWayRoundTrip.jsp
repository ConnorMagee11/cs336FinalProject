<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Reservation - One-Way Trip</title>
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
EDIT RESERVATION-ONE WAY TRIP
<br/>
<br/>
<br/>

	<form method="post" action="EditOneWayRoundTrip.jsp?viewschedule=1">
	<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
	<input type='hidden' name="tripid" value=<%=request.getParameter("tripid")%>>
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		
		String fail = request.getParameter("odd") == null ? "" : request.getParameter("odd");
		if(fail.equals("1")) 
		out.print("<span color='red'>An error occured. Please enter all fields correctly.</span><br/>");
			
		%>
		
			<u>Current One-Way Reservation Details</u>
			
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
			<th>Total Fare</th>
			<th>Customer Representative ID (If Helped)</th>
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
					"and r.reservationid='"+request.getParameter("reservationid")+"'");
			
			Statement statement2 = connection.createStatement();
			ResultSet csrid=statement2.executeQuery("select e.csrid from Employees e, Reservations r where r.csrssn=e.ssn "+
					"and r.reservationid='"+request.getParameter("reservationid")+"'");
			csrid.first();
			
			
			while(oneway.next())
			{
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Name") + " "+ oneway.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Seatid") + "</td>"
							  +"<td style='text-align:center'>" + "$" +oneway.getObject("Total_Fare") + "</td>"
							  +"<td style='text-align:center'>" + csrid.getObject("csrid") + "</td>";
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
			
			String sqlText=("select StationName from Stations");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
	
		<select name="origin" size=1>
	
		
		
		<%
		
		
		while(result.next())
		{
		String name = result.getString("StationName"); 
		%>
		<option value="<%=name %>"><%=name %></option>
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
			
			String sqlText=("select StationName from Stations");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
		<select name="destination" size=1>
		<%
		while(result.next())
		{
		String train = result.getString("StationName"); 
		%>
		<option value="<%=train %>"><%=train %></option>
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
		
		
		Date of Travel:
		<input type="date" id="start" name="triptime"
       		min="2020-01-01" max="2020-12-31">
		<br/>
		
		
		<input type="submit" value="Find Schedule">
		</form>
		<br/><br/>
		
		<table>
		<%
		
		String view = request.getParameter("viewschedule") == null ? "" : request.getParameter("viewschedule");
		
		if(view.equals("1"))
		{
			String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
			String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
			String date=request.getParameter("triptime") == null ? "" : request.getParameter("triptime");
			
		
			String title="One Way Train Trips from "+ origin+" to "+destination+" on "+date;
			out.println(title);		

		
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
				
				String sqlText= "select distinct t.tripid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, r.name, t.economyfare, t.businessfare, t.firstfare, t.trainid, t.StartTime, t.EndTime, TIMESTAMPDIFF(minute, t.starttime,t.endtime) from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
				+"t.routeid=r.routeid and s2.stationname='"+origin+"' and s.stationname='"+destination+"' and date(t.starttime)='"+date+"' and t.availableseats>0";
				ResultSet result = sqlStatement.executeQuery(sqlText);
				%>
				
				<form method='post' action="EditReservationInfo.jsp?changetrip=1">
				<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
				<input type='hidden' name="tripid" value=<%=request.getParameter("tripid")%>>
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
								  "<td style='text-align:center'><input type='radio' name='tripidnew' value='" + result.getObject("tripid")+"'></td>"
								 ;
					out.println(html);
				}
					
				if (!result.first())
				{
					out.println("No trains are traveling between these two stations on that day. ");
				}
				else
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
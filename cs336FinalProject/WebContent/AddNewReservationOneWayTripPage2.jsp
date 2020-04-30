<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - One-Way Trip</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
ADD NEW RESERVATION-ONE WAY TRIP
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

		<form method="post" action="AddNewReservationOneWayTrip.jsp">
		<input type="submit" value="Do a New Search">
		</form>
		<br/>


	<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		
			String date=request.getParameter("triptime") == null ? "" : request.getParameter("triptime");
			String odd=request.getParameter("odd") == null ? "" : request.getParameter("odd");
			
			
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

			
			if (originid.equals("") || destinationid.equals("") || date.equals(""))
			{
				response.sendRedirect("AddNewReservationOneWayTrip.jsp?odd=1");
			}
			
			
			String title="One Way Train Trips from "+ originname+" to "+destinationname;
			out.println(title);
			if(odd.equals("2"))
			{
				out.print("<br/>");
				out.print("*Please select a trip.");
				//out.print("<br/>");
			}
	
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
	<br/>
	<%
	
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText= "select distinct t.tripid, t.availableseats, t.economyfare, t.businessfare, t.firstfare, r.name, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, t.trainid, t.StartTime, t.EndTime, TIMESTAMPDIFF(minute, t.starttime,t.endtime) from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
			+"t.routeid=r.routeid and s2.stationid='"+originid+"' and s.stationid='"+destinationid+"' and date(t.starttime)='"+date+"' and t.availableseats>0";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			%>
			
			<form method='get' action='AddNewReservationOneWayCheckOut.jsp'>
			<input type='hidden' name="date" value=<%=date%>>
			<input type='hidden' name="originid" value=<%=originid%>>
			<input type='hidden' name="destinationid" value=<%=destinationid%>>

			<% 
			while(result.next()){

				String html = "<tr>" + 
						"<td style='text-align:center'>" + result.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"+
							 "<td style='text-align:center'>" + "$"+result.getObject("economyfare") + "</td>"+
				    		  "<td style='text-align:center'>" + "$"+result.getObject("businessfare") + "</td>"+
							  "<td style='text-align:center'>" + "$"+result.getObject("firstfare") + "</td>"+
							  "<td style='text-align:center'><input type='radio' name='tripid' value='" + result.getObject("tripid")+"'></td>"
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
				<input type="submit" value="Proceed to Check Out">
				<%
			}
		
			db.closeConnection(connection);
							
		} catch(Exception e){
			out.print(e);
		}
	%>
		
		</form>
	
	<br/>
	<br/>


</body>
</html>
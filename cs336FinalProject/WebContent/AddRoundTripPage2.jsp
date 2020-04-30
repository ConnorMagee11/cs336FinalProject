<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - Round Trip</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
ADD NEW RESERVATION-ROUND TRIP
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
<form method="post" action="AddNewRoundTrip.jsp">
		<input type="submit" value="Do a New Search">
		</form>
		<br/>

	<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		
		String odd=request.getParameter("odd") == null ? "" : request.getParameter("odd");

			
			String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
			String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
			String date1=request.getParameter("triptime1") == null ? "" : request.getParameter("triptime1");
			String date2=request.getParameter("triptime2") == null ? "" : request.getParameter("triptime2");
			
			if (origin.equals("") || destination.equals("") || date1.equals("") || date2.equals(""))
			{
				response.sendRedirect("AddNewRoundTrip.jsp?odd=1");
			}
			
			Statement one = connection.createStatement();
			ResultSet getorigininfo = one.executeQuery("Select * from Stations where stationid='" + origin+"'");
			getorigininfo.first();
			
			String originname=getorigininfo.getString("StationName") +": " + getorigininfo.getString("city") + ", "+ getorigininfo.getString("state");
			
			Statement two = connection.createStatement();
			ResultSet getdestinationinfo = two.executeQuery("Select * from Stations where stationid='" + destination+"'");
			getdestinationinfo.first();
			
			String destinationname=getdestinationinfo.getString("StationName") +": " + getdestinationinfo.getString("city") + ", "+ getdestinationinfo.getString("state");
			
			String title="Trips from "+ originname+" to "+destinationname+"";
			out.println(title);
			if(odd.equals("2"))
			{
				out.print("<br/>");
				out.print("*Please select a departure and arrival trip.");
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
	<%
	
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText= "select distinct t.tripid, r.name, t.trainid, date_format(t.starttime,'%H:%i %p %d/%m/%Y') as starttime, date_format(t.endtime,'%H:%i %p %d/%m/%Y') as endtime, TIMESTAMPDIFF(minute, t.starttime,t.endtime), t.economyfare, t.businessfare, t.firstfare from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
			+"t.routeid=r.routeid and s2.stationid='"+origin+"' and s.stationid='"+destination+"' and date(t.starttime)='"+date1+"' and t.availableseats>0";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			%>
			
			<form method='get' action='AddRoundTripCheckOut.jsp'>
			<input type='hidden' name="date1" value=<%=date1%>>
			<input type='hidden' name="date2" value=<%=date2%>>
			<input type='hidden' name="originid" value=<%=origin%>>
			<input type='hidden' name="destinationid" value=<%=destination%>>

			<% 
			while(result.next()){
				String html = "<tr>" + 
						"<td style='text-align:center'>" + result.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("economyfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("businessfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result.getObject("firstfare") + "</td>"+
							  "<td style='text-align:center'><input type='radio' name='tripid1' value='" + result.getObject("tripid")+"'></td>"
							 ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are traveling between these two stations on the date of travel.");
			}
			
			out.println("<table>");
			title="Trips from "+ destinationname+" to "+originname+":";
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
			
			String sqlText2= "select distinct t.tripid, r.name, t.trainid, date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime, TIMESTAMPDIFF(minute, t.starttime,t.endtime), t.economyfare, t.businessfare, t.firstfare from Stations s, Stations s2, Trips t, Routes r where s2.stationid=t.sourcestationid and s.stationid=t.destinationstationid and " 
			+"t.routeid=r.routeid and s2.stationid='"+destination+"' and s.stationid='"+origin+"' and date(t.starttime)='"+date2+"' and t.availableseats>0";
			ResultSet result2 = sqlStatement2.executeQuery(sqlText2);
			
			while(result2.next()){
				String h = "<tr>" + 
						"<td style='text-align:center'>" + result2.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("economyfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("businessfare") + "</td>"+
							  "<td style='text-align:center'>" +"$"+ result2.getObject("firstfare") + "</td>"+
							  "<td style='text-align:center'><input type='radio' name='tripid2' value='" + result2.getObject("tripid")+"'></td>"
							 ;
				out.println(h);
			}
		
				
			if (!result2.first())
			{
				out.println("No trains are traveling between these two stations on the date of return.");
			}

			
			
			
			
			
			
			
		
			db.closeConnection(connection);
							
		} catch(Exception e){
			out.print(e);
		}
	%>
		<table>
		<input type="submit" value="Proceed to Check Out">
		</form>
	

</body>
</html>
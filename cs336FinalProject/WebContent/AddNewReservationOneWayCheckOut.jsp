<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - One-Way Check Out</title>
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
2. Select the type of trip
<br/>
<b>3. Proceed to checkout</b>
<br/>
Done!
<br/>
<br/>
<br/>
You have selected:


	<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			
			String tripid = request.getParameter("tripid") == null ? "" : request.getParameter("tripid");
			String date = request.getParameter("date") == null ? "" : request.getParameter("date");
			String originid = request.getParameter("originid") == null ? "" : request.getParameter("originid");
			String destinationid = request.getParameter("destinationid") == null ? "" : request.getParameter("destinationid");

			
			if(tripid.equals(""))
			{
				response.sendRedirect("AddNewReservationOneWayTripPage2.jsp?triptime="+date+"&origin="+originid+"&destination="+destinationid+"&odd=2");
			}
			
			String change="AddNewReservationOneWayTripPage2.jsp?triptime="+date+"&origin="+originid+"&destination="+destinationid;
			
	%>
	<br/>
	<table cellpadding="3px" cellspacing="3px" border="1px" solid black>
		<tr>
			<th>Line</th>
			<th>Train Number</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Travel Time (min)</th>
			<th>Economy Fare</th>
			<th>Business Fare</th>
			<th>First Class Fare</th>
		</tr>
	<br/>
	
	<%
	
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime), date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1 "+
					"from Trips t, Routes r, Stations s, Stations s2 "+
					"where t.routeid=r.routeid "+
					"and t.sourcestationid=s.stationid "+
					"and t.destinationstationid=s2.stationid "+
					"and t.tripid='"+tripid+"'";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			%>
			
			
			
			<% 
			if(result.next()){
				String html = "<tr>" + 
						"<td style='text-align:center'>" + result.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("s.stationname") +" "+ result.getObject("s.city")+", "+result.getObject("s.state")+"</td>" 
							  +"<td style='text-align:center'>" + result.getObject("s2.stationname") +" "+ result.getObject("s2.city")+", "+result.getObject("s2.state")+"</td>" 
							  +"<td style='text-align:center'>" + result.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"
							  +"<td style='text-align:center'>" +"$"+ result.getObject("economyfare") + "</td>"
							  +"<td style='text-align:center'>"+"$"+ result.getObject("businessfare") + "</td>"
							  +"<td style='text-align:center'>" +"$"+ result.getObject("firstfare") + "</td>"
							 ;
				out.println(html);
			}
				
			if (!result.first())
			{
				out.println("No trains are traveling between these two stations. ");
			}
		
			
							
		} catch(Exception e){
			out.print(e);
		}
	%>
	
		<table>
		<br/>
		
	
	
		<form method="post" action=<%=change%>>
			<input type="submit" value="Change Selection">
		</form>
		
		<br/>
		<br/>
	<form method="post" action="OneWayReservationFinalCost.jsp" >	
	<input type="hidden" name="tripid" value=<%=request.getParameter("tripid") %>>
Select the class of train ticket the customer wants:
<br/>
		<select name="classtype" size=1>
		 	<option value="economy">Economy</option>
		 	<option value="business">Business</option>
		 	<option value="first">First</option>
		</select>
<br/>
<br/>
Is the customer eligible for a senior/child/disability discount?
<br/>
	<select name="discount" size=1>
		 	<option value="No">No</option>
		 	<option value="Yes">Yes</option>
	</select>
		
<br/>
<br/>	
We charge a 10% booking fee.
<br/>
<br/>
		<input type="submit" value="View Total">	
		
		</form>
<br/>
<br/>
<table>


<%db.closeConnection(connection); %>

<br/>
<br/>


</body>
</html>
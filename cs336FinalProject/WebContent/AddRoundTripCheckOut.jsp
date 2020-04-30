<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - Round Trip Check Out</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>
ADD NEW RESERVATION-ROUND TRIP
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
			
			String tripid1 = request.getParameter("tripid1") == null ? "" : request.getParameter("tripid1");
			String tripid2 = request.getParameter("tripid2") == null ? "" : request.getParameter("tripid2");
			//String tripid ="1";
			
			if (tripid1.equals("") || tripid2.equals(""))
			{
				response.sendRedirect("AddRoundTripPage2.jsp?triptime1="+request.getParameter("date1")+"&triptime2="+request.getParameter("date2")+"&origin="+request.getParameter("originid")+"&destination="+request.getParameter("destinationid")+"&odd=2");

			}
			
			
			
			
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
			
			String sqlText= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime), date_format(t.starttime,'%H:%i %p %d/%m/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %d/%m/%Y') as endtime1 "+
					"from Trips t, Routes r, Stations s, Stations s2 "+
					"where t.routeid=r.routeid "+
					"and t.sourcestationid=s.stationid "+
					"and t.destinationstationid=s2.stationid "+
					"and t.tripid='"+tripid1+"'";
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
							  +"<td style='text-align:center'>" + "$"+ result.getObject("economyfare") + "</td>"
							  +"<td style='text-align:center'>" + "$"+ result.getObject("businessfare") + "</td>"
							  +"<td style='text-align:center'>" + "$"+ result.getObject("firstfare") + "</td>"
							 ;
				out.println(html);
			}
								
		} catch(Exception e){
			out.print(e);
		}
	%>
		<table>
		<br/>
		
	<form method="post" action="AddRoundTripFinalCost.jsp" >	
	<input type="hidden" name="tripid1" value=<%=request.getParameter("tripid1") %>>
	<input type="hidden" name="tripid2" value=<%=request.getParameter("tripid2") %>>
	
	
	Select the class of train ticket the customer wants for the departure trip:
	<br/>
		<select name="classtype" size=1>
		 	<option value="economy">Economy</option>
		 	<option value="business">Business</option>
		 	<option value="first">First</option>
		</select>
		
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

			Statement sqlStatement2 = connection.createStatement();
			
			String sqlText= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime), date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1 "+
					"from Trips t, Routes r, Stations s, Stations s2 "+
					"where t.routeid=r.routeid "+
					"and t.sourcestationid=s.stationid "+
					"and t.destinationstationid=s2.stationid "+
					"and t.tripid='"+tripid2+"'";
			ResultSet result2 = sqlStatement2.executeQuery(sqlText);
			%>
			
			
			
			<% 
			if(result2.next()){
				String html = "<tr>" + 
						"<td style='text-align:center'>" + result2.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("s.stationname") +" "+ result2.getObject("s.city")+", "+result2.getObject("s.state")+"</td>" 
							  +"<td style='text-align:center'>" + result2.getObject("s2.stationname") +" "+ result2.getObject("s2.city")+", "+result2.getObject("s2.state")+"</td>" 
							  +"<td style='text-align:center'>" + result2.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result2.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"
							  +"<td style='text-align:center'>" + "$"+ result2.getObject("economyfare") + "</td>"
							  +"<td style='text-align:center'>" + "$"+ result2.getObject("businessfare") + "</td>"
							  +"<td style='text-align:center'>" + "$"+ result2.getObject("firstfare") + "</td>"
							 ;
				out.println(html);
			}
								
		} catch(Exception e){
			out.print(e);
		}
	%>		
		
	<table>
	<br/>
	Select the class of train ticket the customer wants on the return trip:
	<br/>
		<select name="classtype2" size=1>
		 	<option value="economy">Economy</option>
		 	<option value="business">Business</option>
		 	<option value="first">First</option>
		</select>
		
	<br/>
		
		
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
	NOTE: The round trip discount will be added at the final check out. 
	<br/>	
	
	<%db.closeConnection(connection); %>
		<input type="submit" value="View Total">	
		
		</form>
		
		
	<br/>
	<br/>
	<table>


	

<br/>
<br/>


</body>
</html>
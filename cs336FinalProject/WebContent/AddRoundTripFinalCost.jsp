<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - Round Trip Reservation Final Cost</title>
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
			//TESTING
			//String tripid1 ="1";
			//String tripid2="3";
			
			
			
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
					"and t.tripid in "+
					"(select tripid from Trips where tripid='"+tripid1+"' "+
					"union select tripid from Trips where tripid='"+tripid2+"')";
			ResultSet result = sqlStatement.executeQuery(sqlText);
			%>
			
			
			
			<% 
			while(result.next()){
				String html = "<tr>" + 
						"<td style='text-align:center'>" + result.getObject("Name") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("s.stationname") +" "+ result.getObject("s.city")+", "+result.getObject("s.state")+"</td>" 
							  +"<td style='text-align:center'>" + result.getObject("s2.stationname") +" "+ result.getObject("s2.city")+", "+result.getObject("s2.state")+"</td>" 
							  +"<td style='text-align:center'>" + result.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + result.getObject("TIMESTAMPDIFF(minute, t.starttime,t.endtime)") + "</td>"
							  +"<td style='text-align:center'>" + "$"+result.getObject("economyfare") + "</td>"
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
		


<%	



	String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
	String classtype2 = request.getParameter("classtype2") == null ? "" : request.getParameter("classtype2");
	String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
	
	Statement sqlStatement = connection.createStatement();
	
	String text= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime) "+
			"from Trips t, Routes r, Stations s, Stations s2 "+
			"where t.routeid=r.routeid "+
			"and t.sourcestationid=s.stationid "+
			"and t.destinationstationid=s2.stationid "+
			"and t.tripid='"+tripid1+"'";
	ResultSet result2 = sqlStatement.executeQuery(text);
	result2.first();

	double discountnum=result2.getFloat("ecddiscount");
	double roundtrip=result2.getFloat("roundtripdiscount");
	double total=0;
	
	if(classtype.equals("economy"))
	{
		total=result2.getFloat("economyfare");
	}
	else if (classtype.equals("business"))
	{
		total=result2.getFloat("businessfare");
	}
	else if (classtype.equals("first"))
	{
		total=result2.getFloat("firstfare");
	}

	
	
	Statement sqlStatement1 = connection.createStatement();
	
	String text1= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime) "+
			"from Trips t, Routes r, Stations s, Stations s2 "+
			"where t.routeid=r.routeid "+
			"and t.sourcestationid=s.stationid "+
			"and t.destinationstationid=s2.stationid "+
			"and t.tripid='"+tripid2+"'";
	ResultSet result3 = sqlStatement1.executeQuery(text1);
	result3.first();
	double discountnum1=result3.getFloat("ecddiscount");
	double roundtrip1=result3.getFloat("roundtripdiscount");
	
	if (discountnum>discountnum1)
	{
		discountnum=discountnum1;
	}
	
	if (roundtrip>roundtrip1)
	{
		roundtrip=roundtrip1;
	}
	
	
	if(classtype2.equals("economy"))
	{
		total+=result3.getFloat("economyfare");
	}
	else if (classtype2.equals("business"))
	{
		total+=result3.getFloat("businessfare");
	}
	else if (classtype2.equals("first"))
	{
		total+=result3.getFloat("firstfare");
	}
	
	StringBuilder sb1 = new StringBuilder();
	Formatter formatter1 = new Formatter(sb1);
	formatter1.format("%.2f", total);
	
	out.print("Total Cost of 2 Tickets: $"+formatter1.toString());
	out.print("<br/>");
	out.print("Round Trip Discount: "+roundtrip+"%");
	out.print("<br/>");
	
	total=total-(total*(roundtrip/100));
	
	
	
	StringBuilder sb2 = new StringBuilder();
	Formatter formatter2 = new Formatter(sb2);
	formatter2.format("%.2f", total);
	out.print("Total Cost After Round Trip Discount: $"+formatter2.toString());
	out.print("<br/>");
	
	double farepicked=total/2;
	total=total+(total*(.1));
	
	
	if (discount.equals("Yes"))
	{
		StringBuilder sb3 = new StringBuilder();
		Formatter formatter3 = new Formatter(sb3);
		formatter3.format("%.2f", total);
		out.print("Total Cost After 10% booking fee is: $"+formatter3.toString());
		out.print("<br/>");
		
		total=total-(total*(discountnum/100));
		StringBuilder sb = new StringBuilder();
		Formatter formatter = new Formatter(sb);
		formatter.format("%.2f", total); 
		out.print("Total Cost After "+discountnum+"% senior/child/disability discount is $"+formatter.toString());
		out.print("<br/>");
		out.print("<br/>");
		out.print("The customer will pay: $ "+formatter.toString());
	}
	else 
	{

		StringBuilder sb = new StringBuilder();
		Formatter formatter = new Formatter(sb);
		formatter.format("%.2f", total); 
		out.print("Total Cost After 10% booking fee is: $"+formatter.toString());
		out.print("<br/>");
		out.print("<br/>");
		out.print("The customer wll pay: $"+formatter.toString());
	}
	
	
	
%>

<%db.closeConnection(connection); %>

<br/>
<br/>
		<form method='get' action='RoundTripReservationSuccess.jsp'>
	<input type="hidden" name="tripid1" value=<%=tripid1%>>
	<input type="hidden" name="tripid2" value=<%=tripid2%>>
	<input type="hidden" name="classtype1" value=<%=classtype%>>
	<input type="hidden" name="classtype2" value=<%=classtype2%>>
	<input type="hidden" name="total" value=<%=total%>>
	<input type="hidden" name="fare" value=<%=farepicked%>>
	<input type="hidden" name="age_disability" value=<%=discount%>>
		<input type="submit" value="Click to Make Reservation">
		</form>
	

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add New Reservation - One-Way Reservation Final Cost</title>
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
			//String tripid ="1";
			
			
			
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
			
			String sqlText= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime),date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1 "+
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
							  +"<td style='text-align:center'>" +"$"+ result.getObject("businessfare") + "</td>"
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
		


<%	



	String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
	String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
	
	Statement sqlStatement = connection.createStatement();
	
	String text= "select t.*, r.name, s.*, s2.*, TIMESTAMPDIFF(minute, t.starttime,t.endtime) "+
			"from Trips t, Routes r, Stations s, Stations s2 "+
			"where t.routeid=r.routeid "+
			"and t.sourcestationid=s.stationid "+
			"and t.destinationstationid=s2.stationid "+
			"and t.tripid='"+tripid+"'";
	ResultSet result2 = sqlStatement.executeQuery(text);
	result2.first();

	String economy=result2.getString("economyfare");
	String business=result2.getString("businessfare");
	String first=result2.getString("firstfare");
	double discountnum=result2.getFloat("ecddiscount");
	double total=0;
	double fare=0;
	
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
	
	fare=total;
	
	StringBuilder sb1 = new StringBuilder();
	Formatter formatter1 = new Formatter(sb1);
	formatter1.format("%.2f", total);
	
	out.print("Total Cost of 1 Tickets: $"+formatter1.toString());
	out.print("<br/>");
	total=total+(total*(.1));////Added booking fee-10% 

	if (discount.equals("Yes"))
	{
		StringBuilder sb2 = new StringBuilder();
		Formatter formatter2 = new Formatter(sb2);
		formatter2.format("%.2f", total); 
		
		out.print("Total Cost After 10% Booking Fee is: $"+formatter2.toString());
		out.print("<br/>");
		
		total=total-(total*(discountnum/100));
		StringBuilder sb = new StringBuilder();
		Formatter formatter = new Formatter(sb);
		formatter.format("%.2f", total); 
		out.print("Total Cost After "+discountnum+"% senior/child/disability discount is $"+formatter.toString());
		out.print("<br/>");
		out.print("<br/>");
		out.print("The customer will pay: $"+formatter.toString());
	}
	else
	{StringBuilder sb = new StringBuilder();
	Formatter formatter = new Formatter(sb);
	formatter.format("%.2f", total); 
	
	out.print("Total Cost After 10% Booking Fee is: $"+formatter.toString());
	out.print("<br/>");
	out.print("<br/>");
	out.print("The customer will pay $"+formatter.toString());
		
	}

	

	
%>

<%db.closeConnection(connection); %>

<br/>
<br/>
		<form method='get' action='OneWayReservationSuccess.jsp'>
	<input type="hidden" name="tripid" value=<%=tripid%>>
	<input type="hidden" name="classtype" value=<%=request.getParameter("classtype") %>>
	<input type="hidden" name="total" value=<%=total%>>
	<input type="hidden" name="fare" value=<%=fare%>>
	<input type="hidden" name="age_disability" value=<%=discount%>>
		<input type="submit" value="Click to Make Reservation">
		</form>
	

</body>
</html>
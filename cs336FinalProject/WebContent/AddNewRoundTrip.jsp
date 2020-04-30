<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
<br/>

	<form method="post" action="AddRoundTripPage2.jsp">
	FIND SCHEDULE BASED ON
	<br/>
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			String fail = request.getParameter("odd") == null ? "" : request.getParameter("odd");
			if(fail.equals("1")) 
			out.print("<span color='red'>An error occured. Please enter all fields correctly.</span><br/>");
		%>
	
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
		db.closeConnection(connection);
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
	<br/>
	<br/>


</body>
</html>
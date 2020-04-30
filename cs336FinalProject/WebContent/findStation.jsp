<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Find Customer Reservations_Customer Representative View</title>
</head>
<body>
	<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>
	
	<form method="post" action="TrainScheduleByStation.jsp">
	FIND TRAIN SCHEDULE BY STATION
	<br/><br/>
	
	Select a station:
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		%>
	
	
		<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText=("select * from Stations");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
	
		<select name="stationname" size=1>
		<%
		while(result.next())
		{
			String name = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
		%>
		<option value="<%=result.getString("Stationid") %>"><%=name %></option>
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
		
		
		<br/>
		<input type="submit" value="Find Schedule">
	</form>
	<br/>
	<br/>
	



</body>
</html>
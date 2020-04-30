<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Station Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>

	<%
	
		String stationtodelete = request.getParameter("stationid");
		
		if(stationtodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				String command2 = "Delete from Stations where + stationid='" + stationtodelete + "'";
				
				statement.executeUpdate(command2);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	
STATION INFORMATION
<br/>
<br/>
FUNCTIONS
<br/>
Edit Station: Change information on a specific station.
<br/>
Delete Station: Will delete a specific train. NOTE: Deleting a train will delete all trips to and from that station.
<br/>
Add Station: Add information for a new station.
<br/>


	<table cellpadding="3px" border="1px" solid black>
		<tr>
			<th>Station ID</th>
			<th>Station Name</th>
			<th>City</th>
			<th>State</th>
			<th>Edit Station</th>
			<th>Delete Station</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select * from Stations order by stationid asc");
				
				while(results.next()){
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("stationid") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("stationname") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("city") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("state") + "</td>" +
							"<td style='text-align:center'><form method='get' action='EditStationInfo.jsp'>" +
							"<input type='hidden' name='stationid' value='" + results.getObject("stationid") + "'>" +
							"<input type='submit' value='edit'></form></td>" +
							"<td style='text-align:center'><form method='get' action='ViewStationInfo.jsp'>" +
							"<input type='hidden' name='stationid' value='" + results.getObject("stationid") + "'>" +
							"<input type='submit' value='delete'></form></td>" +
							"</tr>";
					out.print(html);
				}
				
				db.closeConnection(connection);
								
			} catch(Exception e){
				out.print(e);
			}
		%>
	<br/>
	</table>
		<br/>
	<form method="get" action="AddStationInfo.jsp">
		<input type="submit" value="Add New Station Info">
	</form>
<br/>
	<form method="post" action="ViewTrainScheduleAttributes.jsp">
		<input type="submit" value="Return to Schedule Attributes Page">
	</form>



</body>
</html>
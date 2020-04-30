<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Route Names</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<%
	
		String routetodelete = request.getParameter("routeid");
		
		if(routetodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				String command2 = "Delete from Routes where + routeid='" + routetodelete + "'";
				statement.executeUpdate(command2);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	
ROUTE NAMES
<br/>
<br/>
FUNCTIONS
<br/>
Edit Route Name: Change spelling of a route name.
<br/>
Delete Route Name: Delete a route name. NOTE: This will delete trains on this particular route.
<br/>
Add Route Name: Add a new route name. 
<br/>

	<table cellpadding="3px" border="1px" solid black>
		<tr>
			<th>Route Name</th>
			<th>Edit Route</th>
			<th>Delete Route</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select * from Routes order by name asc");
				
				while(results.next()){
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("name") + "</td>" +
							"<td style='text-align:center'><form method='get' action='EditRouteName.jsp'>" +
							"<input type='hidden' name='routeid' value='" + results.getObject("routeid") + "'>" +
							"<input type='submit' value='edit'></form></td>" +
							"<td style='text-align:center'><form method='get' action='ViewRouteName.jsp'>" +
							"<input type='hidden' name='routeid' value='" + results.getObject("routeid") + "'>" +
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
	<form method="get" action="AddNewRouteName.jsp">
		<input type="submit" value="Add New Route Name">
	</form>

<br/>
	<form method="post" action="ViewTrainScheduleAttributes.jsp">
		<input type="submit" value="Return to Schedule Attributes Page">
	</form>


</body>
</html>
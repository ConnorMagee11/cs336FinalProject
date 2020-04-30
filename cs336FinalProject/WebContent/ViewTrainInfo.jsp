<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Train Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>

	<%
	
		String traintodelete = request.getParameter("trainid");
		
		if(traintodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				String command1 = "DELETE FROM Trips WHERE + trainid='" + traintodelete + "'";
				String command2 = "Delete from Trains where + trainid='" + traintodelete + "'";
				
				statement.executeUpdate(command1);
				statement.executeUpdate(command2);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	
TRAIN INFORMATION
<br/>
<br/>
FUNCTIONS
<br/>
Edit Train: Change information on a specific train.
<br/>
Delete Train: Will delete a specific train. NOTE: Deleting a train will delete all trips with that train.
<br/>
Add Train: Add information for a new train.
<br/>


	<table cellpadding="3px" border="1px" solid black>
		<tr>
			<th>Train ID</th>
			<th># Train Cars</th>
			<th># Train Seats</th>
			<th>Edit Train</th>
			<th>Delete Train</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select * from Trains order by trainid asc");
				
				while(results.next()){
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("trainid") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("cars") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("seats") + "</td>" +
							"<td style='text-align:center'><form method='get' action='EditTrainInfo.jsp'>" +
							"<input type='hidden' name='trainid' value='" + results.getObject("trainid") + "'>" +
							"<input type='submit' value='edit'></form></td>" +
							"<td style='text-align:center'><form method='get' action='ViewTrainInfo.jsp'>" +
							"<input type='hidden' name='trainid' value='" + results.getObject("trainid") + "'>" +
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
	<form method="get" action="AddNewTrainInfo.jsp">
		<input type="submit" value="Add Train Info">
	</form>
	
	<br/>
	<form method="post" action="ViewTrainScheduleAttributes.jsp">
		<input type="submit" value="Return to Schedule Attributes Page">
	</form>




</body>
</html>
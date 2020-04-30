<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Station Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewStationInfo.jsp">
		<input type="submit" value="Back to all Station Info">
	</form>
	<h2>Add Station</h2>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String postback = request.getParameter("postback") == null ? "" : request.getParameter("postback");
			
			if(postback.equals("1")){	
				
				if(request.getParameter("editname").equals("")|| request.getParameter("editcity").equals("") || request.getParameter("editstate").equals(""))
				{
					out.print("Please don't leave any fields empty");
				}
				else
				{
				try{
				
				String stationupdate = "Insert into Stations values ("+
						   "'" + request.getParameter("editstationid") + "', " + 
						   "'" + request.getParameter("editcity") + "', " +
						   "'" + request.getParameter("editstate") + "', " +
						   "'" + request.getParameter("editname") + "')" ;
				statement.executeUpdate(stationupdate);
				response.sendRedirect("ViewStationInfo.jsp");
				
				}
				catch (SQLIntegrityConstraintViolationException e)
				{
					out.print("This StationID exists. Please enter a new StationID.");
			
				}	
				catch(Exception e)
				{
					out.print("Please make sure all fields are entered correctly");
				}	
				}
			}
			
				
	%>
				<form method="post" action="AddStationInfo.jsp?postback=1">
					<input type="hidden" name="stationid" value=<%=request.getParameter("stationid") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>StationID: </td>
							<td><input type="text" name="editstationid"></td>
						</tr>
						<tr>
							<td>Station Name: </td>
							<td><input type="text" name="editname"></td>
						</tr>
						<tr>
							<td>City:</td>
							<td><input type="text" name="editcity"></td>
						</tr>
						<tr>
							<td>State: </td>
							<td><input type="text" name="editstate"></td>
						</tr>
						<tr>
							<td><input type="submit" value="Add Station"></td>
						</tr>
					</table>
				</form>
	<%			db.closeConnection(connection);

		} catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>
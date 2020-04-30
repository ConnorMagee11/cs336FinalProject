<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Train Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewTrainInfo.jsp">
		<input type="submit" value="Back to all Train Info">
	</form>
	<h2>Add Train</h2>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String postback = request.getParameter("postback") == null ? "" : request.getParameter("postback");
			
			if(postback.equals("1")){
				
				ResultSet duplicate = statement.executeQuery("SELECT count(trainid) FROM Trains WHERE trainid='" + request.getParameter("edittrainid") + "';");
				
				try{
				if (request.getParameter("edittrainid").length()!=4)
				{
					out.print("Please enter a four digit TrainID");
				}
				else
				{					
				String trainupdate = "Insert into Trains values ("+
									   "'" + request.getParameter("edittrainid") + "', " + 
									   "'" + request.getParameter("editcars") + "', " +
									   "'" + request.getParameter("editseats") + "')" ;
				statement.executeUpdate(trainupdate);
				response.sendRedirect("ViewTrainInfo.jsp");
				
				}}
				catch (SQLIntegrityConstraintViolationException e)
				{
					out.print("This TrainID exists. Please enter a new TrainID.");
			
				}	
				catch(Exception e)
				{
					out.print("Please make sure all fields are entered correctly");
				}
			}
			
	%>
				<form method="post" action="AddNewTrainInfo.jsp?postback=1">
					<input type="hidden" name="trainid" value=<%=request.getParameter("trainid") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>TrainID (####): </td>
							<td><input type="text" name="edittrainid"></td>
						</tr>
						<tr>
							<td>Cars: </td>
							<td><input type="text" name="editcars"></td>
						</tr>
						<tr>
							<td>Seats: </td>
							<td><input type="text" name="editseats"></td>
						</tr>
						<tr>
							<td><input type="submit" value="Add Train"></td>
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
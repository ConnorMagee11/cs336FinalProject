<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Train Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewTrainInfo.jsp">
		<input type="submit" value="Back to all Train Info">
	</form>
	<h2>Edit Train <%=request.getParameter("trainid") %></h2>
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
				String trainupdate = "UPDATE Trains " + "SET " +
									   "trainid='" + request.getParameter("edittrainid") + "', " + 
									   "cars='" + request.getParameter("editcars") + "', " +
									   "seats='" + request.getParameter("editseats") + "' " +
									   "WHERE trainid='" + request.getParameter("trainid") + "'";
				statement.executeUpdate(trainupdate);
				response.sendRedirect("ViewTrainInfo.jsp");
				
				String tripupdate = "UPDATE Trips " + "SET " +
						   "trainid='" + request.getParameter("edittrainid") + "' " + 
						   "WHERE trainid='" + request.getParameter("trainid") + "'";
				statement.executeUpdate(tripupdate);
				
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
			
			ResultSet results = statement.executeQuery("SELECT * FROM Trains WHERE trainid='" + request.getParameter("trainid") + "';");
			
			if(results.next()){
	%>
				<form method="post" action="EditTrainInfo.jsp?postback=1">
					<input type="hidden" name="trainid" value=<%=request.getParameter("trainid") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>TrainID (####): </td>
							<td><input type="text" name="edittrainid" value=<%=results.getObject("trainid") %>></td>
						</tr>
						<tr>
							<td>Cars: </td>
							<td><input type="text" name="editcars" value=<%=results.getObject("cars") %>></td>
						</tr>
						<tr>
							<td>Seats: </td>
							<td><input type="text" name="editseats" value=<%=results.getObject("seats") %>></td>
						</tr>
						<tr>
							<td><input type="submit" value="Save Changes"></td>
						</tr>
					</table>
				</form>
	<%			db.closeConnection(connection);
			}else {
				out.print("No such record exists. Please check the integrity of the database.");
			}
		} catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>
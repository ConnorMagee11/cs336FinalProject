<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Route Name</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewRouteName.jsp">
		<input type="submit" value="Back to all Route Name Info">
	</form>
	<h2>Add Route Name</h2>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String postback = request.getParameter("postback") == null ? "" : request.getParameter("postback");
			
			if(postback.equals("1")){	
				if (request.getParameter("editname").equals(""))
				{
					out.print("Please fill out the field below.");
				}
				else
				{
				try{
				
				String routeupdate = "Insert into Routes(name) values ("+
						   "'" + request.getParameter("editname") + "')" ;
				statement.executeUpdate(routeupdate);
				response.sendRedirect("ViewRouteName.jsp");
				
				}
				catch (Exception e)
				{
					out.print("This Route name exists. Please enter a new Route.");
					//out.print(e);
					
				}	
				}
			}
			
				
	%>
				<form method="post" action="AddNewRouteName.jsp?postback=1">
					<input type="hidden" name="routeid" value=<%=request.getParameter("routeid") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>Route Name: </td>
							<td><input type="text" name="editname"></td>
							<td><input type="submit" value="Save Changes"></td>
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
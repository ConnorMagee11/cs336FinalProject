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
	
	<form method="post" action="CustomerResevation_CR.jsp">
	LIST OF CUSTOMER WHO MADE RESERVATIONS ON:
	<br/>
	<br/>
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		%>
	
		Transit Line: 
	
		<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText=("select name from Routes");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
	
		<select name="transitline" size=1>
		<%
		while(result.next())
		{
		String name = result.getString("name"); 
		%>
		<option value="<%=name %>"><%=name %></option>
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
		
		Train Number: 
		
		<%
		try{

			Statement sqlStatement = connection.createStatement();
			
			String sqlText=("select Trainid from Trains");
			ResultSet result = sqlStatement.executeQuery(sqlText);
		%>	
	
		<select name="train" size=1>
		<%
		while(result.next())
		{
		String train = result.getString("Trainid"); 
		%>
		<option value="<%=train %>"><%=train %></option>
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
		<input type="submit" value="Find Customers">
	</form>
	<br/>
	<br/>
	



</body>
</html>
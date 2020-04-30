<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule Attributes</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>

Select a field you would like to change or view. 

<br/>

	</table>
	<br/>
	<form method="get" action="ViewTrainInfo.jsp">
		<input type="submit" value="Add/Edit/Delete Train Info">
	</form>
	<br/>
	<form method="get" action="ViewStationInfo.jsp">
		<input type="submit" value="Add/Edit/Delete Station Info">
	</form>
	<br/>
	<form method="get" action="ViewRouteName.jsp">
		<input type="submit" value="Add/Edit/Delete Route Name">
	</form>
	<br/>
	<form method="get" action="ViewTrainTrips.jsp">
		<input type="submit" value="Add/Edit/Delete Train Trips">
	</form>

</body>
</html>
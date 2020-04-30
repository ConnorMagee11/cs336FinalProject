<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Customer Representative Home Page</title>
</head>
<body>

	Welcome Customer Service Representative!
	<hr/>
	<br/>
	Select one of the options below:
	<br/>
	<br/>
	
	<form method="post" action="viewReservations.jsp">
		<input type="submit" value="EDIT RESERVATIONS">
	</form>
	<br/>
	<form method="post" action="ViewTrainScheduleAttributes.jsp">
		<input type="submit" value="EDIT TRAIN SCHEDULE">
	</form>
	<br/>
	<form method="post" action="CheckMessages.jsp">
		<input type="submit" value="CHECK MESSAGES">
	</form>
	<br/>
		<form method="post" action="selectOriginandDestination.jsp">
		<input type="submit" value="TRAIN SCHEDULE: ORIGIN-DESTINATION">
	</form>
	</form>
	<br/>
		<form method="post" action="findStation.jsp">
		<input type="submit" value="TRAIN SCHEDULE BY STATION">
	</form>
	<br/>
	<form method="post" action="findCustomerReservations.jsp">
		<input type="submit" value="LIST OF CUSTOMERS WHO MADE A RESERVATION">
	</form>
	<br/>
	<hr/>
	<form method="get" action="login.jsp?logoutSuccessful=1">
		<input type="submit" value="Log Out">
	</form>
	


</body>
</html>
<%////Sneha Manikandan code%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Weekly Reservation Receipt</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>



<%
try
{
	ApplicationDB db = new ApplicationDB();
	Connection connection = db.getConnection();

	String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
	String total = request.getParameter("total") == null ? "" : request.getParameter("total");
	String total2 = request.getParameter("total2") == null ? "" : request.getParameter("total2");
	String age_disability = request.getParameter("age_disability") == null ? "" : request.getParameter("age_disability");
	String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
	String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
	String date = request.getParameter("date") == null ? "" : request.getParameter("date");
	
	



//Insert values into Reservations Table	
		Statement statement7 = connection.createStatement();
		String newreservation = "Insert into Reservations (reservationdate, rtype, startdate, total_fare, disability_agestatus, customeremail, csrSSN) values ("+
			   " now(), " + 
			   "'Weekly', " +
			   "'" + date + "', " +
			   "'" + total + "', " +
			   "'" + age_disability + "', " +
			   "'" + session.getAttribute("customeremail") + "', " +
			   "'" + session.getAttribute("CustomerRepresentativeSSN") + "')";
		statement7.executeUpdate(newreservation);
///////	

///get the reservationid
	Statement statement4 = connection.createStatement();
	ResultSet getreservationid=statement4.executeQuery("select max(reservationid)from Reservations;");
	
	getreservationid.first();
	String reservationid=getreservationid.getString("max(reservationid)");
////

///Get tripid info like trainid, routeid, starttime, endtime	
	Statement statement = connection.createStatement();
	ResultSet getTripInfo=statement.executeQuery("select tripid "+
			"from "+
			"(SELECT t.* "+
			"from Trips t "+
			"where t.SourceStationID='"+origin+"' "+
			"and t.destinationstationid='"+destination+"' "+
			"and t.starttime>'"+date+"' "+
			"and t.starttime<DATE_ADD('"+date+"', INTERVAL 7 DAY) "+
			"union "+
			"SELECT t.* "+
			"from Trips t "+
			"where t.SourceStationID='"+destination+"' "+
			"and t.destinationstationid='"+origin+"' "+
			"and t.starttime>'"+date+"' "+
			"and t.starttime<DATE_ADD('"+date+"', INTERVAL 7 DAY)) as alltrips;");
	
//////	

	

//populate reservation multivalue table


	while(getTripInfo.next())
	{
		Statement statement6 = connection.createStatement();
		String reservation_tripid = "Insert into Multivalue_Reservations_Trips (reservationid, tripid, farepicked, class, seatid) values ("+
			   "'" + reservationid + "'," +
			   "'" + getTripInfo.getObject("tripid") + "', " +
			   "'" + total2 + "', " +
			   "'" + classtype + "', " +
			   "1)";
		statement6.executeUpdate(reservation_tripid);
	}
	
	//


////

 	out.println("The Customer's Reservation Was Added Successfully!");
	out.println("<br/>");
	out.println("<br/>");
	out.print("The Customer's Reservation ID Is: "+reservationid);


%>

	<br/>
	<br/>
	Return to customer home page
	
	<table>
	<form method="get" action="viewReservations.jsp">
		<input type="submit" value="View All Reservations">
	</form>

<%
	
			db.closeConnection(connection);
	
}
catch (Exception e)
{
	out.print("An error has occured please try again later.");
	//out.print(e);
	%>
	<br/>
	<br/>
	<%			
}		


%>


</body>
</html>
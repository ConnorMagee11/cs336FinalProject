<%////Sneha Manikandan code%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>One Way Reservation Receipt</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>



<%
try
{
	ApplicationDB db = new ApplicationDB();
	Connection connection = db.getConnection();

	
	String total = request.getParameter("total") == null ? "" : request.getParameter("total");
	String fare = request.getParameter("fare") == null ? "" : request.getParameter("fare");
	String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
	String tripid = request.getParameter("tripid") == null ? "" : request.getParameter("tripid");
	String age_disability = request.getParameter("age_disability") == null ? "" : request.getParameter("age_disability");


//Insert values into Reservations Table	
		Statement statement7 = connection.createStatement();
	String newreservation = "Insert into Reservations (reservationdate, rtype, total_fare, disability_agestatus, customeremail, csrSSN) values ("+
			   " now(), " + 
			   "'One-Way', " +
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
	ResultSet getTripInfo=statement.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripid+"'");
	
	getTripInfo.first();
	String trainid=getTripInfo.getString("trainid");
	String routeid=getTripInfo.getString("routeid");
	String starttime=getTripInfo.getString("starttime");
	String endtime=getTripInfo.getString("endtime");
	int availableseats=getTripInfo.getInt("ts.seats");
//////	

///Get the route and the start and end for that route.
	Statement statement2 = connection.createStatement();
	ResultSet getBigRouteTripID = statement2.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
			"from Trips t "+
			"where t.tripid = any "+
			"(select tripid "+
			"from Trips "+
			"where trainid='"+trainid+"' "+
			"and routeid='"+routeid+"' "+
			"and starttime<='"+starttime+"' "+
			"and endtime>='"+endtime+"' "+
			")group by TIMESTAMPDIFF(minute, t.starttime, t.endtime) desc;");
	
	getBigRouteTripID.first();
	String BigRouteTripID=getBigRouteTripID.getString("tripid");
	String trainid2=getBigRouteTripID.getString("trainid");
	String routeid2=getBigRouteTripID.getString("routeid");
	String starttime2=getBigRouteTripID.getString("starttime");
	String endtime2=getBigRouteTripID.getString("endtime");
	
////	

///Decrease the number of available seats by 1 for all seats on that route

			Statement statement3 = connection.createStatement();
			statement3.executeUpdate(
					"update Trips "+
					"set availableseats=availableseats-1 "+
					"where tripid in "+
					"(	select tripid "+
						"from ( "+
							"select t.* from Trips t "+
							"where trainid='"+ trainid2+"' "+
					        "and routeid='"+ routeid2+"' "+
							"and starttime>='"+ starttime2+"' "+
							"and endtime<='"+ endtime2+"' "+
					    ") as a); ");
////

//populate reservation multivalue table

	//First find available seats
	Statement statement5 = connection.createStatement();
	ResultSet getusedseats=statement5.executeQuery("select m.seatid "+
			"from Trips t, Multivalue_Reservations_Trips m "+
			"where t.tripid=m.tripid "+
			"and trainid='"+ trainid2+"' "+
			"and routeid='"+ routeid2+"' "+
			"and starttime>='"+ starttime2+"' "+
			"and endtime<='"+ endtime2+"'");
	ArrayList<String> usedseats = new ArrayList<String>();
	
	while(getusedseats.next())
	{
		usedseats.add(getusedseats.getString("m.seatid"));
	}
	
	ArrayList<String> emptyseats = new ArrayList<String>();
	
	for(int x=1; x<=availableseats;x++)
	{
		if(!usedseats.contains(x+""))
			emptyseats.add(x+"");
	}
	//
	//Then set the seat number equal to the first available seat.
	Statement statement6 = connection.createStatement();
	String reservation_tripid = "Insert into Multivalue_Reservations_Trips (reservationid, tripid, farepicked, class, seatid) values ("+
			   "'" + reservationid + "'," +
			   "'" + tripid + "', " +
			   "'" + fare + "', " +
			   "'" + classtype + "', " +
			   "'" + emptyseats.get(0) + "')";
	statement6.executeUpdate(reservation_tripid);
	
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
	<br/>
	<br/>
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
<%////Sneha Manikandan code%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Round Trip Reservation Receipt</title>
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

	
	String total = request.getParameter("total") == null ? "" : request.getParameter("total");
	String classtype = request.getParameter("classtype1") == null ? "" : request.getParameter("classtype1");
	String tripid = request.getParameter("tripid1") == null ? "" : request.getParameter("tripid1");
	
	String classtype2 = request.getParameter("classtype2") == null ? "" : request.getParameter("classtype2");
	String tripid2 = request.getParameter("tripid2") == null ? "" : request.getParameter("tripid2");
	
	String fare = request.getParameter("fare") == null ? "" : request.getParameter("fare");
	String age_disability = request.getParameter("age_disability") == null ? "" : request.getParameter("age_disability");
	
	
	///TESTING
	//tripid="1";
	//tripid2="3";
	//classtype="economy";
	//classtype2="economy";
	//total="3";
	
	

//Insert values into Reservations Table	
	Statement statement7 = connection.createStatement();
	String newreservation = "Insert into Reservations (reservationdate, rtype, total_fare, disability_agestatus, customeremail, csrSSN) values ("+
			   " now(), " + 
			   "'Round Trip', " +
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

///Get tripid info like trainid, routeid, starttime, endtime DEPARTURE
	Statement statement = connection.createStatement();
	ResultSet getTripInfo=statement.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripid+"'");
	
	getTripInfo.first();
	String trainid=getTripInfo.getString("trainid");
	String routeid=getTripInfo.getString("routeid");
	String starttime=getTripInfo.getString("starttime");
	String endtime=getTripInfo.getString("endtime");
	int availableseats=getTripInfo.getInt("ts.seats");
//////	

///Get the route and the start and end for that route.DEPARTURE
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

///Decrease the number of available seats by 1 for all seats on that route DEPARTURE

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

//populate reservation multivalue table DEPARTURE

	//First find available seatsDEPARTURE
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
	//Then set the seat number equal to the first available seat.DEPARTURE
	Statement statement6 = connection.createStatement();
	String reservation_tripid = "Insert into Multivalue_Reservations_Trips (reservationid, tripid, farepicked, class, seatid) values ("+
			   "'" + reservationid + "'," +
			   "'" + tripid + "', " +
			   "'" + fare + "', " +
			   "'" + classtype + "', " +
			   "'" + emptyseats.get(0) + "')";
	statement6.executeUpdate(reservation_tripid);
	
	//
	
	
	
	
	
	
	
	
///Get tripid info like trainid, routeid, starttime, endtime ARRIVAL
	Statement statementtrip2 = connection.createStatement();
	ResultSet getTripInfotrip2=statementtrip2.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripid2+"'");
	
	getTripInfotrip2.first();
	String trainidtrip2=getTripInfotrip2.getString("trainid");
	String routeidtrip2=getTripInfotrip2.getString("routeid");
	String starttimetrip2=getTripInfotrip2.getString("starttime");
	String endtimetrip2=getTripInfotrip2.getString("endtime");
	int availableseatstrip2=getTripInfotrip2.getInt("ts.seats");
//////	

///Get the route and the start and end for that route.ARRIVAL
	Statement statement2trip2 = connection.createStatement();
	ResultSet getBigRouteTripIDtrip2 = statement2trip2.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
			"from Trips t "+
			"where t.tripid = any "+
			"(select tripid "+
			"from Trips "+
			"where trainid='"+trainidtrip2+"' "+
			"and routeid='"+routeidtrip2+"' "+
			"and starttime<='"+starttimetrip2+"' "+
			"and endtime>='"+endtimetrip2+"' "+
			")group by TIMESTAMPDIFF(minute, t.starttime, t.endtime) desc;");
	
	getBigRouteTripIDtrip2.first();
	String BigRouteTripIDtrip2=getBigRouteTripIDtrip2.getString("tripid");
	String trainid2trip2=getBigRouteTripIDtrip2.getString("trainid");
	String routeid2trip2=getBigRouteTripIDtrip2.getString("routeid");
	String starttime2trip2=getBigRouteTripIDtrip2.getString("starttime");
	String endtime2trip2=getBigRouteTripIDtrip2.getString("endtime");
	
////	

///Decrease the number of available seats by 1 for all seats on that route ARRIVAL

			Statement statement3trip2 = connection.createStatement();
			statement3trip2.executeUpdate(
					"update Trips "+
					"set availableseats=availableseats-1 "+
					"where tripid in "+
					"(	select tripid "+
						"from ( "+
							"select t.* from Trips t "+
							"where trainid='"+ trainid2trip2+"' "+
					        "and routeid='"+ routeid2trip2+"' "+
							"and starttime>='"+ starttime2trip2+"' "+
							"and endtime<='"+ endtime2trip2+"' "+
					    ") as a); ");
////

//populate reservation multivalue tableARRIVAL

	//First find available seatsARRIVAL
	Statement statement5trip2 = connection.createStatement();
	ResultSet getusedseatstrip2=statement5trip2.executeQuery("select m.seatid "+
			"from Trips t, Multivalue_Reservations_Trips m "+
			"where t.tripid=m.tripid "+
			"and trainid='"+ trainid2trip2+"' "+
			"and routeid='"+ routeid2trip2+"' "+
			"and starttime>='"+ starttime2trip2+"' "+
			"and endtime<='"+ endtime2trip2+"'");
	
	
	ArrayList<String> usedseatstrip2 = new ArrayList<String>();
	
	while(getusedseatstrip2.next())
	{
		usedseatstrip2.add(getusedseatstrip2.getString("m.seatid"));
	}
	
	ArrayList<String> emptyseatstrip2 = new ArrayList<String>();
	for(int x=1; x<=availableseatstrip2;x++)
	{
		if(!usedseatstrip2.contains(x+""))
			emptyseatstrip2.add(x+"");
	}

	//
	//Then set the seat number equal to the first available seat.ARRIVAL
	Statement statement6trip2 = connection.createStatement();
	String reservation_tripidtrip2 = "Insert into Multivalue_Reservations_Trips (reservationid, tripid, farepicked, class, seatid) values ("+
			   "'" + reservationid + "'," +
			   "'" + tripid2 + "', " +
			   "'" + fare + "', " +
			   "'" + classtype2 + "', " +
			   "'" + emptyseatstrip2.get(0) + "')";
	statement6trip2.executeUpdate(reservation_tripidtrip2);
	
	//



	
	
	
	
	
	
	
	
////




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
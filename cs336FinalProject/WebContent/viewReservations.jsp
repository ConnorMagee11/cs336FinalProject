<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Reservation Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>

	<%
	
		String reservationtodelete = request.getParameter("reservationidtodelete");
		
		if(reservationtodelete != null){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement t = connection.createStatement();
				
				String command4 = "Select tripid from Multivalue_Reservations_Trips where + reservationid='" + reservationtodelete + "'";
				
				ResultSet trips=t.executeQuery(command4);
				
				
				while (trips.next())
				{
			////Add 1 to availableseats along the OLD TRIP ROUTE
							///Get tripid info like trainid, routeid, starttime, endtime for old route
								Statement statement1 = connection.createStatement();
								ResultSet getTripInfo=statement1.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+trips.getString("tripid")+"'");
				
								getTripInfo.first();
								String trainid=getTripInfo.getString("trainid");
								String routeid=getTripInfo.getString("routeid");
								String starttime=getTripInfo.getString("starttime");
								String endtime=getTripInfo.getString("endtime");
							//////////
							
							///Get the route and the start and end for that old route.
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
							///////////	
							
							///Increase the number of available seats by 1 for all seats on that old route

								Statement statement3 = connection.createStatement();
								statement3.executeUpdate(
									"update Trips "+
									"set availableseats=availableseats+1 "+
									"where tripid in "+
									"(	select tripid "+
									"from ( "+
									"select t.* from Trips t "+
									"where trainid='"+ trainid2+"' "+
								    "and routeid='"+ routeid2+"' "+
									"and starttime>='"+ starttime2+"' "+
									"and endtime<='"+ endtime2+"' "+
								    ") as a); ");
							/////////
					//////
				}	
				
				
				
				Statement statement = connection.createStatement();
				
				String command2 = "Delete from Reservations where + reservationid='" + reservationtodelete + "'";
				
				statement.executeUpdate(command2);
				
			}catch(Exception e){
				out.print(e);
			}
		}
	%>
	
RESERVATION INFORMATION
<br/>
<br/>
FUNCTIONS
<br/>
View/Edit Reservation: View details about a particular reservation and make changes.
<br/>
Delete Station: Will delete a reservation. 
<br/>
Add Station: Add a new reservation for a customer. 
<br/>


	<table cellpadding="3px" border="1px" solid black>
		<tr>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Customer Email</th>
			<th>Fare</th>
			<th>View/Edit Reservation Details</th>
			<th>Delete Reservation</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select *,  date_format(reservationdate,'%H:%i %p %m/%d/%Y') as time from Reservations order by reservationid asc");
				
				while(results.next()){
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("reservationid") + "</td>" +
							"<td style='text-align:center'>" + results.getObject("time")+ "</td>" +
							"<td style='text-align:center'>" + results.getObject("customeremail") + "</td>" +
							"<td style='text-align:center'>" +"$"+ results.getObject("total_fare") + "</td>" +
							"<td style='text-align:center'><form method='get' action='EditReservationInfo.jsp'>" +
							"<input type='hidden' name='reservationid' value='" + results.getObject("reservationid") + "'>" +
							"<input type='submit' value='edit'></form></td>" +
							"<td style='text-align:center'><form method='get' action='viewReservations.jsp'>" +
							"<input type='hidden' name='reservationidtodelete' value='" + results.getObject("reservationid") + "'>" +
							"<input type='submit' value='delete'></form></td>" +
							"</tr>";
					out.print(html);
				}
				
				db.closeConnection(connection);
								
			} catch(Exception e){
				out.print(e);
			}
		%>
	<br/>
	</table>
		<br/>
	<form method="get" action="AddNewReservationPage1.jsp">
		<input type="submit" value="Add New Reservation">
	</form>




</body>
</html>
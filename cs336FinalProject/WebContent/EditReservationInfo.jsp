<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Reservation Information</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method='post' action="viewReservations.jsp">
				<input type='hidden' name="reservationid" value=<%=request.getParameter("reservationid")%>>
				<input type='hidden' name="tripid" value=<%=request.getParameter("tripid")%>>
				<input type="submit" value="Return to All Customer's Reservation Info">
	</form>
	<br/>
	<% 
	
	//changed 4/30/2020 Sneha
try
	{
	ApplicationDB db = new ApplicationDB();
	Connection connection = db.getConnection();
	String reservationid = request.getParameter("reservationid") == null ? "" : request.getParameter("reservationid");

	
///CHANGE TOTAL FARE

	String changefare = request.getParameter("changefare") == null ? "" : request.getParameter("changefare");
	
	if(changefare.equals("1"))
	{
		Statement change3 = connection.createStatement();
		String updateClass3 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + request.getParameter("edittotalfare") + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change3.executeUpdate(updateClass3);
		
	}


/////
	
	
/////CHANGE TRAVEL
	String changetravel = request.getParameter("changetravel") == null ? "" : request.getParameter("changetravel");


	if(changetravel.equals("1"))
	{
		String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
		String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
		String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
		String date = request.getParameter("triptime") == null ? "" : request.getParameter("triptime");
		String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
		
		Statement sql3 = connection.createStatement();
		ResultSet money = sql3.executeQuery("select count(tripid), max(economyfare), max(businessfare), max(firstfare), max(ecddiscount), max(weekdiscount) "+
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
		money.first();
		
		if(money.getInt("count(tripid)")==0)
		{
			%>
			<div class="alert">
				<strong>Error! </strong> No trains are traveling between the two stations on that week. 
			</div>
			<% 
			
			
			//out.print(origin+" "+destination+" "+date);
		}
		else
		{	money.first();

		double eco$=money.getFloat("max(economyfare)");
		double bus$=money.getFloat("max(businessfare)");
		double fir$=money.getFloat("max(firstfare)");
		double week$=money.getFloat("max(weekdiscount)");
		double disabilitydiscount$=money.getFloat("max(ecddiscount)");
		double total=0;
	
		if (classtype.equals("economy"))
		{
			total=eco$;
		}
		else if (classtype.equals("business"))
		{
			total=bus$;
		}
		else if (classtype.equals("first"))
		{
				total=fir$;
		}
	
		total=total*10;
		total=total-(total*(week$/100));
	
		double individualfare=total/money.getFloat("count(tripid)");
	
		total=total+(total*(.1));////Added booking fee-10% 
	
		if (discount.equals("Yes"))
		{
			total=total-(total*(disabilitydiscount$/100));
		}
		//delete old values
		Statement change2 = connection.createStatement();
		String updateClass2 = "delete from Multivalue_Reservations_Trips WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);
		
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
				   "'" + individualfare + "', " +
				   "'" + classtype + "', " +
				   "1)";
			statement6.executeUpdate(reservation_tripid);
		}
		
	//////
		
	///Change the Total Fare
		Statement change3 = connection.createStatement();
		String updateClass3 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change3.executeUpdate(updateClass3);
	/////		
		}		
	}
	
	if(changetravel.equals("2"))
	{
		String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
		String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
		String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
		String date = request.getParameter("triptime") == null ? "" : request.getParameter("triptime");
		String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
		
		Statement sql3 = connection.createStatement();
		ResultSet money = sql3.executeQuery("select count(tripid), max(economyfare), max(businessfare), max(firstfare), max(ecddiscount), max(monthdiscount) "+
				"from "+
				"(SELECT t.* "+
				"from Trips t "+
				"where t.SourceStationID='"+origin+"' "+
				"and t.destinationstationid='"+destination+"' "+
				"and t.starttime>'"+date+"' "+
				"and t.starttime<DATE_ADD('"+date+"', INTERVAL 1 Month) "+
				"union "+
				"SELECT t.* "+
				"from Trips t "+
				"where t.SourceStationID='"+destination+"' "+
				"and t.destinationstationid='"+origin+"' "+
				"and t.starttime>'"+date+"' "+
				"and t.starttime<DATE_ADD('"+date+"', INTERVAL 1 Month)) as alltrips;");
		money.first();
		
		if(money.getInt("count(tripid)")==0)
		{
			%>
			<div class="alert">
				<strong>Error! </strong> No trains are traveling between the two stations during that month. 
			</div>
			<% 
			
			out.print(money.getInt("count(tripid)"));
			//out.print(origin+" "+destination+" "+date);
		}
		else
		{	money.first();

		double eco$=money.getFloat("max(economyfare)");
		double bus$=money.getFloat("max(businessfare)");
		double fir$=money.getFloat("max(firstfare)");
		double week$=money.getFloat("max(monthdiscount)");
		double disabilitydiscount$=money.getFloat("max(ecddiscount)");
		double total=0;
	
		if (classtype.equals("economy"))
		{
			total=eco$;
		}
		else if (classtype.equals("business"))
		{
			total=bus$;
		}
		else if (classtype.equals("first"))
		{
				total=fir$;
		}
	
		total=total*10;
		total=total-(total*(week$/100));
	
		double individualfare=total/money.getFloat("count(tripid)");
	
		total=total+(total*(.1));////Added booking fee-10% 
	
		if (discount.equals("Yes"))
		{
			total=total-(total*(disabilitydiscount$/100));
		}
		//delete old values
		Statement change2 = connection.createStatement();
		String updateClass2 = "delete from Multivalue_Reservations_Trips WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);
		
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
				   "'" + individualfare + "', " +
				   "'" + classtype + "', " +
				   "1)";
			statement6.executeUpdate(reservation_tripid);
		}
		
	//////
		
	///Change the Total Fare
		Statement change3 = connection.createStatement();
		String updateClass3 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change3.executeUpdate(updateClass3);
	/////		
		}
	}
	
////
	
/////CHANGE TRIP DETAILS ONE WAY
	String changetrip = request.getParameter("changetrip") == null ? "" : request.getParameter("changetrip");

	if(changetrip.equals("1"))
	{
		String tripid = request.getParameter("tripid") == null ? "" : request.getParameter("tripid");
		String tripidnew = request.getParameter("tripidnew") == null ? "" : request.getParameter("tripidnew");

		if(!(tripidnew.equals("")))
		{	
		////Add 1 to availableseats along the OLD TRIP ROUTE
				///Get tripid info like trainid, routeid, starttime, endtime for old route
					Statement statement = connection.createStatement();
					ResultSet getTripInfo=statement.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripid+"'");
	
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
		
		//////Subtract 1 to available seats along NEW TRIP ROUTE
		
			///Get tripid info like trainid, routeid, starttime, endtime for NEW route	
				Statement statementNEW = connection.createStatement();
				ResultSet getTripInfoNEW=statementNEW.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripidnew+"'");
	
				getTripInfoNEW.first();
				String trainidNEW=getTripInfoNEW.getString("trainid");
				String routeidNEW=getTripInfoNEW.getString("routeid");
				String starttimeNEW=getTripInfoNEW.getString("starttime");
				String endtimeNEW=getTripInfoNEW.getString("endtime");
				int availableseats=getTripInfoNEW.getInt("ts.seats");
			//////
		
			///Get the route and the start and end for that NEW route.
					Statement statement2NEW = connection.createStatement();
					ResultSet getBigRouteTripIDNEW = statement2NEW.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
						"from Trips t "+
						"where t.tripid = any "+
						"(select tripid "+
						"from Trips "+
						"where trainid='"+trainidNEW+"' "+
						"and routeid='"+routeidNEW+"' "+
						"and starttime<='"+starttimeNEW+"' "+
						"and endtime>='"+endtimeNEW+"' "+
						")group by TIMESTAMPDIFF(minute, t.starttime, t.endtime) desc;");
	
					getBigRouteTripIDNEW.first();
					String BigRouteTripIDNEW=getBigRouteTripIDNEW.getString("tripid");
					String trainid2NEW=getBigRouteTripIDNEW.getString("trainid");
					String routeid2NEW=getBigRouteTripIDNEW.getString("routeid");
					String starttime2NEW=getBigRouteTripIDNEW.getString("starttime");
					String endtime2NEW=getBigRouteTripIDNEW.getString("endtime");
				///////////	
				
				///Decrease the number of available seats by 1 for all seats on that NEW route

					Statement statement3NEW = connection.createStatement();
					statement3NEW.executeUpdate(
						"update Trips "+
						"set availableseats=availableseats-1 "+
						"where tripid in "+
						"(	select tripid "+
						"from ( "+
						"select t.* from Trips t "+
						"where trainid='"+ trainid2NEW+"' "+
					    "and routeid='"+ routeid2NEW+"' "+
						"and starttime>='"+ starttime2NEW+"' "+
						"and endtime<='"+ endtime2NEW+"' "+
					    ") as a); ");
				/////////
				
				//Find available seats for NEW Route
					Statement statement5 = connection.createStatement();
					ResultSet getusedseats=statement5.executeQuery("select m.seatid "+
						"from Trips t, Multivalue_Reservations_Trips m "+
						"where t.tripid=m.tripid "+
						"and trainid='"+ trainid2NEW+"' "+
						"and routeid='"+ routeid2NEW+"' "+
						"and starttime>='"+ starttime2NEW+"' "+
						"and endtime<='"+ endtime2NEW+"'");
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
				/////////
		//////

		////Calculate the fare and update values into the table(update fare and trip id)
				Statement statement6 = connection.createStatement();
				ResultSet getreservationinfo=statement6.executeQuery("select r.*, m.* from Reservations r, Multivalue_Reservations_Trips m where r.reservationid=m.reservationid and r.reservationid='"+reservationid+"'");
				getreservationinfo.first();
				
				String classtype=getreservationinfo.getString("class");
				String discount=getreservationinfo.getString("disability_agestatus");
				
				Statement classchange = connection.createStatement();
				
				String text= "select t.* from Trips t "+"where t.tripid='"+tripidnew+"'";
				ResultSet result2 = classchange.executeQuery(text);
				result2.first();

				double discountnum=result2.getFloat("ecddiscount");
				double total=0;
				
				if(classtype.equals("economy"))
				{
					total=result2.getFloat("economyfare");
				}
				else if (classtype.equals("business"))
				{
					total=result2.getFloat("businessfare");
				}
				else if (classtype.equals("first"))
				{
					total=result2.getFloat("firstfare");
				}

				if (discount.equals("Yes"))
				{
					total=total-(total*(discountnum/100));
					
				}
				
				Statement change = connection.createStatement();
				String updateClass = "UPDATE Multivalue_Reservations_Trips " + 
						   "SET " +
						   "farepicked='" + total + "', " +
							"tripid='" + tripidnew + "', " +
							"seatid='" + emptyseats.get(0)+ "' " +
						   "WHERE reservationid='" + reservationid + "';";
				change.executeUpdate(updateClass);
				
				total=total+(total*(.1));////Added booking fee-10% 
				
				Statement change2 = connection.createStatement();
				String updateClass2 = "UPDATE Reservations " + 
						   "SET " +
						    "reservationdate=now(), " +
						   "total_fare='" + total + "' " +
						   "WHERE reservationid='" + reservationid + "';";
				change2.executeUpdate(updateClass2);
	}	///////////////////////
	}
///////////CHANGE TRIP ROUND TRIP	
	if (changetrip.equals("2"))
	{
		String tripid1 = request.getParameter("tripid1") == null ? "" : request.getParameter("tripid1");
		String tripid1new = request.getParameter("tripid1new") == null ? "" : request.getParameter("tripid1new");
		
		String tripid2 = request.getParameter("tripid2") == null ? "" : request.getParameter("tripid2");
		String tripid2new = request.getParameter("tripid2new") == null ? "" : request.getParameter("tripid2new");
		
		String tripid=tripid1;
		String tripidnew=tripid1new;
		String tripidnew2=tripid2new;
		
		if(!(tripidnew.equals("") || tripidnew2.equals("")))
	{	
		for(int x=0;x<2;x++)
		{

			if(x==1)
			{
				tripid=tripid2;
				tripidnew=tripid2new;
				tripidnew2=tripid1new;
			}
			
			////Add 1 to availableseats along the OLD TRIP ROUTE
					///Get tripid info like trainid, routeid, starttime, endtime for old route
						Statement statement = connection.createStatement();
						ResultSet getTripInfo=statement.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripid+"'");
		
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
			
			//////Add 1 to available seats along NEW TRIP ROUTE
			
				///Get tripid info like trainid, routeid, starttime, endtime for NEW route	
					Statement statementNEW = connection.createStatement();
					ResultSet getTripInfoNEW=statementNEW.executeQuery("Select t.*, ts.seats from Trips t, Trains ts where t.trainid=ts.trainid and tripid='"+tripidnew+"'");
		
					getTripInfoNEW.first();
					String trainidNEW=getTripInfoNEW.getString("trainid");
					String routeidNEW=getTripInfoNEW.getString("routeid");
					String starttimeNEW=getTripInfoNEW.getString("starttime");
					String endtimeNEW=getTripInfoNEW.getString("endtime");
					int availableseats=getTripInfoNEW.getInt("ts.seats");
				//////
			
				///Get the route and the start and end for that NEW route.
						Statement statement2NEW = connection.createStatement();
						ResultSet getBigRouteTripIDNEW = statement2NEW.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
							"from Trips t "+
							"where t.tripid = any "+
							"(select tripid "+
							"from Trips "+
							"where trainid='"+trainidNEW+"' "+
							"and routeid='"+routeidNEW+"' "+
							"and starttime<='"+starttimeNEW+"' "+
							"and endtime>='"+endtimeNEW+"' "+
							")group by TIMESTAMPDIFF(minute, t.starttime, t.endtime) desc;");
		
						getBigRouteTripIDNEW.first();
						String BigRouteTripIDNEW=getBigRouteTripIDNEW.getString("tripid");
						String trainid2NEW=getBigRouteTripIDNEW.getString("trainid");
						String routeid2NEW=getBigRouteTripIDNEW.getString("routeid");
						String starttime2NEW=getBigRouteTripIDNEW.getString("starttime");
						String endtime2NEW=getBigRouteTripIDNEW.getString("endtime");
					///////////	
					
					///Decrease the number of available seats by 1 for all seats on that NEW route

						Statement statement3NEW = connection.createStatement();
						statement3NEW.executeUpdate(
							"update Trips "+
							"set availableseats=availableseats-1 "+
							"where tripid in "+
							"(	select tripid "+
							"from ( "+
							"select t.* from Trips t "+
							"where trainid='"+ trainid2NEW+"' "+
						    "and routeid='"+ routeid2NEW+"' "+
							"and starttime>='"+ starttime2NEW+"' "+
							"and endtime<='"+ endtime2NEW+"' "+
						    ") as a); ");
					/////////
					
					//Find available seats for NEW Route
						Statement statement5 = connection.createStatement();
						ResultSet getusedseats=statement5.executeQuery("select m.seatid "+
							"from Trips t, Multivalue_Reservations_Trips m "+
							"where t.tripid=m.tripid "+
							"and trainid='"+ trainid2NEW+"' "+
							"and routeid='"+ routeid2NEW+"' "+
							"and starttime>='"+ starttime2NEW+"' "+
							"and endtime<='"+ endtime2NEW+"'");
						ArrayList<String> usedseats = new ArrayList<String>();
		
						while(getusedseats.next())
						{
							usedseats.add(getusedseats.getString("m.seatid"));
						}
		
						ArrayList<String> emptyseats = new ArrayList<String>();
		
						for(int y=1; y<=availableseats;y++)
						{
							if(!usedseats.contains(y+""))
								emptyseats.add(y+"");
						}
					/////////
			//////

			////Calculate the fare and update values into the table(update fare and trip id)
					Statement statement6 = connection.createStatement();
					ResultSet getreservationinfo=statement6.executeQuery("select r.*, m.* from Reservations r, Multivalue_Reservations_Trips m where r.reservationid=m.reservationid and r.reservationid='"+reservationid+"'");
					
					getreservationinfo.first();
					String classtype=getreservationinfo.getString("class");
					getreservationinfo.next();
					String classtype2=getreservationinfo.getString("class");
					String discount=getreservationinfo.getString("disability_agestatus");
					
					Statement sqlStatement = connection.createStatement();
					
					String text= "select t.* "+"from Trips t "+"where t.tripid='"+tripidnew+"'";
					ResultSet result2 = sqlStatement.executeQuery(text);
					result2.first();

					double discountnum=result2.getFloat("ecddiscount");
					double roundtrip=result2.getFloat("roundtripdiscount");
					double total=0;
					
					if(classtype.equals("economy"))
					{
						total=result2.getFloat("economyfare");
					}
					else if (classtype.equals("business"))
					{
						total=result2.getFloat("businessfare");
					}
					else if (classtype.equals("first"))
					{
						total=result2.getFloat("firstfare");
					}

					Statement sqlStatement1 = connection.createStatement();
					
					String text1= "select t.* "+"from Trips t "+"where t.tripid='"+tripidnew2+"'";
					ResultSet result3 = sqlStatement1.executeQuery(text1);
					result3.first();
					double discountnum1=result3.getFloat("ecddiscount");
					double roundtrip1=result3.getFloat("roundtripdiscount");
					
					if (discountnum>discountnum1)
					{
						discountnum=discountnum1;
					}
					
					if (roundtrip>roundtrip1)
					{
						roundtrip=roundtrip1;
					}
					
					
					if(classtype2.equals("economy"))
					{
						total+=result3.getFloat("economyfare");
					}
					else if (classtype2.equals("business"))
					{
						total+=result3.getFloat("businessfare");
					}
					else if (classtype2.equals("first"))
					{
						total+=result3.getFloat("firstfare");
					}
					
					total=total-(total*(roundtrip/100));
					
					double farepicked=total/2;
					
					Statement change = connection.createStatement();
					String updateFare = "UPDATE Multivalue_Reservations_Trips " + 
							   "SET " +
							   "farepicked='" + farepicked + "', " +
							    "tripid='" + tripidnew + "' " +
							   "WHERE reservationid='" + request.getParameter("reservationid") + "' and tripid='"+tripid+"'";
					change.executeUpdate(updateFare);
					
					total=total+(total*(.1));////Added booking fee-10% 	
						
					if (discount.equals("Yes"))
					{
						total=total-(total*(discountnum/100));
						
						Statement change3 = connection.createStatement();
						String updateClass3 = "UPDATE Reservations " + 
								   "SET " +
								   "total_fare='" + total + "' " +
								   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
						change3.executeUpdate(updateClass3);
					}
		}		
		}
				
	}
/////////////
	
	
////TRANSFER TICKET	
	String transferticket = request.getParameter("transferticket") == null ? "" : request.getParameter("transferticket");

	if(transferticket.equals("1"))
	{
		try
		{
		Statement change = connection.createStatement();
		String updateCustomer = "UPDATE Reservations " + 
				   "SET " +
				   "customeremail='" + request.getParameter("email") + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change.executeUpdate(updateCustomer);
		}
		catch (Exception e)
		{
		%>
			<div class="alert">
  				<strong>Error! Ticket Not Transfered: </strong> No customer with this email exists.
			</div>
		<%	
		}
	}
	
////////	


//////CHANGE CLASS and Total Fare
	String changeclass = request.getParameter("changeclass") == null ? "" : request.getParameter("changeclass");

	if (changeclass.equals("1"))
	{
		Statement classchange = connection.createStatement();
	
		String text= "select t.* from Trips t "+"where t.tripid='"+request.getParameter("tripid")+"'";
		ResultSet result2 = classchange.executeQuery(text);
		result2.first();

		String economy=result2.getString("economyfare");
		String business=result2.getString("businessfare");
		String first=result2.getString("firstfare");
		double discountnum=result2.getFloat("ecddiscount");
		double total=0;
		
		if(request.getParameter("classtype").equals("economy"))
		{
			total=result2.getFloat("economyfare");
		}
		else if (request.getParameter("classtype").equals("business"))
		{
			total=result2.getFloat("businessfare");
		}
		else if (request.getParameter("classtype").equals("first"))
		{
			total=result2.getFloat("firstfare");
		}
		
		Statement change = connection.createStatement();
		String updateClass = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "class='" + request.getParameter("classtype") + "', " +
				   "farepicked='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change.executeUpdate(updateClass);
		
		total=total+(total*(.1));////Added booking fee-10% 
		
		if (request.getParameter("discount").equals("Yes"))
		{
			total=total-(total*(discountnum/100));
			
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		else if (request.getParameter("discount").equals("No"))
		{
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		
		Statement change2 = connection.createStatement();
		String updateClass2 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);	
	}
	
	if (changeclass.equals("2"))
	{
		String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
		String classtype2 = request.getParameter("classtype2r") == null ? "" : request.getParameter("classtype2r");
		String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
		
		Statement sqlStatement = connection.createStatement();
		
		String text= "select t.* "+"from Trips t "+"where t.tripid='"+request.getParameter("tripid")+"'";
		ResultSet result2 = sqlStatement.executeQuery(text);
		result2.first();

		double discountnum=result2.getFloat("ecddiscount");
		double roundtrip=result2.getFloat("roundtripdiscount");
		double total=0;
		
		if(classtype.equals("economy"))
		{
			total=result2.getFloat("economyfare");
		}
		else if (classtype.equals("business"))
		{
			total=result2.getFloat("businessfare");
		}
		else if (classtype.equals("first"))
		{
			total=result2.getFloat("firstfare");
		}

		Statement sqlStatement1 = connection.createStatement();
		
		String text1= "select t.* "+"from Trips t "+"and t.tripid='"+request.getParameter("tripid2")+"'";
		ResultSet result3 = sqlStatement1.executeQuery(text1);
		result3.first();
		double discountnum1=result3.getFloat("ecddiscount");
		double roundtrip1=result3.getFloat("roundtripdiscount");
		
		if (discountnum>discountnum1)
		{
			discountnum=discountnum1;
		}
		
		if (roundtrip>roundtrip1)
		{
			roundtrip=roundtrip1;
		}
		
		
		if(classtype2.equals("economy"))
		{
			total+=result3.getFloat("economyfare");
		}
		else if (classtype2.equals("business"))
		{
			total+=result3.getFloat("businessfare");
		}
		else if (classtype2.equals("first"))
		{
			total+=result3.getFloat("firstfare");
		}
		
		total=total-(total*(roundtrip/100));
		
		double farepicked=total/2;
		
		Statement change = connection.createStatement();
		String updateFare = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "farepicked='" + farepicked + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change.executeUpdate(updateFare);
		
		Statement changeClass = connection.createStatement();
		String updateClass = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "class='" + request.getParameter("classtype") + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "' and tripid='"+request.getParameter("tripid")+"'";
		changeClass.executeUpdate(updateClass);
		
		total=total+(total*(.1));////Added booking fee-10% 	
			
		if (request.getParameter("discount").equals("Yes"))
		{
			total=total-(total*(discountnum/100));
			
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		else if (request.getParameter("discount").equals("No"))
		{
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		
		Statement change2 = connection.createStatement();
		String updateClass2 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);	
	}
	
	if (changeclass.equals("3"))
	{
		String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
		String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
		String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
		String date = request.getParameter("date") == null ? "" : request.getParameter("date");
		String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");


		
		Statement sql3 = connection.createStatement();
		ResultSet money = sql3.executeQuery("select count(tripid), max(economyfare), max(businessfare), max(firstfare), max(ecddiscount), max(weekdiscount) "+
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
		
		money.first();

		double eco$=money.getFloat("max(economyfare)");
		double bus$=money.getFloat("max(businessfare)");
		double fir$=money.getFloat("max(firstfare)");
		double week$=money.getFloat("max(weekdiscount)");
		double disabilitydiscount$=money.getFloat("max(ecddiscount)");
		double total=0;
		
		if (classtype.equals("economy"))
		{
			total=eco$;
		}
		else if (classtype.equals("business"))
		{
			total=bus$;
		}
		else if (classtype.equals("first"))
		{
				total=fir$;
		}
		
		total=total*10;
		total=total-(total*(week$/100));
		
		double individualfare=total/money.getFloat("count(tripid)");
		
		Statement change = connection.createStatement();
		String updateClass = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "class='" + classtype + "', " +
				   "farepicked='" + individualfare + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change.executeUpdate(updateClass);
		
		total=total+(total*(.1));////Added booking fee-10% 
		
		if (discount.equals("Yes"))
		{
			total=total-(total*(disabilitydiscount$/100));
			
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		else if (discount.equals("No"))
		{
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);	
		}
		
		Statement change2 = connection.createStatement();
		String updateClass2 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);
		
	}
	
	if (changeclass.equals("4"))
	{
		String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
		String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
		String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
		String date = request.getParameter("date") == null ? "" : request.getParameter("date");
		String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");


		
		Statement sql3 = connection.createStatement();
		ResultSet money = sql3.executeQuery("select count(tripid), max(economyfare), max(businessfare), max(firstfare), max(ecddiscount), max(monthdiscount) "+
				"from "+
				"(SELECT t.* "+
				"from Trips t "+
				"where t.SourceStationID='"+origin+"' "+
				"and t.destinationstationid='"+destination+"' "+
				"and t.starttime>'"+date+"' "+
				"and t.starttime<DATE_ADD('"+date+"', INTERVAL 1 Month) "+
				"union "+
				"SELECT t.* "+
				"from Trips t "+
				"where t.SourceStationID='"+destination+"' "+
				"and t.destinationstationid='"+origin+"' "+
				"and t.starttime>'"+date+"' "+
				"and t.starttime<DATE_ADD('"+date+"', INTERVAL 1 Month)) as alltrips;");
		
		money.first();

		double eco$=money.getFloat("max(economyfare)");
		double bus$=money.getFloat("max(businessfare)");
		double fir$=money.getFloat("max(firstfare)");
		double week$=money.getFloat("max(monthdiscount)");
		double disabilitydiscount$=money.getFloat("max(ecddiscount)");
		double total=0;
		
		if (classtype.equals("economy"))
		{
			total=eco$;
		}
		else if (classtype.equals("business"))
		{
			total=bus$;
		}
		else if (classtype.equals("first"))
		{
				total=fir$;
		}
		
		total=total*10;
		total=total-(total*(week$/100));
		
		double individualfare=total/money.getFloat("count(tripid)");
		
		Statement change = connection.createStatement();
		String updateClass = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "class='" + classtype + "', " +
				   "farepicked='" + individualfare + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change.executeUpdate(updateClass);
		
		total=total+(total*(.1));////Added booking fee-10% 
		
		if (discount.equals("Yes"))
		{
			total=total-(total*(disabilitydiscount$/100));
			
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);
		}
		else if (discount.equals("No"))
		{
			Statement change3 = connection.createStatement();
			String updateClass3 = "UPDATE Reservations " + 
					   "SET " +
					   "disability_agestatus='" + request.getParameter("discount") + "' " +
					   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
			change3.executeUpdate(updateClass3);	
		}
		
		Statement change2 = connection.createStatement();
		String updateClass2 = "UPDATE Reservations " + 
				   "SET " +
				   "total_fare='" + total + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "';";
		change2.executeUpdate(updateClass2);
		
	}
	
	
//////

/////CHANGE SEAT
	String changeseat = request.getParameter("changeseat") == null ? "" : request.getParameter("changeseat");
	if(changeseat.equals("1"))
	{
		Statement change = connection.createStatement();
		String updateseat = "UPDATE Multivalue_Reservations_Trips " + 
				   "SET " +
				   "seatid='" + request.getParameter("seatid") + "' " +
				   "WHERE reservationid='" + request.getParameter("reservationid") + "' and tripid='"+request.getParameter("tripid")+"' ";
		change.executeUpdate(updateseat);	
	}
//////

////////RESERVATION INFO		
	Statement statement = connection.createStatement();
	ResultSet customer=statement.executeQuery("select c.firstname, c.lastname, c.email, r.rtype, r.disability_agestatus "+
			"from Customers c, Reservations r "+
			"where r.customeremail=c.email "+
			"and r.reservationid='"+reservationid+"'");
	customer.first();
	String rtype=customer.getString("rtype");
	String disabilitystatus=customer.getString("disability_agestatus");
/////HEADER FORMAT.	
	%>
	
	<b>Customer Name: <%=customer.getString("firstname")%> <%=customer.getString("lastname")%> </b>
	<br/>
	<b>Customer Email: <%=customer.getString("email")%> </b>
	<br/>
	<b>Reservation ID: <%=reservationid%> </b>
	<br/>
	<br/>
	<br/>

	<% 
//////ONE WAY		
		if(rtype.equals("One-Way"))
		{
		%>
			<u>View One-Way Reservation Details</u>
			
			<table cellpadding="3px" border="1px" solid black>
			<tr>
			<br/>
			<br/>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Train Line and Number</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Class</th>
			<th>Seat Number</th>
			<th>Total Fare</th>
			<th>Customer Representative ID (If Helped)</th>
			</tr>	
		<% 
			Statement statement1 = connection.createStatement();
			ResultSet oneway=statement1.executeQuery("select r.reservationid, date_format(r.reservationdate,'%H:%i %p %m/%d/%Y') as rtime, ro.name, t.trainid, "+
					"s.stationname, s.city, s.state, s2.stationname, s2.city, s2.state, t.starttime, t.endtime, t.routeid, ts.seats, t.tripid, "+ 
					"date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, m.class, m.seatid, r.total_fare "+
					"from Reservations r, Trips t, Stations s, Stations s2, Routes ro, Multivalue_Reservations_Trips m, Trains ts "+
					"where r.reservationid=m.reservationid "+
					"and m.tripid=t.tripid and t.routeid=ro.routeid and t.trainid=ts.trainid "+
					"and t.sourcestationid=s.stationid and t.destinationstationid=s2.stationid "+
					"and r.reservationid='"+reservationid+"'");
			
			Statement statement2 = connection.createStatement();
			ResultSet csrid=statement2.executeQuery("select e.csrid from Employees e, Reservations r where r.csrssn=e.ssn "+
					"and r.reservationid='"+reservationid+"'");
			String cs;
			if(!csrid.next())
			{
				cs="";
			}
			else
			{
				csrid.first();
				cs=csrid.getString("csrid");
			}
			
	
			
			while(oneway.next())
			{
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Name") + " "+ oneway.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Seatid") + "</td>"
							  +"<td style='text-align:center'>" + "$" +oneway.getObject("Total_Fare") + "</td>"
							  +"<td style='text-align:center'>" + cs + "</td>";
				out.println(html);
			}
			oneway.first();
			String classtype=oneway.getString("class");
			String trainid=oneway.getString("trainid");
			String starttime=oneway.getString("t.starttime");
			String endtime=oneway.getString("t.endtime");
			String routeid=oneway.getString("t.routeid");
			int availableseats=oneway.getInt("ts.seats");
			String tripid=oneway.getString("t.tripid");
			%>
				<table>
				<br/>
				Customer had a discount for child/senior/disability status: <%=disabilitystatus %>
				<br/>
				<br/>
				<u>Edit Info</u>
				<br/>
				<br/>
				
				Change Customer Details: 
				<form method="post" action="EditCustomerInfo_CSR.jsp">
					<input type='hidden' name="email" value=<%=customer.getString("email")%>>
					<input type='hidden' name="rid" value=<%=reservationid%>>
					<input type="submit" value="Edit Customer Information">
				</form>
				<br/>
				<br/>
				
				Transfer Ticket to Another Customer
				<br/>
				<form method="post" action="EditReservationInfo.jsp?transferticket=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Please add the customer's email here: <input type="text" name="email"> <input type="submit" value="Transfer Ticket">
				</form>
				<br/>
				<br/>
				<form method="post" action="EditReservationInfo.jsp?changefare=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Change the Total Fare: <input type="number" step=".01" name="edittotalfare"> <input type="submit" value="Change Total Fare">
				</form>
				<br/>
				<br/>
				
				Upgrade/Downgrade the Class of the Ticket
				<form method="post" action="EditReservationInfo.jsp?changeclass=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="tripid" value=<%=tripid%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				
					<select name="classtype" size=1>
					<%
						if (classtype.equals("economy"))
						{
					%>
						<option value="economy" selected>Economy</option>
					<%
						}
						else
						{
					%>
		 				<option value="economy">Economy</option>
					<%  } %>
					<%
						if (classtype.equals("business"))
						{
					%>
						<option value="business" selected>Business</option>
					<%
						}
						else
						{
					%>
		 				<option value="business">Business</option>
					<%  } %>
					<%
						if (classtype.equals("first"))
						{
					%>
						<option value="first" selected>First</option>
					<%
						}
						else
						{
					%>
		 				<option value="first">First</option>
					<%  } %>
					</select>
					<input type="submit" value="Change Class">
				</form>
				<br/>
				<br/>
				
				Change Seat Number:
				<%
				///Get the route and the start and end for that route.
				Statement statement4 = connection.createStatement();
				ResultSet getBigRouteTripID = statement4.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
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
				
				%>
					<form method="post" action="EditReservationInfo.jsp?changeseat=1">
					<input type='hidden' name="reservationid" value=<%=reservationid%>>
					<input type='hidden' name="tripid" value=<%=tripid%>>
					<select name="seatid" size=1>
				<% 
					for(int x=0; x<emptyseats.size();x++)
					{
					
				%>	
						<option value=<%=emptyseats.get(x)%>><%=emptyseats.get(x)%></option>
				<%  } %>
					</select>
					<input type="submit" value="Make Changes">
					</form>
				
				<%
					
				
				
				%>
				<br/>
				<br/>
		
		
				Add or Remove Child/Senior/Disability Discount:
				
				<form method="post" action="EditReservationInfo.jsp?changeclass=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="tripid" value=<%=tripid%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<select name="discount" size=1>
					<option value="No" selected>Remove</option>
					<option value="Yes" selected>Add</option>
				</select>
				<input type="submit" value="Make Changes">
				</form>
				<br/>
				<br/>
				
				<form method="post" action="EditOneWayRoundTrip.jsp">
					<input type='hidden' name="reservationid" value=<%=reservationid%>>
					<input type='hidden' name="tripid" value=<%=tripid%>>
					Modify Origin/Destination and/or Trip Times: <input type="submit" value="Find New Train Trip">
				</form>
				
			<%
	
		
		
/////////////////					
		}
	
	
//////////////ROUND TRIP
		if(rtype.equals("Round Trip"))
		{
		%>
			<u>View Round Trip Reservation Details</u>	
			
			<table cellpadding="3px" border="1px" solid black>
			<tr>
			<br/>
			<br/>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Train Line and Number</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Class</th>
			<th>Seat Number</th>
			</tr>	
		<% 
			Statement statement1 = connection.createStatement();
			ResultSet oneway=statement1.executeQuery("select r.reservationid, date_format(r.reservationdate,'%H:%i %p %m/%d/%Y') as rtime, ro.name, t.trainid, "+
				"s.stationname, s.city, s.state, s2.stationname, s2.city, s2.state, t.starttime, t.endtime, t.routeid, ts.seats, t.tripid, "+ 
				"date_format(t.starttime,'%H:%i %p %m/%d/%Y') as starttime1, date_format(t.endtime,'%H:%i %p %m/%d/%Y') as endtime1, m.class, m.seatid, r.total_fare "+
				"from Reservations r, Trips t, Stations s, Stations s2, Routes ro, Multivalue_Reservations_Trips m, Trains ts "+
				"where r.reservationid=m.reservationid "+
				"and m.tripid=t.tripid and t.routeid=ro.routeid and t.trainid=ts.trainid "+
				"and t.sourcestationid=s.stationid and t.destinationstationid=s2.stationid "+
				"and r.reservationid='"+reservationid+"' order by starttime asc");
			
			Statement statement2 = connection.createStatement();
			ResultSet csrid=statement2.executeQuery("select e.csrid from Employees e, Reservations r where r.csrssn=e.ssn "+
					"and r.reservationid='"+reservationid+"'");
			String cs;
			if(!csrid.next())
			{
				cs="";
			}
			else
			{
				csrid.first();
				cs=csrid.getString("csrid");
			}
			
			while(oneway.next()){
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Name") + " "+ oneway.getObject("Trainid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime1") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Seatid") + "</td>";
				out.println(html);
			}
			///departure trip
			oneway.first();
			String classtype=oneway.getString("class");
			String trainid=oneway.getString("trainid");
			String starttime=oneway.getString("t.starttime");
			String endtime=oneway.getString("t.endtime");
			String routeid=oneway.getString("t.routeid");
			int availableseats=oneway.getInt("ts.seats");
			String tripid=oneway.getString("t.tripid");
			String totalfare=oneway.getString("r.total_fare");
			
			//return trip
			oneway.next();
			String classtype2r=oneway.getString("class");
			String trainid2r=oneway.getString("trainid");
			String starttime2r=oneway.getString("t.starttime");
			String endtime2r=oneway.getString("t.endtime");
			String routeid2r=oneway.getString("t.routeid");
			int availableseats2r=oneway.getInt("ts.seats");
			String tripid2r=oneway.getString("t.tripid");
			%>
			
				<table>
				<br/>
				Total Fare: $<%=totalfare %>
				<br/>
				Customer had a discount for child/senior/disability status: <%=disabilitystatus %>
				<br/>
				Customer Representative ID (If Helped): <%=cs %>
				<br/>
				<br/>
				<u>Edit Info</u>
				<br/>
				<br/>
				
				Change Customer Details: 
				<form method="post" action="EditCustomerInfo_CSR.jsp">
					<input type='hidden' name="email" value=<%=customer.getString("email")%>>
					<input type='hidden' name="rid" value=<%=reservationid%>>
					<input type="submit" value="Edit Customer Information">
				</form>
				<br/>
				<br/>
				
				Transfer Ticket to Another Customer
				<br/>
				<form method="post" action="EditReservationInfo.jsp?transferticket=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Please add the customer's email here: <input type="text" name="email"> <input type="submit" value="Transfer Ticket">
				</form>
				<br/>
				<br/>
				
				<form method="post" action="EditReservationInfo.jsp?changefare=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Change the Total Fare: <input type="number" step=".01" name="edittotalfare"> <input type="submit" value="Change Total Fare">
				</form>
				<br/>
				<br/>
				
				Upgrade/Downgrade the Class of the Departure Ticket
				<form method="post" action="EditReservationInfo.jsp?changeclass=2">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="tripid" value=<%=tripid%>>
				<input type='hidden' name="tripid2" value=<%=tripid2r%>>
				<input type='hidden' name="classtype2r" value=<%=classtype2r%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				
					<select name="classtype" size=1>
					<%
						if (classtype.equals("economy"))
						{
					%>
						<option value="economy" selected>Economy</option>
					<%
						}
						else
						{
					%>
		 				<option value="economy">Economy</option>
					<%  } %>
					<%
						if (classtype.equals("business"))
						{
					%>
						<option value="business" selected>Business</option>
					<%
						}
						else
						{
					%>
		 				<option value="business">Business</option>
					<%  } %>
					<%
						if (classtype.equals("first"))
						{
					%>
						<option value="first" selected>First</option>
					<%
						}
						else
						{
					%>
		 				<option value="first">First</option>
					<%  } %>
					</select>
					<input type="submit" value="Change Class">
				</form>
				<br/>
				<br/>
				
				Change Seat Number of Departure Ticket:
				<%
				///Get the route and the start and end for that route.
				Statement statement4 = connection.createStatement();
				ResultSet getBigRouteTripID = statement4.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
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
				
				%>
					<form method="post" action="EditReservationInfo.jsp?changeseat=1">
					<input type='hidden' name="reservationid" value=<%=reservationid%>>
					<input type='hidden' name="tripid" value=<%=tripid%>>
					<select name="seatid" size=1>
				<% 
					for(int x=0; x<emptyseats.size();x++)
					{
					
				%>	
						<option value=<%=emptyseats.get(x)%>><%=emptyseats.get(x)%></option>
				<%  } %>
					</select>
					<input type="submit" value="Make Changes">
					</form>
				
				<%
					
				
				
				%>
				<br/>
				<br/>
				
				
				Upgrade/Downgrade the Class of the Arrival Ticket
				<form method="post" action="EditReservationInfo.jsp?changeclass=2">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="tripid" value=<%=tripid2r%>>
				<input type='hidden' name="tripid2" value=<%=tripid%>>
				<input type='hidden' name="classtype2r" value=<%=classtype%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				
					<select name="classtype" size=1>
					<%
						if (classtype2r.equals("economy"))
						{
					%>
						<option value="economy" selected>Economy</option>
					<%
						}
						else
						{
					%>
		 				<option value="economy">Economy</option>
					<%  } %>
					<%
						if (classtype2r.equals("business"))
						{
					%>
						<option value="business" selected>Business</option>
					<%
						}
						else
						{
					%>
		 				<option value="business">Business</option>
					<%  } %>
					<%
						if (classtype2r.equals("first"))
						{
					%>
						<option value="first" selected>First</option>
					<%
						}
						else
						{
					%>
		 				<option value="first">First</option>
					<%  } %>
					</select>
					<input type="submit" value="Change Class">
				</form>
				<br/>
				<br/>
				
				Change Seat Number of Arrival Ticket:
				<%
				///Get the route and the start and end for that route.
				Statement statement42r = connection.createStatement();
				ResultSet getBigRouteTripID2r = statement42r.executeQuery("select t.*, TIMESTAMPDIFF(minute, t.starttime, t.endtime) "+
						"from Trips t "+
						"where t.tripid = any "+
						"(select tripid "+
						"from Trips "+
						"where trainid='"+trainid2r+"' "+
						"and routeid='"+routeid2r+"' "+
						"and starttime<='"+starttime2r+"' "+
						"and endtime>='"+endtime2r+"' "+
						")group by TIMESTAMPDIFF(minute, t.starttime, t.endtime) desc;");
				
				getBigRouteTripID2r.first();
				String BigRouteTripID2r=getBigRouteTripID2r.getString("tripid");
				String trainid22r=getBigRouteTripID2r.getString("trainid");
				String routeid22r=getBigRouteTripID2r.getString("routeid");
				String starttime22r=getBigRouteTripID2r.getString("starttime");
				String endtime22r=getBigRouteTripID2r.getString("endtime");
				
			////
				
				
				//First find available seats
				Statement statement52r = connection.createStatement();
				ResultSet getusedseats2r=statement52r.executeQuery("select m.seatid "+
						"from Trips t, Multivalue_Reservations_Trips m "+
						"where t.tripid=m.tripid "+
						"and trainid='"+ trainid22r+"' "+
						"and routeid='"+ routeid22r+"' "+
						"and starttime>='"+ starttime22r+"' "+
						"and endtime<='"+ endtime22r+"'");
				ArrayList<String> usedseats2r = new ArrayList<String>();
				
				while(getusedseats2r.next())
				{
					usedseats2r.add(getusedseats2r.getString("m.seatid"));
				}
				
				ArrayList<String> emptyseats2r = new ArrayList<String>();
				
				for(int x=1; x<=availableseats2r;x++)
				{
					if(!usedseats2r.contains(x+""))
						emptyseats2r.add(x+"");
				}
				
				%>
					<form method="post" action="EditReservationInfo.jsp?changeseat=1">
					<input type='hidden' name="reservationid" value=<%=reservationid%>>
					<input type='hidden' name="tripid" value=<%=tripid2r%>>
					<select name="seatid" size=1>
				<% 
					for(int x=0; x<emptyseats2r.size();x++)
					{
					
				%>	
						<option value=<%=emptyseats2r.get(x)%>><%=emptyseats2r.get(x)%></option>
				<%  } %>
					</select>
					<input type="submit" value="Make Changes">
					</form>
				
				<br/>
				<br/>

		
				Add or Remove Child/Senior/Disability Discount:
				
				<form method="post" action="EditReservationInfo.jsp?changeclass=2">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="tripid" value=<%=tripid%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<input type='hidden' name="tripid2" value=<%=tripid2r%>>
				<input type='hidden' name="classtype2r" value=<%=classtype2r%>>
				<select name="discount" size=1>
					<option value="No" selected>Remove</option>
					<option value="Yes" selected>Add</option>
				</select>
				<input type="submit" value="Make Changes">
				</form>
				<br/>
				<br/>
				
				<form method="post" action="EditRoundTrip.jsp">
					<input type='hidden' name="reservationid" value=<%=reservationid%>>
					<input type='hidden' name="tripid" value=<%=tripid%>>
					<input type='hidden' name="tripid2" value=<%=tripid2r%>>
					Modify Origin/Destination and/or Trip Times: <input type="submit" value="Find New Train Trip">
				</form>
			
			
			<%
		
//////////////////	
		}





////////////////////WEEKLY		
		if(rtype.equals("Weekly"))
		{
		%>
			<u>View Weekly Reservation Details</u>
			<table cellpadding="3px" border="1px" solid black>
			<tr>
			<br/>
			<br/>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>First Day To Use Ticket</th>
			<th>Last Day To Use Ticket</th>
			<th>Class</th>
			<th>Total Fare</th>
			<th>Customer Representative ID (If Helped)</th>
			</tr>	
		<% 
			Statement statement1 = connection.createStatement();
			ResultSet oneway=statement1.executeQuery("select r.reservationid, date_format(r.reservationdate,'%H:%i %p %m/%d/%Y') as rtime, "+
					"s.stationid, s.stationname, s.city, s.state, s2.stationid, s2.stationname, s2.city, s2.state, "+ 
					"r.startdate, date_format(r.startdate, '%m/%d/%Y') as starttime, DATE_FORMAT(DATE_ADD(r.startdate,INTERVAL 7 DAY), '%m/%d/%Y') as endtime, m.class, m.seatid, r.total_fare "+
					"from Reservations r, Trips t, Stations s, Stations s2, Routes ro, Multivalue_Reservations_Trips m "+
					"where r.reservationid=m.reservationid "+
					"and m.tripid=t.tripid and t.routeid=ro.routeid "+
					"and t.sourcestationid=s.stationid and t.destinationstationid=s2.stationid "+
					"and r.reservationid='"+reservationid+"'");
			
			Statement statement2 = connection.createStatement();
			ResultSet csrid=statement2.executeQuery("select e.csrid from Employees e, Reservations r where r.csrssn=e.ssn "+
					"and r.reservationid='"+reservationid+"'");
			String cs;
			if(!csrid.next())
			{
				cs="";
			}
			else
			{
				csrid.first();
				cs=csrid.getString("csrid");
			}
			
			if(oneway.next()){
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + "$" +oneway.getObject("Total_Fare") + "</td>"
							  +"<td style='text-align:center'>" + cs + "</td>";
				out.println(html);
			} 	
			oneway.first();
			String classtype=oneway.getString("class");
			String origin=oneway.getString("s.stationid");
			String destination=oneway.getString("s2.stationid");
			String date=oneway.getString("r.startdate");
			
			%>
				<table>
				<br/>
				Customer had a discount for child/senior/disability status: <%=disabilitystatus %>
				<br/>
				<br/>
				<u>Edit Info</u>
				<br/>
				<br/>
				
				Change Customer Details: 
				<form method="post" action="EditCustomerInfo_CSR.jsp">
					<input type='hidden' name="email" value=<%=customer.getString("email")%>>
					<input type='hidden' name="rid" value=<%=reservationid%>>
					<input type="submit" value="Edit Customer Information">
				</form>
				<br/>
				<br/>
				Transfer Ticket to Another Customer
				<br/>
				<form method="post" action="EditReservationInfo.jsp?transferticket=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Please add the customer's email here: <input type="text" name="email"> <input type="submit" value="Transfer Ticket">
				</form>
				<br/>
				<br/>
				<form method="post" action="EditReservationInfo.jsp?changefare=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Change the Total Fare: <input type="number" step=".01" name="edittotalfare"> <input type="submit" value="Change Total Fare">
				</form>
				<br/>
				<br/>
				
				Upgrade/Downgrade the Class of the Ticket
				<form method="post" action="EditReservationInfo.jsp?changeclass=3">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="origin" value=<%=origin%>>
				<input type='hidden' name="destination" value=<%=destination%>>
				<input type='hidden' name="date" value=<%=date%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				
					<select name="classtype" size=1>
					<%
						if (classtype.equals("economy"))
						{
					%>
						<option value="economy" selected>Economy</option>
					<%
						}
						else
						{
					%>
		 				<option value="economy">Economy</option>
					<%  } %>
					<%
						if (classtype.equals("business"))
						{
					%>
						<option value="business" selected>Business</option>
					<%
						}
						else
						{
					%>
		 				<option value="business">Business</option>
					<%  } %>
					<%
						if (classtype.equals("first"))
						{
					%>
						<option value="first" selected>First</option>
					<%
						}
						else
						{
					%>
		 				<option value="first">First</option>
					<%  } %>
					</select>
					<input type="submit" value="Change Class">
				</form>
				<br/>
				<br/>
				
				Add or Remove Child/Senior/Disability Discount:
				<form method="post" action="EditReservationInfo.jsp?changeclass=3">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="origin" value=<%=origin%>>
				<input type='hidden' name="destination" value=<%=destination%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<input type='hidden' name="date" value=<%=date%>>
				<select name="discount" size=1>
					<option value="No" selected>Remove</option>
					<option value="Yes" selected>Add</option>
				</select>
				<input type="submit" value="Make Changes">
				</form>
				<br/>
				<br/>
				
				Edit Travel Info:
				<form method="post" action="EditReservationInfo.jsp?changetravel=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				<br/>
				
				Select New Origin Station: 
	
				<%
				try{

					Statement sqlStatement = connection.createStatement();
			
					String sqlText=("select * from Stations");
					ResultSet result = sqlStatement.executeQuery(sqlText);
				%>	
	
	
				<select name="origin" size=1>
				<%
				while(result.next())
				{
					String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
		
					%>
					<option value="<%=result.getString("StationID") %>"><%=train %></option>
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
			
				Select New Destination Station: 
		
				<%
				try{
	
					Statement sqlStatement = connection.createStatement();
					String sqlText=("select * from Stations");
					ResultSet result = sqlStatement.executeQuery(sqlText);
				%>	
	
				<select name="destination" size=1>
				<%
				while(result.next())
				{
				String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
				%>
					<option value="<%=result.getString("StationID") %>"><%=train %></option>
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
		
		
		Select New Travel Date
		<input type="date" id="start" name="triptime" min="2020-01-01" max="2020-12-31">
		<br/>
			
		<input type="submit" value="Change Trip">
		</form>
			
			<%
			
///////////////////			
		}


////////MONTHLY
		if(rtype.equals("Monthly"))
		{
		%>
			<u>View Monthly Reservation Details</u>
				<table cellpadding="3px" border="1px" solid black>
			<tr>
			<br/>
			<br/>
			<th>Reservation ID</th>
			<th>Date/Time Reservation Was Made</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>First Day To Use Ticket</th>
			<th>Last Day To Use Ticket</th>
			<th>Class</th>
			<th>Total Fare</th>
			<th>Customer Representative ID (If Helped)</th>
			</tr>	
		<% 
			Statement statement1 = connection.createStatement();
			ResultSet oneway=statement1.executeQuery("select r.reservationid, date_format(r.reservationdate,'%H:%i %p %m/%d/%Y') as rtime, "+
					"s.stationname, s.city, s.state, s2.stationname, s2.city, s2.state, s.stationid, s2.stationid, r.startdate, "+ 
					"date_format(r.startdate, '%m/%d/%Y') as starttime, DATE_FORMAT(DATE_ADD(DATE_ADD(r.startdate,INTERVAL 1 Month), interval -1 day), '%m/%d/%Y') as endtime, m.class, m.seatid, r.total_fare "+
					"from Reservations r, Trips t, Stations s, Stations s2, Routes ro, Multivalue_Reservations_Trips m "+
					"where r.reservationid=m.reservationid "+
					"and m.tripid=t.tripid and t.routeid=ro.routeid "+
					"and t.sourcestationid=s.stationid and t.destinationstationid=s2.stationid "+
					"and r.reservationid='"+reservationid+"'");
			
			Statement statement2 = connection.createStatement();
			ResultSet csrid=statement2.executeQuery("select e.csrid from Employees e, Reservations r where r.csrssn=e.ssn "+
					"and r.reservationid='"+reservationid+"'");
			String cs;
			if(!csrid.next())
			{
				cs="";
			}
			else
			{
				csrid.first();
				cs=csrid.getString("csrid");
			}
			
			if(oneway.next()){
				String html = "<tr>" + 
							   "<td style='text-align:center'>" + oneway.getObject("r.reservationid") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("rtime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s.stationname") +": "+ oneway.getObject("s.city") +", "+ oneway.getObject("s.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("s2.stationname") +": "+ oneway.getObject("s2.city") +", "+ oneway.getObject("s2.state")+"</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("StartTime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("EndTime") + "</td>"
							  +"<td style='text-align:center'>" + oneway.getObject("Class") + "</td>"
							  +"<td style='text-align:center'>" + "$" +oneway.getObject("Total_Fare") + "</td>"
							  +"<td style='text-align:center'>" + cs + "</td>";
				out.println(html);
			} 
			oneway.first();
			String classtype=oneway.getString("class");
			String origin=oneway.getString("s.stationid");
			String destination=oneway.getString("s2.stationid");
			String date=oneway.getString("r.startdate");
			
			%>
				<table>
				<br/>
				Customer had a discount for child/senior/disability status: <%=disabilitystatus %>
				<br/>
				<br/>
				<u>Edit Info</u>
				<br/>
				<br/>
				
				Change Customer Details: 
				<form method="post" action="EditCustomerInfo_CSR.jsp">
					<input type='hidden' name="email" value=<%=customer.getString("email")%>>
					<input type='hidden' name="rid" value=<%=reservationid%>>
					<input type="submit" value="Edit Customer Information">
				</form>
				<br/>
				<br/>
				Transfer Ticket to Another Customer
				<br/>
				<form method="post" action="EditReservationInfo.jsp?transferticket=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Please add the customer's email here: <input type="text" name="email"> <input type="submit" value="Transfer Ticket">
				</form>
				<br/>
				<br/>
				<form method="post" action="EditReservationInfo.jsp?changefare=1">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
					Change the Total Fare: <input type="number" step=".01" name="edittotalfare"> <input type="submit" value="Change Total Fare">
				</form>
				<br/>
				<br/>
				
				Upgrade/Downgrade the Class of the Ticket
				<form method="post" action="EditReservationInfo.jsp?changeclass=4">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="origin" value=<%=origin%>>
				<input type='hidden' name="destination" value=<%=destination%>>
				<input type='hidden' name="date" value=<%=date%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				
					<select name="classtype" size=1>
					<%
						if (classtype.equals("economy"))
						{
					%>
						<option value="economy" selected>Economy</option>
					<%
						}
						else
						{
					%>
		 				<option value="economy">Economy</option>
					<%  } %>
					<%
						if (classtype.equals("business"))
						{
					%>
						<option value="business" selected>Business</option>
					<%
						}
						else
						{
					%>
		 				<option value="business">Business</option>
					<%  } %>
					<%
						if (classtype.equals("first"))
						{
					%>
						<option value="first" selected>First</option>
					<%
						}
						else
						{
					%>
		 				<option value="first">First</option>
					<%  } %>
					</select>
					<input type="submit" value="Change Class">
				</form>
				<br/>
				<br/>
				
				Add or Remove Child/Senior/Disability Discount:
				<form method="post" action="EditReservationInfo.jsp?changeclass=4">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="origin" value=<%=origin%>>
				<input type='hidden' name="destination" value=<%=destination%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<input type='hidden' name="date" value=<%=date%>>
				<select name="discount" size=1>
					<option value="No" selected>Remove</option>
					<option value="Yes" selected>Add</option>
				</select>
				<input type="submit" value="Make Changes">
				</form>
				<br/>
				<br/>
				
				Edit Travel Info:
				<form method="post" action="EditReservationInfo.jsp?changetravel=2">
				<input type='hidden' name="reservationid" value=<%=reservationid%>>
				<input type='hidden' name="classtype" value=<%=classtype%>>
				<input type='hidden' name="discount" value=<%=disabilitystatus%>>
				<br/>
				
				Select New Origin Station: 
	
				<%
				try{

					Statement sqlStatement = connection.createStatement();
			
					String sqlText=("select * from Stations");
					ResultSet result = sqlStatement.executeQuery(sqlText);
				%>	
	
	
				<select name="origin" size=1>
				<%
				while(result.next())
				{
					String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
		
					%>
					<option value="<%=result.getString("StationID") %>"><%=train %></option>
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
			
				Select New Destination Station: 
		
				<%
				try{
	
					Statement sqlStatement = connection.createStatement();
					String sqlText=("select * from Stations");
					ResultSet result = sqlStatement.executeQuery(sqlText);
				%>	
	
				<select name="destination" size=1>
				<%
				while(result.next())
				{
				String train = result.getString("StationName") +": " + result.getString("city") + ", "+ result.getString("state"); 
				%>
					<option value="<%=result.getString("StationID") %>"><%=train %></option>
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
		
		
		Select New Travel Date
		<input type="month" id="start" name="triptime" min="2020-01-01" max="2020-12-31">
		<br/>
			
		<input type="submit" value="Change Trip">
		</form>
			
			<%
			
			
//////////////			
		}
		db.closeConnection(connection);
	}
	catch (Exception e)
	{
		out.print("*ERROR: The train the customer was going to board has likely been cancelled.");
	}
	
	
	
	
	
	
	%>





	
</body>
</html>

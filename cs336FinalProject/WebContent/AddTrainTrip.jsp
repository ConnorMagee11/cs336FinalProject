<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Trip</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewTrainTrips.jsp">
		<input type="submit" value="Back to all Train Info">
	</form>
	<h2>Add Train Trip</h2>
	Reminder: enter time in military format.
	<br/>
	<br/>
	<%
	
///Update Fields 	
		try{
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			
			String postback = request.getParameter("postback") == null ? "" : request.getParameter("postback");
			
			if(postback.equals("1")){

								
				try
				{
					if(request.getParameter("editdeparture").equals(request.getParameter("editarrival")))
					{
						out.print("Arrival and Departure Times need to be different");
					}
					else if(request.getParameter("editoriginid").equals(request.getParameter("editdestinationid")))
					{
						out.print("Origin and Destination need to be different");
					}
					else
					{
						
						Statement statement2 = connection.createStatement();
						ResultSet count=statement2.executeQuery("select count(tripid) from Trips "+
								"where trainid='"+request.getParameter("edittrainid")+"' "+
								"and routeid='"+request.getParameter("editrouteid")+"' "+
								"and starttime='"+request.getParameter("editdeparture")+"' "+
								"and endtime='"+request.getParameter("editarrival")+"'");
						count.first();
						
						String num=count.getString("count(tripid)");
						
						if(num.equals("1"))
						{
							out.print("A train with this schedule already exists. Please create a new one.");
						}
						else
						{
						
						ResultSet seats=statement.executeQuery("select seats from Trains where trainid='"+request.getParameter("edittrainid")+"';");
						seats.first();
						
						String tripupdate = "Insert into Trips (trainid, routeid, sourcestationid, destinationstationid, starttime, endtime, availableseats, economyfare, businessfare, firstfare, ecddiscount, roundtripdiscount, weekdiscount, monthdiscount) values ("+
								   "'" + request.getParameter("edittrainid") + "', " + 
								   "'" + request.getParameter("editrouteid") + "', " +
								   "'" + request.getParameter("editoriginid") + "', " +
								   "'" + request.getParameter("editdestinationid") + "', " + 
								   "'" + request.getParameter("editdeparture") + "', " +
								   "'" + request.getParameter("editarrival") + "', " +
								   "'" + seats.getInt("seats") + "', " +
								   "'" + request.getParameter("editeconomy") + "', " +
								   "'" + request.getParameter("editbusiness") + "', " +
								   "'" + request.getParameter("editfirst") + "', " +
								   "'" + request.getParameter("editecddiscount") + "', " +
								   "'" + request.getParameter("editroundtripdiscount") + "', " +
								   "'" + request.getParameter("editweeklydiscount") + "', " +
								   "'" + request.getParameter("editmonthlydiscount") + "')";
						statement.executeUpdate(tripupdate);
						response.sendRedirect("ViewTrainTrips.jsp");
						}
					}
					
					
					
					
					
					
				}
				catch (Exception e)
				{
					out.print("Please make sure that values are entered correctly");
					
				}		
			}

			
			
			
////View the fields to be changed 			
			
			Statement statement2 = connection.createStatement();
			ResultSet allTrainIDs=statement2.executeQuery("select trainid from Trains");
			
			Statement statement3 = connection.createStatement();
			ResultSet allRouteNames=statement3.executeQuery("select * from Routes");
			
			Statement statement4 = connection.createStatement();
			ResultSet allStationNames=statement4.executeQuery("select * from Stations");
			
			
			
	%>
				<form method="post" action="AddTrainTrip.jsp?postback=1">
					<input type="hidden" name="tripid" value=<%=request.getParameter("tripid") %>>
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>TrainID: </td>	
							<td>
							<select name="edittrainid" size=1>
							<%
							
							
							while(allTrainIDs.next())
							{
								String name = allTrainIDs.getString("Trainid"); 
								
							%>
								<option value="<%=name %>"><%=name %></option>
							<%
								
							}
							%>
							</select>
							
						</td>
						</tr>
						<tr>
							<td>Route Name: </td>
							<td>
							<select name="editrouteid" size=1>
							<%
							
							
							while(allRouteNames.next())
							{
								String name = allRouteNames.getString("name"); 
								String routeid = allRouteNames.getString("routeid"); 
								
							%>
								<option value="<%=routeid %>"><%=name %></option>
							<%
								
							}
							%>
							</select>
							
						</td>
						</tr>
						<tr>
							<td>Origin: </td>
							<td>
							<select name="editoriginid" size=1>
							<%
							
							
							while(allStationNames.next())
							{ 
								String stationid = allStationNames.getString("stationid"); 
								String name = allStationNames.getString("stationname")+": "+allStationNames.getString("city")+", "+allStationNames.getString("state");
								
								
							%>
								<option value="<%=stationid %>"><%=name %></option>
							<%
								
							}
							%>
							</select>
							
						</td>
						</tr>
						<tr>
							<td>Destination: </td>
							<td>
							<select name="editdestinationid" size=1>
							<%
							
							allStationNames.beforeFirst();
							while(allStationNames.next())
							{ 
								String stationid = allStationNames.getString("stationid"); 
								String name = allStationNames.getString("stationname")+": "+allStationNames.getString("city")+", "+allStationNames.getString("state");
								
								
							%>
								<option value="<%=stationid %>"><%=name %></option>
							<%
								
							}
							%>
							</select>
							
						</td>
						</tr>
						<tr>
							<td>Departure Date/Time: </td>
							<td><input type="text" name="editdeparture">  YYYY-MM-DD HH:MM</td>
						
						</tr>
						<tr>
							<td>Arrival Date/Time: </td>
							<td><input type="text" name="editarrival">  YYYY-MM-DD HH:MM</td>
						</tr>
						<tr>
							<td>One-Way Economy Fare: </td>
							<td><input type="text" name="editeconomy"></td>
						</tr>
						<tr>
							<td>One-Way Business Fare: </td>
							<td><input type="text" name="editbusiness"></td>
						</tr>
						<tr>
							<td>One-Way First Class Fare: </td>
							<td><input type="text" name="editfirst"></td>
						</tr>
						<tr>
							<td>Age/Disability Discount: </td>
							<td>
							<select name="editecddiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
							
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
							
							}
							%>
							</select>%
							
						</td>
						</tr>
						<tr>
							<td>Round Trip Discount: </td>
								<td>
							<select name="editroundtripdiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
								
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								
							}
							%>
							</select>%
							
						</td>
						</tr>
						<tr>
							<td>Weekly Discount: </td>
								<td>
							<select name="editweeklydiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
								
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								
							}
							%>
							</select>%
							
						</td>
						</tr>
						<tr>
							<td>Monthly Discount: </td>
							<td>
							<select name="editmonthlydiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
								
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								
							}
							%>
							</select>%
							
						</td>
						</tr>
						<tr>
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

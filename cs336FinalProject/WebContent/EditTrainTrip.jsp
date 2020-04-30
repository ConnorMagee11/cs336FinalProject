<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Train Info</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<form method="get" action="ViewTrainTrips.jsp">
		<input type="submit" value="Back to all Train Info">
	</form>
	<h2>Edit Train Trip</h2>
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
						String tripupdate = "UPDATE Trips " + "SET " +
								   "trainid='" + request.getParameter("edittrainid") + "', " + 
								   "routeid='" + request.getParameter("editrouteid") + "', " +
								   "starttime='" + request.getParameter("editdeparture") + "', " +
								   "endtime='" + request.getParameter("editarrival") + "' " +
								   "WHERE tripid='" + request.getParameter("tripid") + "'";
						statement.executeUpdate(tripupdate);
						
						Statement statement2 = connection.createStatement();
						ResultSet count=statement2.executeQuery("select count(tripid) from Trips "+
								"where trainid='"+request.getParameter("edittrainid")+"' "+
								"and routeid='"+request.getParameter("editrouteid")+"' "+
								"and starttime='"+request.getParameter("editdeparture")+"' "+
								"and endtime='"+request.getParameter("editarrival")+"'");
						count.first();
						
						String num=count.getString("count(tripid)");
						
						if(num.equals("2"))
						{
							String tripupdate3 = "UPDATE Trips " + "SET " +
									   "trainid='" + request.getParameter("trainid") + "', " + 
									   "routeid='" + request.getParameter("routeid") + "', " +
									   "starttime='" + request.getParameter("starttime") + "', " +
									   "endtime='" + request.getParameter("endtime") + "' " +
									   "WHERE tripid='" + request.getParameter("tripid") + "'";
							statement.executeUpdate(tripupdate3);
							out.print("A train with this schedule already exists");
							
						}
						else
						{
						
						
						
						String tripupdate2 = "UPDATE Trips " + "SET " +
								   "trainid='" + request.getParameter("edittrainid") + "', " + 
								   "routeid='" + request.getParameter("editrouteid") + "', " +
								   "sourcestationid='" + request.getParameter("editoriginid") + "', " +
								   "destinationstationid='" + request.getParameter("editdestinationid") + "', " + 
								   "starttime='" + request.getParameter("editdeparture") + "', " +
								   "endtime='" + request.getParameter("editarrival") + "', " +
								   "availableseats='" + request.getParameter("editseats") + "', " +
								   "economyfare='" + request.getParameter("editeconomy") + "', " +
								   "businessfare='" + request.getParameter("editbusiness") + "', " +
								   "firstfare='" + request.getParameter("editfirst") + "', " +
								   "ecddiscount='" + request.getParameter("editecddiscount") + "', " +
								   "roundtripdiscount='" + request.getParameter("editroundiscount") + "', " +
								   "weekdiscount='" + request.getParameter("editweeklydiscount") + "', " +
								   "monthdiscount='" + request.getParameter("editmonthlydiscount") + "' " +
								   "WHERE tripid='" + request.getParameter("tripid") + "'";
						statement.executeUpdate(tripupdate2);
						response.sendRedirect("ViewTrainTrips.jsp");
						}
					}
						
					
				}
				catch (Exception e)
				{
					//out.print("Please make sure all fields are entered correctly.");	
					out.print(e);
				}	
			}
			

			
			
			
////View the fields to be changed 			
			ResultSet results = statement.executeQuery("select ts.trainid, ts.cars, ts.seats, t.availableseats, r.routeid, r.name, s.stationid, s.stationname, s.city, s.state,"+
					" s2.stationid, s2.stationname, s2.city, s2.state, t.tripid, date_format(t.StartTime,'%Y-%m-%d %H:%i') as starttime, date_format(t.endtime,'%Y-%m-%d %H:%i') as endtime, t.economyfare,"+
					" t.businessfare, t.firstfare, t.ecddiscount, t.weekdiscount, t.monthdiscount, t.roundtripdiscount "+
					" from Trips t, Trains ts, Stations s, Stations s2, Routes r"+
					" where t.routeid=r.routeid"+
					" and t.trainid=ts.trainid"+
					" and t.sourcestationid=s.stationid"+
					" and t.tripid='"+ request.getParameter("tripid") + "'"+
					" and t.destinationstationid=s2.stationid");
			
			Statement statement2 = connection.createStatement();
			ResultSet allTrainIDs=statement2.executeQuery("select trainid from Trains");
			
			Statement statement3 = connection.createStatement();
			ResultSet allRouteNames=statement3.executeQuery("select * from Routes");
			
			Statement statement4 = connection.createStatement();
			ResultSet allStationNames=statement4.executeQuery("select * from Stations");
			
			
			if(results.next()){
	%>
				<form method="post" action="EditTrainTrip.jsp?postback=1">
					<input type="hidden" name="tripid" value=<%=request.getParameter("tripid") %>>
					<input type="hidden" name="trainid" value=<%=results.getString("trainid") %>>
					<input type="hidden" name="routeid" value=<%=results.getString("routeid") %>>
					<input type="hidden" name="starttime" value="<%=results.getObject("starttime") %>">
					<input type="hidden" name="endtime" value="<%=results.getObject("endtime") %>">
					<table cellpadding="3px" cellspacing="3px">
						<tr>
							<td>TrainID: </td>	
							<td>
							<select name="edittrainid" size=1>
							<%
							
							
							while(allTrainIDs.next())
							{
								String name = allTrainIDs.getString("Trainid"); 
								
								if (name.equals(results.getString("trainid")))
								{	
									%>	
									 <option value="<%=name %>" selected><%=name %></option>
									
									<%
								}
								else
								{
							%>
								<option value="<%=name %>"><%=name %></option>
							<%
								}
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
								
								
								if (routeid.equals(results.getString("routeid")))
								{	
									%>	
									 <option value="<%=routeid %>" selected><%=name %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=routeid %>"><%=name %></option>
							<%
								}
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
								
								
								if (stationid.equals(results.getString("s.stationid")))
								{	
									%>	
									 <option value="<%=stationid %>" selected><%=name %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=stationid %>"><%=name %></option>
							<%
								}
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
								
								
								if (stationid.equals(results.getString("s2.stationid")))
								{	
									%>	
									 <option value="<%=stationid %>" selected><%=name %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=stationid %>"><%=name %></option>
							<%
								}
							}
							%>
							</select>
							
						</td>
						</tr>
						<tr>
							<td>Departure Date/Time: </td>
							<td><input type="text" name="editdeparture" value="<%=results.getObject("starttime") %>">  YYYY-MM-DD HH:MM</td>
						
						</tr>
						<tr>
							<td>Arrival Date/Time: </td>
							<td><input type="text" name="editarrival" value="<%=results.getObject("endtime") %>">  YYYY-MM-DD HH:MM</td>
						</tr>
						<tr>
							<td># Available Seats: </td>
							<td><input type="text" name="editseats" value="<%=results.getObject("availableseats") %>"></td>
						</tr>
						<tr>
							<td>One-Way Economy Fare: </td>
							<td><input type="text" name="editeconomy" value="<%=results.getObject("economyfare") %>"></td>
						</tr>
						<tr>
							<td>One-Way Business Fare: </td>
							<td><input type="text" name="editbusiness" value="<%=results.getObject("businessfare") %>"></td>
						</tr>
						<tr>
							<td>One-Way First Class Fare: </td>
							<td><input type="text" name="editfirst" value="<%=results.getObject("firstfare") %>"></td>
						</tr>
						<tr>
							<td>Age/Disability Discount: </td>
							<td>
							<select name="editecddiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
								if (x==results.getInt("t.ecddiscount"))
								{	
									%>	
									 <option value="<%=x %>" selected><%=x %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								}
							}
							%>
							</select>%
							
						</td>
						</tr>
						<tr>
							<td>Round Trip Discount: </td>
								<td>
							<select name="editroundiscount" size=1>
							<%
							
							
							for(int x=1; x<101; x++)
							{ 
								if (x==results.getInt("t.roundtripdiscount"))
								{	
									%>	
									 <option value="<%=x %>" selected><%=x %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								}
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
								if (x==results.getInt("t.weekdiscount"))
								{	
									%>	
									 <option value="<%=x %>" selected><%=x %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								}
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
								if (x==results.getInt("t.monthdiscount"))
								{	
									%>	
									 <option value="<%=x %>" selected><%=x %></option>
									<%
								}
								else
								{
							%>
								<option value="<%=x%>"><%=x %></option> 
							<%
								}
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
			}else {
				out.print("No such record exists. Please check the integrity of the database.");
			}
		} catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>
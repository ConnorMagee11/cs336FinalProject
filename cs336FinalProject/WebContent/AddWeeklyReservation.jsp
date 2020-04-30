<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Reservation - Weekly Pass</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>
ADD NEW RESERVATION-WEEKLY PASS
<br/>
<br/>
Making a reservation for a customer is as simple as 1, 2, 3!
<br/>
<br/>
1. Enter customer email
<br/>
<b>2. Select the type of trip</b>
<br/>
3. Proceed to checkout
<br/>
Done!
<br/>
<br/>
<br/>

- The weekly pass allows customers to ride multiple times between two stops within a set amount of time.
<br/>
- The price of the ticket is calculated using the peak time price between stops
<br/> and is calculated for 10 trips before the special weekly discount is applied.
<br/>
- The pass is valid for 7 days.
<br/>
<br/>

	<form method="post" action="AddWeeklyReservation.jsp?postback=1">
	TRAVEL BETWEEN
	<br/>
	
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
		
		
			String postback = request.getParameter("postback") == null ? "" : request.getParameter("postback");
			String origin = request.getParameter("origin") == null ? "" : request.getParameter("origin");
			String destination = request.getParameter("destination") == null ? "" : request.getParameter("destination");
			String classtype = request.getParameter("classtype") == null ? "" : request.getParameter("classtype");
			String discount = request.getParameter("discount") == null ? "" : request.getParameter("discount");
			String date=request.getParameter("triptime") == null ? "" : request.getParameter("triptime");
		
		String fail = request.getParameter("odd") == null ? "" : request.getParameter("odd");
		if(fail.equals("1")) 
		out.print("<span color='red'>An error occured. Please enter all fields correctly.</span><br/>");
		%>
	
		Origin Station: 
	
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
			
			if (origin.equals(result.getString("StationID")))
			{
				%>
					<option value="<%=result.getString("StationID") %>" selected><%=train %></option>
				<% 
				
			}
			else
			{
			%>
			<option value="<%=result.getString("StationID") %>"><%=train %></option>
		<%
			}
		}
		%>
		</select>

		<%		

		} catch(Exception e){
			out.print(e);
		}
	%>
		
	<br/>
		
		Destination Station: 
		
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
			if (destination.equals(result.getString("StationID")))
			{
				%>
					<option value="<%=result.getString("StationID") %>" selected><%=train %></option>
				<% 
				
			}
			else
			{
			%>
			<option value="<%=result.getString("StationID") %>"><%=train %></option>
		<%
			}
		}
		%>
		</select>
		
		

		<%		
	
		} catch(Exception e){
			out.print(e);
		}
	%>
		<br/>
		
		
		When do you begin your travel?
		<input type="date" id="start" name="triptime" value=<%=date %>
       		min="2020-01-01" max="2020-12-31">
		<br/>
		
		Select the class of train ticket the customer wants:
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
	<br/>	
	Is the customer eligible for a senior/child/disability discount?
	<select name="discount" size=1>
				<%
				if (discount.equals("No"))
				{
					%>
					<option value="No" selected>No</option>
					<%
				}
				else
				{
			%>
		 			<option value="No">No</option>
			<%  } %>
				 			<%
				if (discount.equals("Yes"))
				{
					%>
					<option value="Yes" selected>Yes</option>
					<%
				}
				else
				{
			%>
		 			<option value="Yes">Yes</option>
			<%  } %>
	</select>
		
		<br/>
		<br/>
	We charge a 10% booking fee. 	
	<br/>
	<br/>
		
		<input type="submit" value="View Total">
	</form>
	<br/>
	
	<%

		
	
		if (postback.equals("1"))
		{
			
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
	
			if (disabilitydiscount$>0)
			{
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
			double individualfare=total/money.getFloat("count(tripid)");
			total=total-(total*(week$/100));
			
			StringBuilder sb1 = new StringBuilder();
			Formatter formatter1 = new Formatter(sb1);
			formatter1.format("%.2f", total); 
			
			out.print("Total Cost of Weekly Ticket: $"+formatter1.toString());
			out.print("<br/>");
			
			total=total+(total*(.1));
			
			StringBuilder sb2 = new StringBuilder();
			Formatter formatter2 = new Formatter(sb2);
			formatter2.format("%.2f", total); 
			
			out.print("Total Cost of Weekly Ticket After 10% Booking Fee: $"+formatter2.toString());
			out.print("<br/>");
			
			if (discount.equals("Yes"))
			{
				
				total=total-(total*(disabilitydiscount$/100));
				StringBuilder sb = new StringBuilder();
				Formatter formatter = new Formatter(sb);
				formatter.format("%.2f", total);
				out.print("Total Cost of Weekly Ticket After "+disabilitydiscount$+"% senior/child/disability discount: $"+formatter.toString());
				out.print("<br/>");
				
			}
			
			StringBuilder sb = new StringBuilder();
			Formatter formatter = new Formatter(sb);
			formatter.format("%.2f", total); 
			
			
				out.print("<br/>");
			out.print("The customer will pay $"+formatter.toString());
			
			
			
			%>
			
			
			<form method='get' action='AddWeeklyReservationSuccess.jsp'>
			
			<input type="hidden" name="classtype" value=<%=classtype%>>
			<input type="hidden" name="total" value=<%=total%>>
			<input type="hidden" name="total2" value=<%=individualfare%>>
			<input type="hidden" name="age_disability" value=<%=discount%>>
			<input type="hidden" name="origin" value=<%=origin%>>
			<input type="hidden" name="destination" value=<%=destination%>>
			<input type="hidden" name="date" value=<%=date%>>
			
	
			<br/>
			<input type="submit" value="Click to Make Reservation">
			</form>
			
			<% 
			}
			else
			{
				out.print("No trains are traveling between these stops. Please change one or more of the above fields.");
			}
					
			
		}
		
		db.closeConnection(connection);
	%>
	


</body>
</html>
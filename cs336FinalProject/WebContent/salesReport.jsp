<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.text.DateFormatSymbols" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
	<%
	if(!session.getAttribute("username").equals("admin")){
		response.sendRedirect("notAuthorized.jsp");
	}
	%>
	<form method="get" action="adminHome.jsp">
		<input type="submit" value="Back to Administration Home">
	</form>
	<br/>
	<h2>Sales Report for <%=new DateFormatSymbols().getMonths()[Integer.parseInt(request.getParameter("salesMonth")) - 1] %></h2>
	<table cellpadding="3px" cellspacing="3px">
		<tr>
			<th>Reservation ID</th>
			<th>Reservation Date</th>
			<th>Total Fare</th>
			<th>Customer Email</th>
		</tr>
	<%
		float totalRevenue = 0.0f;
		try{
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement statement = conn.createStatement();
		
		String sql = "SELECT * FROM Reservations " +
					 "WHERE MONTH(ReservationDate) = " + Integer.parseInt(request.getParameter("salesMonth")) + " " +
					 "AND YEAR(ReservationDate) = 2020;";
		ResultSet results = statement.executeQuery(sql);
		
		while(results.next()){
			totalRevenue += results.getFloat("total_fare");
			String html = "<tr>" +
							"<td>" + results.getObject("ReservationId") + "</td>" +
							"<td>" + results.getObject("ReservationDate") + "</td>" +
							"<td>" + results.getFloat("total_fare") + "</td>" +
							"<td>" + results.getObject("CustomerEmail") + "</td>" +
						  "</tr>";
			out.print(html);
		}
		
		}catch(Exception e){
			out.print(e);
		}
	%>
	</table>
	<br/>
	Total Revenue: $<%=totalRevenue %>	
</body>
</html>
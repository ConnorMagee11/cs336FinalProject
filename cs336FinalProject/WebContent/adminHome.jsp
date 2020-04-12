<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administration</title>
</head>
<body>
	<h2>Administration Home</h2>

	<%
		//TODO: set null values pulled from db in forms to '' and when sending '' send NULL
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement statement = conn.createStatement();
			
			String bestCustomerSQL = 
					"SELECT r.CustomerEmail, c.FirstName, c.LastName " +
					"FROM Reservations r " +
					"INNER JOIN Customers c ON r.CustomerEmail=c.Email " +
					"GROUP BY CustomerEmail " +
					"HAVING COUNT(ReservationId) = (" +
						"SELECT MAX(t1.resCount) " +
						"FROM (" +
							"SELECT COUNT(ReservationId) resCount " +
							"FROM Reservations " +
							"GROUP BY CustomerEmail" +
					    ") t1 " +
					");";
					
			ResultSet bestCustomerResults = statement.executeQuery(bestCustomerSQL);
			
			if(bestCustomerResults.next()){
	%>
		Best Customer: <%=bestCustomerResults.getObject("FirstName").toString() + " " + bestCustomerResults.getObject("LastName").toString() + " (" + bestCustomerResults.getObject("CustomerEmail").toString() + ")"%>
	<%
			}
		} catch(Exception e){
			out.print(e); //TODO: take this out once debugging is over
			out.print("A database error occurred when fetching the top customer.");
		}
	%>
	<form method="get" action="viewCustomers.jsp">
		<input type="submit" value="View All Customers">
	</form>
	
	<form method="get" action="viewEmployees.jsp">
		<input type="submit" value="View All Employees">
	</form>

</body>
</html>
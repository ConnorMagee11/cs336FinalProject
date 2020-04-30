<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Message Successfully Sent</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>

You're message has been sent successfully!

<br/>
<br/>
	<form method="get" action="CheckMessages.jsp">
		<input type="submit" value="Back to all Messages">
	</form>

<% 

	try
	{
		
		ApplicationDB db = new ApplicationDB();
		Connection connection = db.getConnection();
		String qid = request.getParameter("qid") == null ? "" : request.getParameter("qid");
		String reply = request.getParameter("reply") == null ? "" : request.getParameter("reply");
		
		Statement sqlStatement = connection.createStatement();
		String update="update Message set csrssn='"+session.getAttribute("CustomerRepresentativeSSN")+"'where qid='"+qid+"'";
		sqlStatement.executeUpdate(update);
		update="update Message set reply='"+reply+"'where qid='"+qid+"'";
		sqlStatement.executeUpdate(update);
		
		
	
		db.closeConnection(connection);
	
	} catch(Exception e){
		out.print(e);
	}
		
%>


</body>
</html>
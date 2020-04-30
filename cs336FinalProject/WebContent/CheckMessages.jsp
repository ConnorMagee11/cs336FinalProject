<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check Messages</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>

New Messages
	<table cellpadding="3px" cellspacing="10px">
		<tr>
			<th>Customer Email</th>
			<th>Message</th>
		</tr>
		<%	
			try{
				ApplicationDB db = new ApplicationDB();
				Connection connection = db.getConnection();
				Statement statement = connection.createStatement();
				
				ResultSet results = statement.executeQuery("select qid, customeremail, content, reply from Message");
				
				
				while(results.next()){
					
				if (results.getObject("reply")==null)
				{	
					String html = "<tr>" + 
							"<td style='text-align:center'>" + results.getObject("customeremail") + "</td>" +
									"<td style='text-align:center'>" + results.getObject("content") + "</td>" +
								  "<td><form method='get' action='ReplyToMessages.jsp'>" +
								  "<input type='hidden' name='qid' value='" + results.getObject("qid") + "'>" +
								   "<input type='hidden' name='question' value='" + results.getObject("content") + "'>"+
								  "<input type='submit' value='reply'></form></td>" +
								  "</tr>";
					out.print(html);
				}
				}
				
				if (!results.first())
				{
					out.println("No new messages at this time. Please check back later.");
				}
				
				db.closeConnection(connection);
				
			} catch(Exception e){
				out.print(e);
			}
		%>
		
		<br/>
		
		<%

			String success = request.getParameter("success") == null ? "" : request.getParameter("success");
			out.print(success);
		%>


</body>
</html>
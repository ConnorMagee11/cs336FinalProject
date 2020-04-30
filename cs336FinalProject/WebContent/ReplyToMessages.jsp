<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336FinalProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReplyToMessage</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
	<br/>


	<form method="post" action="MessageSuccessfullySent.jsp">
		
		<%
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			String qid = request.getParameter("qid") == null ? "" : request.getParameter("qid");
			String content = request.getParameter("question") == null ? "" : request.getParameter("question");
			out.println("Customer Question: "+content);
		%>
		
		<br/>
		Please Type Your Reply: <input type="text" name="reply">
		<br/>
		
		<input type='hidden' name="qid" value=<%=qid%>>
		<input type="submit" value="Submit Reply">
	</form>


	<table>
	<br/>
	<br/>
	<form method="post" action="CheckMessages.jsp">
		<input type="submit" value="Return to Messages Without Answering Question">
	</form>
	<br/>


</body>
</html>
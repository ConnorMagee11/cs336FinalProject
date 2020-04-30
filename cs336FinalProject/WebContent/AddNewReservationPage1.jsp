<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Reservation - Customer Status</title>
</head>
<body>
<form method="post" action="CustomerRepresentativeHomePage.jsp">
		<input type="submit" value="Return to Customer Service Home Page">
	</form>
	<hr/>
ADD NEW RESERVATION-CUSTOMER INFORMATION
<br/>
<br/>
Making a reservation for a customer is as simple as 1, 2, 3!
<br/>
<br/>
<b>1. Enter customer email</b>
<br/>
2. Select the type of trip
<br/>
3. Proceed to checkout
<br/>
Done!
<br/>
<br/>
<br/>

	<%
			String customeremailFailed = request.getParameter("customeremailFailed") == null ? "" : request.getParameter("customeremailFailed");
			if(customeremailFailed.equals("1")) out.print("<span color='red'>Email not recognized. Please create a new customer account. </span><br/>");
	%>
<form method="post" action="AddNewReservationPage2.jsp">
To begin, please enter the email associated with the customer account: <input type="text" name="customeremail">
		<input type="submit" value="Submit">

	</form>
<br/>
<br/>


If the customer does not have an account, click here to help the individual set up an account first:
	<form method="post" action="NewCustomer_CSR.jsp">
		<input type="submit" value="Create New Customer Account">
	</form>
	<br/>
	
	<form method="post" action="viewReservations.jsp">
		<input type="submit" value="Return to Reservation Info">
	</form>


</body>
</html>
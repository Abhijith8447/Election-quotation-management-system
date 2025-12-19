<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.election.beans.LoginBean"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/menu.css">
</head>

<body>

	<%
	String userName = (String) session.getAttribute("user");
	%>

	<div class="header-title">
		<h2>
			Welcome
			<%=userName%></h2>
		<h1>Admin Home</h1>
	</div>

	<ul class="menu">

		<li class="dropdown"><a href="#" class="dropbtn">Settings ▼</a>
			<ul class="dropdown-content">
				<li><a href="kmPayment.jsp">Payment/km</a></li>
				<li><a href="change_password.html">Change Password</a></li>
			</ul></li>
		<li class="dropdown"><a href="#">Settings</a>
			<ul class="dropdown-content">
				<li><a href="adminAddOwnerLogin.jsp">Add Owner</a></li>
				<li><a href="adminChangePassword.jsp">Change Password</a></li>
			</ul>         
			
			
		</li>

		<li><a href="adminOwner.jsp?v=0">Owners</a></li>
		<li><a href="adminDriver.jsp">Drivers</a></li>
		<li><a href="adminVehicle.jsp">Vehicles</a></li>
		<li><a href="adminQuotation.jsp">Quotation</a></li>
		<li><a href="adminVehicleAllocation.jsp">Vehicle Allocation</a></li>

		<li><a href="adminDailyRoute.jsp">Daily Route</a></li>
		<li><a href="adminExpense.jsp">Expenses</a></li>
		<li><a href="adminPayment.jsp">Payment</a></li>
		<li><a href="adminBilling.jsp">Billing</a></li>
		
		<li><a href="../logout.jsp">Logout</a></li>
	</ul>
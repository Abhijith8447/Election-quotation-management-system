<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/menu.css">
    
    <style>
        h1, h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        String userName = (String) session.getAttribute("user");
    %>

    <h2>Welcome <%= userName %></h2>
    <h1>Owner Home</h1>
    
    <ul class="menu">
        <li><a href="changePasswordOwner.jsp">Change Password</a></li>
        <li><a href="ownerDriver.jsp">Drivers</a></li>
        <li><a href="ownerExpense.jsp">Expenses</a></li>
        <li><a href="billing">Billing Details</a></li>
        <li><a href="../logout.jsp">Logout</a></li> 
    </ul>


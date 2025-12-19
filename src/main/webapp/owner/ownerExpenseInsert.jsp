<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.ExpenseDAO" %>

<%
    try {
        // Fetch parameters from the form
        String ownerName = request.getParameter("owner_name");
        String vehicleIdStr = request.getParameter("vehicle_id");
        String date = request.getParameter("date");
        String category = request.getParameter("category");
        String totalCostStr = request.getParameter("total_cost");

        // Convert numeric values
        int vehicleId = Integer.parseInt(vehicleIdStr);
        double totalCost = Double.parseDouble(totalCostStr);

        // Create ExpenseBean
        ExpenseBean bean = new ExpenseBean();
        bean.setOwnerName(ownerName);
        bean.setVehicleId(vehicleId);
        bean.setDate(date);
        bean.setCategory(category);
        bean.setTotalCost(totalCost);

        // Owner cannot set status, default is 'pending'
        bean.setStatus("pending");

        // Optional: Check for duplicates (if needed)
        // boolean checkFlag = ExpenseDAO.checkExpenseExists(bean);

        // Insert expense
        boolean flagInsert = ExpenseDAO.insertExpense(bean);

        if (flagInsert) {
            response.sendRedirect("ownerExpense.jsp?v=1");  // Inserted successfully
        } else {
            response.sendRedirect("ownerExpense.jsp?v=4");  // Insert failed
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ownerExpense.jsp?v=4");  // Error fallback
    }
%>

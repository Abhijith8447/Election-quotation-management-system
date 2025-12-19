<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.ExpenseDAO" %>
<%
    try {
        int expenseId = Integer.parseInt(request.getParameter("expense_id"));
        
        String ownerName = request.getParameter("owner_name");
        int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
        String date = request.getParameter("date");
        String category = request.getParameter("category");
        double totalCost = Double.parseDouble(request.getParameter("total_cost"));
        String status = request.getParameter("status");

        ExpenseBean expense = new ExpenseBean();
        expense.setExpenseId(expenseId);
       
        expense.setOwnerName(ownerName);
        expense.setVehicleId(vehicleId);
        expense.setDate(date);
        expense.setCategory(category);
        expense.setTotalCost(totalCost);
        expense.setStatus(status);

        boolean updated = ExpenseDAO.updateExpense(expense);

        if(updated) {
            response.sendRedirect("ownerExpense.jsp?v=2"); // Updated successfully
        } else {
            response.sendRedirect("ownerExpense.jsp?v=4"); // Something went wrong
        }

    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("ownerExpense.jsp?v=4");
    }
%>

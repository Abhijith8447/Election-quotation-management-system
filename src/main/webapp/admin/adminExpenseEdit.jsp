<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.ExpenseDAO" %>

<%
    int expenseId = Integer.parseInt(request.getParameter("id"));
    ExpenseBean expense = ExpenseDAO.getExpenseById(expenseId);
%>

<div align="center">
    <h2>Edit Expense Status</h2>

    <form method="post" action="adminExpenseEditAction.jsp">
        <!-- Hidden fields for all existing values -->
        <input type="hidden" name="expense_id" value="<%= expense.getExpenseId() %>">
        <input type="hidden" name="owner_name" value="<%= expense.getOwnerName() %>">
        <input type="hidden" name="vehicle_id" value="<%= expense.getVehicleId() %>">
        <input type="hidden" name="date" value="<%= expense.getDate() %>">
        <input type="hidden" name="category" value="<%= expense.getCategory() %>">
        <input type="hidden" name="total_cost" value="<%= expense.getTotalCost() %>">

        <!-- Status dropdown -->
        <table border="0" cellpadding="5">
            <tr>
                <td><b>Status:</b></td>
                <td>
                    <select name="status" required>
                        <option value="pending" <%= expense.getStatus().equals("pending") ? "selected" : "" %>>Pending</option>
                        <option value="approved" <%= expense.getStatus().equals("approved") ? "selected" : "" %>>Approved</option>
                        <option value="rejected" <%= expense.getStatus().equals("rejected") ? "selected" : "" %>>Rejected</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE STATUS">
                </td>
            </tr>
        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

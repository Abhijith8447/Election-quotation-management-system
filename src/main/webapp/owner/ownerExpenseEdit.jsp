<%@ include file="ownerHeader.jsp" %>
<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.ExpenseDAO" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="java.util.List" %>

<%
    // Get ownerId from session
    Integer ownerId = (Integer) session.getAttribute("ownerId");
    if (ownerId == null) {
        response.sendRedirect("../index.html");
        return;
    }

    // Get expenseId from request
    int expenseId = Integer.parseInt(request.getParameter("id"));
    ExpenseBean expense = ExpenseDAO.getExpenseById(expenseId);

    // Get all vehicles for this owner
    List<VehicleBean> vehicles = VehicleDAO.fetchVehiclesByOwner(ownerId);
%>

<div align="center">
    <h2>Edit Expense</h2>

    <form method="post" action="ownerExpenseEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden Expense ID -->
            <input type="hidden" name="expense_id" value="<%= expense.getExpenseId() %>">

            <!-- Hidden Owner Name -->
            <input type="hidden" name="owner_name" value="<%= expense.getOwnerName() %>">

            <!-- Vehicle -->
            <tr>
                <td><b>Vehicle:</b></td>
                <td>
                    <select name="vehicle_id" style="width:250px;" required>
                        <%
                            for (VehicleBean v : vehicles) {
                                String selected = (v.getVehicleId() == expense.getVehicleId()) ? "selected" : "";
                        %>
                            <option value="<%= v.getVehicleId() %>" <%= selected %>><%= v.getVehicleNo() %></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- Date -->
            <tr>
                <td><b>Date:</b></td>
                <td>
                    <input type="date" name="date" value="<%= expense.getDate() %>" required>
                </td>
            </tr>

            <!-- Category -->
            <tr>
                <td><b>Category:</b></td>
                <td>
                    <select name="category" required>
                        <option value="petrol" <%= expense.getCategory().equals("petrol") ? "selected" : "" %>>Petrol</option>
                        <option value="repair" <%= expense.getCategory().equals("repair") ? "selected" : "" %>>Repair</option>
                        <option value="accidental damage" <%= expense.getCategory().equals("accidental damage") ? "selected" : "" %>>Accidental Damage</option>
                    </select>
                </td>
            </tr>

            <!-- Total Cost -->
            <tr>
                <td><b>Total Cost:</b></td>
                <td>
                    <input type="number" step="0.01" name="total_cost" value="<%= expense.getTotalCost() %>" required>
                </td>
            </tr>

            <!-- Status -->
            </tr>

			<!-- Hidden status -->
			<input type="hidden" name="status" value="pending">

			<tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE">
                </td>
            </tr>

        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

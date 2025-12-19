<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.ExpenseDAO" %>
<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>

<%
    // Fetch all expenses
    List<ExpenseBean> expenseList = ExpenseDAO.getAllExpenses();
    List<VehicleBean> vehicles = VehicleDAO.getAllVehicles();

    // Handle status messages
    String statusCode = request.getParameter("v");
    String caption = "";
    if ("1".equals(statusCode)) caption = "Inserted Successfully...";
    else if ("2".equals(statusCode)) caption = "Updated Successfully...";
    else if ("3".equals(statusCode)) caption = "Deleted Successfully...";
    else if ("4".equals(statusCode)) caption = "OOPS !! Something went wrong...";
%>

<div style="width: 70%; margin: 0 auto;">
    <h2 style="text-align:center;">ADMIN EXPENSES</h2>
    <div style="text-align:center; margin-bottom:10px; color:red; font-weight:bold;"><%= caption %></div>

    <table border="1" style="width: 100%; border-collapse: collapse;">
        <tr>
            <th>SLNO</th>
            <th>Owner Name</th>
            <th>Vehicle</th>
            <th>Date</th>
            <th>Category</th>
            <th>Total Cost</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
            if (expenseList != null && !expenseList.isEmpty()) {
                int i = 1;
                for (ExpenseBean e : expenseList) {
                    String vehicleName = e.getVehicleId() + "";
                    if (vehicles != null && !vehicles.isEmpty()) {
                        for (VehicleBean v : vehicles) {
                            if (v.getVehicleId() == e.getVehicleId()) {
                                vehicleName = v.getVehicleNo();
                                break;
                            }
                        }
                    }
        %>
        <tr>
            <td><%= i %></td>
            <td><%= e.getOwnerName() %></td>
            <td><%= vehicleName %></td>
            <td><%= e.getDate() %></td>
            <td><%= e.getCategory() %></td>
            <td><%= e.getTotalCost() %></td>
            <td><%= e.getStatus() %></td>
            <td>
                <a href="adminExpenseEdit.jsp?id=<%= e.getExpenseId() %>">Edit Status</a>
            </td>
        </tr>
        <%
                    i++;
                }
            } else {
        %>
        <tr>
            <td colspan="8" style="text-align: center;">No expenses found</td>
        </tr>
        <%
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

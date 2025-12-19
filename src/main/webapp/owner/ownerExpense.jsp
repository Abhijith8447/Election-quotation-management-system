<%@ include file="ownerHeader.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.election.dao.ExpenseDAO"%>
<%@ page import="com.election.beans.ExpenseBean"%>
<%@ page import="com.election.dao.VehicleDAO"%>
<%@ page import="com.election.beans.VehicleBean"%>

<%
// Get ownerId from session
Integer ownerId = (Integer) session.getAttribute("ownerId");

// If ownerId is null, redirect to login
if (ownerId == null) {
	response.sendRedirect("../index.html");
	return;
}

// Get expenses and vehicles for this owner
List<ExpenseBean> expenseList = ExpenseDAO.getExpensesByOwner(ownerId);
List<VehicleBean> vehicles = VehicleDAO.fetchVehiclesByOwner(ownerId);

// Handle status messages
String statusCode = request.getParameter("v");
String caption = "";
if (statusCode == null || statusCode.equals("0"))
	caption = "";
else if (statusCode.equals("1"))
	caption = "Inserted Successfully...";
else if (statusCode.equals("2"))
	caption = "Updated Successfully...";
else if (statusCode.equals("3"))
	caption = "Deleted Successfully...";
else if (statusCode.equals("4"))
	caption = "OOPS !! Something went wrong...";
%>

<div style="text-align: center; margin-top: 20px;">
	<h2>OWNER EXPENSE DETAILS</h2>
</div>

<div style="text-align: center; margin: 15px;">
	<span style="color: red; font-weight: bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div
	style="width: 50%; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px;">
	<form method="post" action="ownerExpenseInsert.jsp">
		<table style="margin: 0 auto;">
			<!-- Hidden field for owner name -->
			<input type="hidden" name="owner_name"
				value="<%=session.getAttribute("user")%>">

			<tr>
				<td>Vehicle:</td>
				<td><select name="vehicle_id"
					style="width: 250px; padding: 5px;" required>
						<%
						if (vehicles != null && !vehicles.isEmpty()) {
							for (VehicleBean vObj : vehicles) {
						%>
						<option value="<%=vObj.getVehicleId()%>"><%=vObj.getVehicleNo()%></option>
						<%
						}
						} else {
						%>
						<option value="">No vehicles available</option>
						<%
						}
						%>
				</select></td>
			</tr>

			<tr>
				<td>Date:</td>
				<td><input type="date" name="date" style="width: 250px;"
					required></td>
			</tr>

			<tr>
				<td>Category:</td>
				<td><select name="category" style="width: 250px;" required>
						<option value="petrol">Petrol</option>
						<option value="repair">Repair</option>
						<option value="accidental damage">Accidental Damage</option>
				</select></td>
			</tr>

			<tr>
				<td>Total Cost:</td>
				<td><input type="number" step="0.01" name="total_cost"
					style="width: 250px;" required></td>
			</tr>

			<!-- Hidden status -->
			<input type="hidden" name="status" value="pending">

			<tr>
				<td colspan="2" style="text-align: center; padding-top: 10px;">
					<input type="submit" value="Add Expense">
				</td>
			</tr>
		</table>
	</form>
</div>

<br>

<!-- EXPENSE LIST -->
<div style="width: 70%; margin: 0 auto;">
	<table border="1" style="width: 100%; border-collapse: collapse;">
		<tr>
			<th>SLNO</th>
			<th>Owner Name</th>
			<th>Vehicle</th>
			<th>Date</th>
			<th>Category</th>
			<th>Total Cost</th>
			<th>Status</th>
			<th colspan="2">Action</th>
		</tr>

		<%
		if (expenseList != null && !expenseList.isEmpty()) {
			int i = 1;
			for (ExpenseBean e : expenseList) {
				String vehicleName = e.getVehicleId() + ""; // default if vehicle not found

				// Find vehicle name from vehicles list
				if (vehicles != null) {
			for (VehicleBean v : vehicles) {
				if (v.getVehicleId() == e.getVehicleId()) {
					vehicleName = v.getVehicleNo();
					break;
				}
			}
				}
		%>
		<tr>
			<td><%=i%></td>
			<td><%=e.getOwnerName()%></td>
			<td><%=vehicleName%></td>
			<td><%=e.getDate()%></td>
			<td><%=e.getCategory()%></td>
			<td><%=e.getTotalCost()%></td>
			<td><%=e.getStatus()%></td>
			<td><a href="ownerExpenseEdit.jsp?id=<%=e.getExpenseId()%>">Edit</a></td>
			<td><a href="ownerDelete.jsp?id=<%=e.getExpenseId()%>"
				onclick="return confirm('Are you sure you want to delete?')">Delete</a></td>
		</tr>
		<%
		i++;
		}
		} else {
		%>
		<tr>
			<td colspan="9" style="text-align: center;">No expenses found</td>
		</tr>
		<%
		}
		%>
	</table>
</div>

<%@ include file="../footer.html"%>

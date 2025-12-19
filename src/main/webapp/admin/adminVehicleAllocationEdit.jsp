<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.dao.VehicleAllocationDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.beans.VehicleAllocationBean" %>

<%
    int locationId = 0;
    if (request.getParameter("locationId") != null) {
        locationId = Integer.parseInt(request.getParameter("locationId"));
    }

    VehicleAllocationBean bean = VehicleAllocationDAO.fetchAllocationById(locationId);
%>

<div align="center">
    <h2>Edit Vehicle Allocation</h2>

    <form method="post" action="adminVehicleAllocationEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden Location ID -->
            <tr>
                <td></td>
                <td>
                    <input type="hidden" name="location_id" value="<%= bean.getLocationId() %>">
                </td>
            </tr>

            <!-- Owner Dropdown -->
            <tr>
                <td><b>Owner:</b></td>
                <td>
                    <select name="owner_id" id="ownerDropdown" style="width:250px;" onchange="loadDrivers(this.value)" required>
                        <option value="">-- Select Owner --</option>
                        <%
                            List<OwnerBean> owners = OwnerDAO.listOwners();
                            for (OwnerBean ob : owners) {
                                String selected = (ob.getOwnerId() == bean.getOwnerId()) ? "selected" : "";
                        %>
                            <option value="<%= ob.getOwnerId() %>" <%= selected %>><%= ob.getOwnerName() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>

            <!-- Driver Dropdown -->
            <tr>
                <td><b>Driver:</b></td>
                <td>
                    <select name="driver_id" id="driverDropdown" style="width:250px;" onchange="loadVehicles(this.value)" required>
                        <option value="<%= bean.getDriverId() %>"><%= DriverDAO.fetchDriverById(bean.getDriverId()).getDriverName() %></option>
                    </select>
                </td>
            </tr>

            <!-- Vehicle Dropdown -->
            <tr>
                <td><b>Vehicle:</b></td>
                <td>
                    <select name="vehicle_id" id="vehicleDropdown" style="width:250px;" required>
                        <option value="<%= bean.getVehicleId() %>"><%= VehicleDAO.fetchVehicleById(bean.getVehicleId()).getVehicleNo() %></option>
                    </select>
                </td>
            </tr>

            <!-- Location Name -->
            <tr>
                <td><b>Location Name:</b></td>
                <td><input type="text" name="location_name" value="<%= bean.getLocationName() %>" style="width:250px;" required></td>
            </tr>

            <!-- Assigned Officer -->
            <tr>
                <td><b>Assigned Officer:</b></td>
                <td><input type="text" name="assigned_officer" value="<%= bean.getAssignedOfficer() %>" style="width:250px;" required></td>
            </tr>

            <!-- Submit -->
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE">
                </td>
            </tr>

        </table>
    </form>
</div>

<script>
    function loadDrivers(ownerId) {
        fetch("getDriversByOwner.jsp?ownerId=" + ownerId)
            .then(response => response.text())
            .then(data => {
                document.getElementById("driverDropdown").innerHTML = data;
                document.getElementById("vehicleDropdown").innerHTML = "<option value=''>-- Select Driver First --</option>";
            });
    }

    function loadVehicles(driverId) {
        fetch("getVehiclesByDriver.jsp?driverId=" + driverId)
            .then(response => response.text())
            .then(data => {
                document.getElementById("vehicleDropdown").innerHTML = data;
            });
    }
</script>

<%@ include file="../footer.html" %>

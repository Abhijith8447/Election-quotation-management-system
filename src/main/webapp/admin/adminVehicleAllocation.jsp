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
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist!";
    else if (v.equals("2")) caption = "Inserted!";
    else if (v.equals("3")) caption = "Insert Failed!";
    else if (v.equals("4")) caption = "Updated!";
    else if (v.equals("5")) caption = "Deleted!";
%>

<h2 style="text-align:center;">VEHICLE ALLOCATION DETAILS</h2>

<div style="text-align:center; color:red; font-weight:bold;"><%= caption %></div>

<!-- AJAX scripts -->
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

<!-- INSERT FORM -->
<div style="width:50%; margin:20px auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="adminVehicleAllocationInsert.jsp">
        <table style="margin:0 auto;">

            <!-- Owner Dropdown -->
            <tr>
                <td>Owner:</td>
                <td>
                    <select name="owner_id" id="ownerDropdown" style="width:340px;" 
                            onchange="loadDrivers(this.value)" required>
                        <option value="">-- Select Owner --</option>
                        <% 
                            List<OwnerBean> ownerList = OwnerDAO.listOwners();
                            for (OwnerBean ob : ownerList) {
                        %>
                            <option value="<%= ob.getOwnerId() %>"><%= ob.getOwnerName() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>

            <!-- Driver Dropdown -->
            <tr>
                <td>Driver:</td>
                <td>
                    <select name="driver_id" id="driverDropdown" style="width:340px;" 
                            onchange="loadVehicles(this.value)" required>
                        <option value="">-- Select Owner First --</option>
                    </select>
                </td>
            </tr>

            <!-- Vehicle Dropdown -->
            <tr>
                <td>Vehicle:</td>
                <td>
                    <select name="vehicle_id" id="vehicleDropdown" style="width:340px;" required>
                        <option value="">-- Select Driver First --</option>
                    </select>
                </td>
            </tr>

            <!-- Location Name -->
            <tr>
                <td>Location:</td>
                <td><input type="text" name="location_name" required style="width:340px;"></td>
            </tr>

            <!-- Officer -->
            <tr>
                <td>Assigned Officer:</td>
                <td><input type="text" name="assigned_officer" required style="width:340px;"></td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Save">
                </td>
            </tr>

        </table>
    </form>
</div>

<!-- ALLOCATION LIST -->
<div style="width:80%; margin:20px auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>Location ID</th>
            <th>Owner</th>
            <th>Driver</th>
            <th>Vehicle</th>
            <th>Location</th>
            <th>Officer</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<VehicleAllocationBean> aList = VehicleAllocationDAO.listAllocations();
            for (VehicleAllocationBean bean : aList) {
        %>

        <tr>
            <td><%= i %></td>
            <td><%= bean.getLocationId() %></td>
            <td><%= OwnerDAO.fetchOwnerById(bean.getOwnerId()).getOwnerName() %></td>
            <td><%= DriverDAO.fetchDriverById(bean.getDriverId()).getDriverName() %></td>
            <td><%= VehicleDAO.fetchVehicleById(bean.getVehicleId()).getVehicleNo() %></td>
            <td><%= bean.getLocationName() %></td>
            <td><%= bean.getAssignedOfficer() %></td>

            <td><a href="adminVehicleAllocationEdit.jsp?locationId=<%= bean.getLocationId() %>">Edit</a></td>

            <td><a href="adminVehicleAllocationDelete.jsp?locationId=<%= bean.getLocationId() %>"
                   onclick="return confirm('Are you sure to delete?')">Delete</a></td>
        </tr>

        <%
                i++;
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

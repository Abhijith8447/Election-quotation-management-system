<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.DriverBean" %>

<%
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist!!! Please check...";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS !!! Failure. Please insert again...";
    else if (v.equals("4")) caption = "Updated...";
    else if (v.equals("5")) caption = "Deleted...";
%>

<div style="text-align:center; margin-top:20px;">
    <h2>VEHICLE DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div style="width:50%; margin:0 auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="adminVehicleInsertAction.jsp">
        <table style="margin:0 auto;">

            <!-- OWNER ID DROPDOWN -->
            <tr>
                <td>Owner:</td>
                <td>
                    <select name="owner-id" style="width:340px;" required>
                        <option value="">-- Select Owner --</option>
                        <%
                            List<OwnerBean> ownerList = OwnerDAO.listOwners();
                            for (OwnerBean o : ownerList) {
                        %>
                            <option value="<%= o.getOwnerId() %>"><%= o.getOwnerName() %></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- DRIVER ID DROPDOWN (Only approved drivers) -->
            <tr>
                <td>Driver:</td>
                <td>
                    <select name="driver-id" style="width:340px;" required>
                        <option value="">-- Select Driver --</option>
                        <%
                            List<DriverBean> driverList = DriverDAO.listApprovedDrivers();
                            for (DriverBean d : driverList) {
                        %>
                            <option value="<%= d.getDriverId() %>"><%= d.getDriverName() %></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- VEHICLE NO -->
            <tr>
                <td>Vehicle No:</td>
                <td><input type="text" name="vehicle-no" required style="width:340px;"></td>
            </tr>

            <!-- VEHICLE TYPE -->
            <tr>
                <td>Vehicle Type:</td>
                <td>
                    <select name="vehicle-type" style="width:340px;" required>
                        <option value="">-- Select Type --</option>
                        <option value="Bus">Bus</option>
                        <option value="Car">Car</option>
                        <option value="Van">Van</option>
                        <option value="Truck">Truck</option>
                    </select>
                </td>
            </tr>

            <!-- MODEL -->
            <tr>
                <td>Model:</td>
                <td><input type="text" name="model" required style="width:340px;"></td>
            </tr>

            <!-- STATUS -->
            <tr>
                <td>Status:</td>
                <td>
                    <select name="status" style="width:340px;">
                        <option value="available" selected>Available</option>
                        <option value="assigned">Assigned</option>
                        <option value="blocked">Blocked</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Save">
                </td>
            </tr>
        </table>
    </form>
</div>

<br>

<!-- VEHICLE LIST TABLE -->
<div style="width:90%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>Vehicle ID</th>
            <th>Owner</th>
            <th>Driver</th>
            <th>Vehicle No</th>
            <th>Type</th>
            <th>Model</th>
            <th>Status</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<VehicleBean> vehicleList = VehicleDAO.listVehicles();
            for (VehicleBean vehicle : vehicleList) {
        %>
        <tr>
            <td><%= i %></td>
            <td><%= vehicle.getVehicleId() %></td>

            <!-- OWNER NAME -->
            <td>
                <%
                    OwnerBean owner = OwnerDAO.fetchOwnerById(vehicle.getOwnerId());
                    if (owner != null) out.print(owner.getOwnerName());
                    else out.print("-");
                %>
            </td>

            <!-- DRIVER NAME -->
            <td>
                <%
                    DriverBean driver = DriverDAO.fetchDriverById(vehicle.getDriverId());
                    if (driver != null) out.print(driver.getDriverName());
                    else out.print("-");
                %>
            </td>

            <td><%= vehicle.getVehicleNo() %></td>
            <td><%= vehicle.getVehicleType() %></td>
            <td><%= vehicle.getModel() %></td>
            <td><%= vehicle.getStatus() %></td>

            <td>
                <a href="adminVehicleEdit.jsp?vehicleId=<%= vehicle.getVehicleId() %>">Edit</a>
            </td>

            <td>
                <a href="adminVehicleDelete.jsp?vehicleId=<%= vehicle.getVehicleId() %>"
                   onclick="return confirm('Are you sure you want to delete?')">Delete</a>
            </td>
        </tr>
        <%
                i++;
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

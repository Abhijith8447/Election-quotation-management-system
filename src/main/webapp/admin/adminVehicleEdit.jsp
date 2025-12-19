<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="java.util.List" %>

<%
    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
    VehicleBean bean = VehicleDAO.fetchVehicleById(vehicleId);
%>

<div align="center">
    <h2>Edit Vehicle</h2>

    <form method="post" action="adminVehicleEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden ID -->
            <tr>
                <td></td>
                <td>
                    <input type="hidden" name="vehicle-id" value="<%= bean.getVehicleId() %>">
                </td>
            </tr>

            <!-- OWNER DROPDOWN -->
            <tr>
                <td><b>Owner:</b></td>
                <td>
                    <select name="owner-id" style="width:350px;" required>
                        <%
                            List<OwnerBean> ownerList = OwnerDAO.listOwners();
                            for (OwnerBean o : ownerList) {
                                String selected = (o.getOwnerId() == bean.getOwnerId()) ? "selected" : "";
                        %>
                            <option value="<%= o.getOwnerId() %>" <%= selected %>>
                                <%= o.getOwnerName() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- DRIVER DROPDOWN -->
            <tr>
                <td><b>Driver:</b></td>
                <td>
                    <select name="driver-id" style="width:350px;" required>
                        <%
                            List<DriverBean> driverList = DriverDAO.listDrivers();
                            for (DriverBean d : driverList) {
                                String selected = (d.getDriverId() == bean.getDriverId()) ? "selected" : "";
                        %>
                            <option value="<%= d.getDriverId() %>" <%= selected %>>
                                <%= d.getDriverName() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- VEHICLE NO -->
            <tr>
                <td><b>Vehicle No:</b></td>
                <td><input type="text" name="vehicle-no" value="<%= bean.getVehicleNo() %>" style="width:350px;" required></td>
            </tr>

            <!-- VEHICLE TYPE -->
            <tr>
                <td><b>Vehicle Type:</b></td>
                <td>
                    <select name="vehicle-type" style="width:350px;" required>
                        <option value="Bus" <%= bean.getVehicleType().equals("Bus") ? "selected" : "" %>>Bus</option>
                        <option value="Car" <%= bean.getVehicleType().equals("Car") ? "selected" : "" %>>Car</option>
                        <option value="Van" <%= bean.getVehicleType().equals("Van") ? "selected" : "" %>>Van</option>
                        <option value="Truck" <%= bean.getVehicleType().equals("Truck") ? "selected" : "" %>>Truck</option>
                    </select>
                </td>
            </tr>

            <!-- MODEL -->
            <tr>
                <td><b>Model:</b></td>
                <td><input type="text" name="model" value="<%= bean.getModel() %>" style="width:350px;" required></td>
            </tr>

            <!-- STATUS -->
            <tr>
                <td><b>Status:</b></td>
                <td>
                    <select name="status" style="width:350px;">
                        <option value="available" <%= bean.getStatus().equals("available") ? "selected" : "" %>>Available</option>
                        <option value="assigned"  <%= bean.getStatus().equals("assigned") ? "selected" : "" %>>Assigned</option>
                        <option value="blocked"   <%= bean.getStatus().equals("blocked") ? "selected" : "" %>>Blocked</option>
                    </select>
                </td>
            </tr>

            <!-- SUBMIT -->
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE">
                </td>
            </tr>

        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

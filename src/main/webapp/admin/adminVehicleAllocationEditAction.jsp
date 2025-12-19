<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.VehicleAllocationBean" %>
<%@ page import="com.election.dao.VehicleAllocationDAO" %>

<%
    try {
        // Read parameters safely
        String locationIdStr = request.getParameter("location_id");
        String ownerIdStr = request.getParameter("owner_id");
        String driverIdStr = request.getParameter("driver_id");
        String vehicleIdStr = request.getParameter("vehicle_id");
        String locationName = request.getParameter("location_name");
        String assignedOfficer = request.getParameter("assigned_officer");

        if (locationIdStr != null && ownerIdStr != null && driverIdStr != null && vehicleIdStr != null) {

            int locationId = Integer.parseInt(locationIdStr);
            int ownerId = Integer.parseInt(ownerIdStr);
            int driverId = Integer.parseInt(driverIdStr);
            int vehicleId = Integer.parseInt(vehicleIdStr);

            VehicleAllocationBean bean = new VehicleAllocationBean();
            bean.setLocationId(locationId);
            bean.setOwnerId(ownerId);
            bean.setDriverId(driverId);
            bean.setVehicleId(vehicleId);
            bean.setLocationName(locationName);
            bean.setAssignedOfficer(assignedOfficer);

            boolean status = VehicleAllocationDAO.updateAllocation(bean);

            if (status) {
                response.sendRedirect("adminVehicleAllocation.jsp?v=4"); // Updated successfully
            } else {
                response.sendRedirect("adminVehicleAllocation.jsp?v=3"); // Update failed
            }
        } else {
            response.sendRedirect("adminVehicleAllocation.jsp?v=3"); // Missing params
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicleAllocation.jsp?v=3"); // Error fallback
    }
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.VehicleAllocationBean" %>
<%@ page import="com.election.dao.VehicleAllocationDAO" %>

<%
    try {
        // Read parameters as per your form
        String ownerIdStr = request.getParameter("owner_id");
        String driverIdStr = request.getParameter("driver_id");
        String vehicleIdStr = request.getParameter("vehicle_id");
        String locationName = request.getParameter("location_name");
        String assignedOfficer = request.getParameter("assigned_officer");

        // Prevent null issues
        if(ownerIdStr == null || driverIdStr == null || vehicleIdStr == null ||
           ownerIdStr.equals("") || driverIdStr.equals("") || vehicleIdStr.equals("")) {
            response.sendRedirect("adminVehicleAllocation.jsp?v=3");
            return;
        }

        int ownerId = Integer.parseInt(ownerIdStr);
        int driverId = Integer.parseInt(driverIdStr);
        int vehicleId = Integer.parseInt(vehicleIdStr);

        VehicleAllocationBean bean = new VehicleAllocationBean();
        bean.setOwnerId(ownerId);
        bean.setDriverId(driverId);
        bean.setVehicleId(vehicleId);
        bean.setLocationName(locationName);
        bean.setAssignedOfficer(assignedOfficer);

        // Check duplicate
        boolean exists = VehicleAllocationDAO.checkAllocationExists(bean);

        if (exists) {
            response.sendRedirect("adminVehicleAllocation.jsp?v=1");   // Already Exist
        } else {
            boolean insertFlag = VehicleAllocationDAO.insertAllocation(bean);

            if (insertFlag) {
                response.sendRedirect("adminVehicleAllocation.jsp?v=2"); // Inserted
            } else {
                response.sendRedirect("adminVehicleAllocation.jsp?v=3"); // Failed
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicleAllocation.jsp?v=3");
    }
%>

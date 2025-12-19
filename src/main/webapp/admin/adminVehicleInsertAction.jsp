<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>

<%
    try {
        // Get parameters from form
        String vehicleNo = request.getParameter("vehicle-no");
        String vehicleType = request.getParameter("vehicle-type");
        String model = request.getParameter("model");
        String ownerIdStr = request.getParameter("owner-id");
        String driverIdStr = request.getParameter("driver-id");
        String status = request.getParameter("status");   // available/assigned/blocked

        int ownerId = Integer.parseInt(ownerIdStr);
        int driverId = Integer.parseInt(driverIdStr);

        // Create VehicleBean object
        VehicleBean bean = new VehicleBean();
        bean.setVehicleNo(vehicleNo);
        bean.setVehicleType(vehicleType);
        bean.setModel(model);
        bean.setOwnerId(ownerId);
        bean.setDriverId(driverId);
        bean.setStatus(status);

        // Check for duplicate vehicle number
        boolean checkFlag = VehicleDAO.checkVehicleDetails(bean);

        if (checkFlag) {
            // Duplicate found
            response.sendRedirect("adminVehicle.jsp?v=1");
        } else {
            boolean flagInsert = VehicleDAO.insertVehicle(bean);
            if (flagInsert) {
                response.sendRedirect("adminVehicle.jsp?v=2"); // Inserted successfully
            } else {
                response.sendRedirect("adminVehicle.jsp?v=3"); // Insert failure
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicle.jsp?v=3");   // Error fallback
    }
%>

<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>

<%
    try {
        int vehicleId = Integer.parseInt(request.getParameter("vehicle-id"));
        int ownerId = Integer.parseInt(request.getParameter("owner-id"));
        int driverId = Integer.parseInt(request.getParameter("driver-id"));
        String vehicleNo = request.getParameter("vehicle-no");
        String vehicleType = request.getParameter("vehicle-type");
        String model = request.getParameter("model");
        String status = request.getParameter("status");

        VehicleBean bean = new VehicleBean();
        bean.setVehicleId(vehicleId);
        bean.setOwnerId(ownerId);
        bean.setDriverId(driverId);
        bean.setVehicleNo(vehicleNo);
        bean.setVehicleType(vehicleType);
        bean.setModel(model);
        bean.setStatus(status);

        boolean updateStatus = VehicleDAO.updateVehicle(bean);

        if (updateStatus)
            response.sendRedirect("adminVehicle.jsp?v=4");  // Updated
        else
            response.sendRedirect("adminVehicle.jsp?v=3");  // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicle.jsp?v=3");
    }
%>

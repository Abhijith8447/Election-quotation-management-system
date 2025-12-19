<%@ page import="com.election.dao.VehicleDAO" %>

<%
    try {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        boolean status = VehicleDAO.deleteVehicle(vehicleId);

        if (status)
            response.sendRedirect("adminVehicle.jsp?v=5");   // Deleted
        else
            response.sendRedirect("adminVehicle.jsp?v=3");   // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicle.jsp?v=3");      // Failure on exception
    }
%>

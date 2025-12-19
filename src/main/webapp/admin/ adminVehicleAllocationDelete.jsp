<%@ page import="com.election.dao.VehicleAllocationDAO" %>

<%
    try {
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        boolean flag = VehicleAllocationDAO.deleteAllocation(locationId);

        if (flag)
            response.sendRedirect("adminVehicleAllocation.jsp?v=5");   
            response.sendRedirect("adminVehicleAllocation.jsp?v=3");   

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminVehicleAllocation.jsp?v=3");       
    }
%>

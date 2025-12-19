<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>

<%
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    List<VehicleBean> list = VehicleDAO.listVehiclesByDriver(driverId);

    out.println("<option value=''>-- Select Vehicle --</option>");
    for (VehicleBean v : list) {
        out.println("<option value='" + v.getVehicleId() + "'>" + v.getVehicleNo() + "</option>");
    }
%>

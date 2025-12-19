<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.DriverBean" %>

<%
    int ownerId = Integer.parseInt(request.getParameter("ownerId"));
    List<DriverBean> list = DriverDAO.listDriversByOwner(ownerId);

    out.println("<option value=''>-- Select Driver --</option>");
    for (DriverBean d : list) {
        out.println("<option value='" + d.getDriverId() + "'>" + d.getDriverName() + "</option>");
    }
%>

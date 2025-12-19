<%@ page import="com.election.dao.DriverDAO" %>

<%
    try {
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        boolean status = DriverDAO.deleteDriver(driverId);

        if (status)
            response.sendRedirect("adminDriver.jsp?v=5");   // Deleted
        else
            response.sendRedirect("adminDriver.jsp?v=3");   // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDriver.jsp?v=3");
    }
%>

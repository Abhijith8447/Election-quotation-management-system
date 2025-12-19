<%@ page import="com.election.dao.DailyRouteDAO" %>

<%
    try {
        int dailyId = Integer.parseInt(request.getParameter("dailyId"));

        boolean status = DailyRouteDAO.deleteDailyRoute(dailyId);

        if (status)
            response.sendRedirect("adminDailyRoute.jsp?v=5");   // Deleted successfully
        else
            response.sendRedirect("adminDailyRoute.jsp?v=3");   // Delete failed

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDailyRoute.jsp?v=3");  // Exception failure
    }
%>

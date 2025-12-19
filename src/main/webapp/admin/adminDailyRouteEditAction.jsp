<%@ page import="com.election.beans.DailyRouteBean" %>
<%@ page import="com.election.dao.DailyRouteDAO" %>

<%
    try {
        int dailyId = Integer.parseInt(request.getParameter("daily-id"));
        int vehicleId = Integer.parseInt(request.getParameter("vehicle-id"));
        String route = request.getParameter("route");
        double startKm = Double.parseDouble(request.getParameter("start-km"));
        double endKm = Double.parseDouble(request.getParameter("end-km"));
        String date = request.getParameter("date");

        DailyRouteBean bean = new DailyRouteBean();
        bean.setDailyId(dailyId);
        bean.setVehicleId(vehicleId);
        bean.setRoute(route);
        bean.setStartKilometer(startKm);
        bean.setEndKilometer(endKm);
        bean.setDate(date);

        boolean status = DailyRouteDAO.updateDailyRoute(bean);

        if (status)
            response.sendRedirect("adminDailyRoute.jsp?v=4");   // Updated
        else
            response.sendRedirect("adminDailyRoute.jsp?v=3");   // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDailyRoute.jsp?v=3");
    }
%>

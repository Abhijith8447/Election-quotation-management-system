<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.DailyRouteBean" %>
<%@ page import="com.election.dao.DailyRouteDAO" %>

<%
    try {
        String vehicleIdStr = request.getParameter("vehicle-id");
        String route = request.getParameter("route");
        String startKmStr = request.getParameter("start-km");
        String endKmStr = request.getParameter("end-km");
        String date = request.getParameter("date");

        int vehicleId = Integer.parseInt(vehicleIdStr);
        double startKm = Double.parseDouble(startKmStr);
        double endKm = Double.parseDouble(endKmStr);

        DailyRouteBean bean = new DailyRouteBean();
        bean.setVehicleId(vehicleId);
        bean.setRoute(route);
        bean.setStartKilometer(startKm);
        bean.setEndKilometer(endKm);
        bean.setDate(date);

        // Optional: If you created a duplicate checker
        boolean checkFlag = DailyRouteDAO.checkDailyRouteExists(bean);

        if (checkFlag) {
            // Duplicate found
            response.sendRedirect("adminDailyRoute.jsp?v=1");
        } else {
            boolean flagInsert = DailyRouteDAO.insertDailyRoute(bean);

            if (flagInsert) {
                response.sendRedirect("adminDailyRoute.jsp?v=2");  // Inserted successfully
            } else {
                response.sendRedirect("adminDailyRoute.jsp?v=3");  // Insert failed
            }
        }

    } catch (Exception e) {
        e.printStackTrace();s
        response.sendRedirect("adminDailyRoute.jsp?v=3");   // Error fallback
    }
%>

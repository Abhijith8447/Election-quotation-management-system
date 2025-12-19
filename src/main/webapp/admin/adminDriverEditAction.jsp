<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.DriverDAO" %>

<%
    try {
        // Get all parameters sent from adminDriverEdit.jsp
        int driverId = Integer.parseInt(request.getParameter("driver-id"));
        int ownerId = Integer.parseInt(request.getParameter("owner-id"));
        String driverName = request.getParameter("driver-name");
        String driverContact = request.getParameter("driver-contact");
        String aadharNo = request.getParameter("aadhar-no");
        String status = request.getParameter("status");

        // Bean object
        DriverBean bean = new DriverBean();
        bean.setDriverId(driverId);
        bean.setOwnerId(ownerId);
        bean.setDriverName(driverName);
        bean.setDriverContact(driverContact);
        bean.setAadharNo(aadharNo);
        bean.setStatus(status);

        // Update via DAO
        boolean updateStatus = DriverDAO.updateDriver(bean);

        if (updateStatus)
            response.sendRedirect("adminDriver.jsp?v=4");  // Updated
        else
            response.sendRedirect("adminDriver.jsp?v=3");  // Update failed

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDriver.jsp?v=3");
    }
%>

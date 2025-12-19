<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Get ownerId from session
    Integer ownerId = (Integer) session.getAttribute("ownerId");

    if (ownerId == null) {
        response.sendRedirect("../login.jsp?v=2");
        return;
    }

    // Fetch values from form
    String driverName = request.getParameter("driver-name");
    String driverContact = request.getParameter("driver-contact");
    String aadharNo = request.getParameter("aadhar-no");
    String status = request.getParameter("status");   // always "pending"

    // Create bean
    DriverBean bean = new DriverBean();
    bean.setDriverName(driverName);
    bean.setDriverContact(driverContact);
    bean.setAadharNo(aadharNo);
    bean.setOwnerId(ownerId);
    bean.setStatus(status);

    try {
        // 1) Check duplicate driver
        boolean exists = DriverDAO.checkDriverDetails(bean);

        if (exists) {
            response.sendRedirect("ownerDriver.jsp?v=3");   // duplicate error
            return;
        }

        // 2) Insert driver
        boolean inserted = DriverDAO.insertDriverDetails(bean);

        if (inserted)
            response.sendRedirect("ownerDriver.jsp?v=2");   // inserted
        else
            response.sendRedirect("ownerDriver.jsp?v=3");   // failure

    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("ownerDriver.jsp?v=3");
    }
%>

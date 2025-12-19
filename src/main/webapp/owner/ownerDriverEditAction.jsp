<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>

<%
    // Get all parameters from the form
    int driverId = Integer.parseInt(request.getParameter("driver-id"));
    int ownerId = Integer.parseInt(request.getParameter("owner-id"));
    String driverName = request.getParameter("driver-name");
    String driverContact = request.getParameter("driver-contact");
    String aadharNo = request.getParameter("aadhar-no");
    String status = request.getParameter("status"); // hidden field

    // Create DriverBean object
    DriverBean bean = new DriverBean();
    bean.setDriverId(driverId);
    bean.setOwnerId(ownerId);
    bean.setDriverName(driverName);
    bean.setDriverContact(driverContact);
    bean.setAadharNo(aadharNo);
    bean.setStatus(status);

    boolean updated = false;

    try {
        updated = DriverDAO.updateDriver(bean); // Update driver
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Redirect based on update status
    if (updated) {
        response.sendRedirect("ownerDriver.jsp?v=4"); // v=4 -> Updated
    } else {
        response.sendRedirect("ownerDriver.jsp?v=3"); // v=3 -> Failure
    }
%>

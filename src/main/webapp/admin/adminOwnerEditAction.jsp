<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>

<%
    try {
        int ownerId = Integer.parseInt(request.getParameter("owner-id"));
        String ownerName = request.getParameter("owner-name");
        String ownerAddress = request.getParameter("owner-address");
        String ownerContact = request.getParameter("owner-contact");

        OwnerBean bean = new OwnerBean();
        bean.setOwnerId(ownerId);
        bean.setOwnerName(ownerName);
        bean.setOwnerAddress(ownerAddress);
        bean.setOwnerContact(ownerContact);

        boolean status = OwnerDAO.updateOwner(bean);

        if (status)
            response.sendRedirect("adminOwner.jsp?v=4");   // Updated
        else
            response.sendRedirect("adminOwner.jsp?v=3");   // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminOwner.jsp?v=3");
    }
%>

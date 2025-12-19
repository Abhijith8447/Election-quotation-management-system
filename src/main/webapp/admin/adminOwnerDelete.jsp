<%@ page import="com.election.dao.OwnerDAO" %>

<%
    try {
        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        boolean status = OwnerDAO.deleteOwner(ownerId);

        if (status)
            response.sendRedirect("adminOwner.jsp?v=5");  // Deleted
        else
            response.sendRedirect("adminOwner.jsp?v=3");  // Failure

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminOwner.jsp?v=3");
    }
%>

<%@ page import="com.election.dao.QuotationDAO" %>

<%
    try {
        int quotationId = Integer.parseInt(request.getParameter("quotationId"));
        boolean status = QuotationDAO.deleteQuotation(quotationId);

        if (status)
            response.sendRedirect("adminQuotation.jsp?v=5");   // Deleted successfully
        else
            response.sendRedirect("adminQuotation.jsp?v=3");   // Delete failed

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminQuotation.jsp?v=3");  // Exception failure
    }
%>

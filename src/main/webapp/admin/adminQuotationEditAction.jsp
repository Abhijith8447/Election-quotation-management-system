<%@ page import="com.election.beans.QuotationBean" %>
<%@ page import="com.election.dao.QuotationDAO" %>

<%
    try {
        int quotationId = Integer.parseInt(request.getParameter("quotation-id"));
        int vehicleId = Integer.parseInt(request.getParameter("vehicle-id"));
        String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");
        String contractStatus = request.getParameter("contract-status");

        QuotationBean bean = new QuotationBean();
        bean.setQuotationId(quotationId);
        bean.setVehicleId(vehicleId);
        bean.setStartDate(startDate);
        bean.setEndDate(endDate);
        bean.setContractStatus(contractStatus);

        boolean updateStatus = QuotationDAO.updateQuotation(bean);

        if (updateStatus)
            response.sendRedirect("adminQuotation.jsp?v=4");  // Updated successfully
        else
            response.sendRedirect("adminQuotation.jsp?v=3");  // Update failed

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminQuotation.jsp?v=3"); // fallback error
    }
%>

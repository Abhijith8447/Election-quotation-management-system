<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@ page import="com.election.beans.QuotationBean" %>
<%@ page import="com.election.dao.QuotationDAO" %>

<%
    try {
        String vehicleIdStr = request.getParameter("vehicle-id");
        String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");
        String contractStatus = request.getParameter("contract-status");

        int vehicleId = Integer.parseInt(vehicleIdStr);

        QuotationBean bean = new QuotationBean();
        bean.setVehicleId(vehicleId);
        bean.setStartDate(startDate);
        bean.setEndDate(endDate);
        bean.setContractStatus(contractStatus);

        
        boolean checkFlag = QuotationDAO.checkQuotationExists(bean);

        if (checkFlag) {
            response.sendRedirect("adminQuotation.jsp?v=1"); 
        } else {
            boolean flagInsert = QuotationDAO.insertQuotation(bean);

            if (flagInsert) {
                response.sendRedirect("adminQuotation.jsp?v=2"); 
            } else {
                response.sendRedirect("adminQuotation.jsp?v=3");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminQuotation.jsp?v=3");
    }
%>

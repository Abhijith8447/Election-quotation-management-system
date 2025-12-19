<%@ page import="com.election.dao.PaymentDAO" %>
<%@ page import="com.election.beans.PaymentBean" %>

<%
    try {
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        double paymentRate = Double.parseDouble(request.getParameter("paymentRate"));
        String paymentYear = request.getParameter("paymentYear");

        PaymentBean bean = new PaymentBean();
        bean.setPaymentId(paymentId);
        bean.setPaymentRate(paymentRate);
        bean.setPaymentYear(paymentYear);

        boolean status = PaymentDAO.updatePayment(bean);

        if (status)
            response.sendRedirect("adminPayment.jsp?v=4");   
        else
            response.sendRedirect("adminPayment.jsp?v=3");   

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminPayment.jsp?v=3");       
    }
%>

<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.dao.PaymentDAO" %>
<%@ page import="com.election.beans.PaymentBean" %>

<%
    int paymentId = Integer.parseInt(request.getParameter("paymentId"));
    PaymentBean bean = PaymentDAO.fetchPaymentById(paymentId);

    if (bean == null) {
        response.sendRedirect("adminPayment.jsp?v=3"); // error
        return;
    }
%>

<div style="width:40%; margin:30px auto; padding:20px; border:1px solid #000; border-radius:8px;">
    <h2 style="text-align:center;">Edit Payment Details</h2>

    <form action="adminPaymentEditAction.jsp" method="post">

        <input type="hidden" name="paymentId" value="<%= bean.getPaymentId() %>">

        <table style="width:100%; font-size:18px;">
            <tr>
                <td>Payment Rate:</td>
                <td>
                    <input type="text" name="paymentRate" value="<%= bean.getPaymentRate() %>" required>
                </td>
            </tr>

            <tr>
                <td>Payment Year:</td>
                <td>
                    <input type="date" name="paymentYear" value="<%= bean.getPaymentYear() %>" required>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center; padding-top:15px;">
                    <input type="submit" value="Update" 
                        style="padding:8px 20px; font-size:16px; cursor:pointer;">
                </td>
            </tr>
        </table>

    </form>
</div>

<%@ include file="../footer.html" %>

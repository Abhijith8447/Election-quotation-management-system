<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.PaymentDAO" %>
<%@ page import="com.election.beans.PaymentBean" %>

<%
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist! Please check...";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS! Failure. Please try again...";
    else if (v.equals("4")) caption = "Updated...";
%>

<div style="text-align:center; margin-top:20px;">
    <h2>PAYMENT DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%= caption %></span>
</div>

<!-- PAYMENT LIST TABLE -->
<div style="width:60%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SL NO</th>
            <th>Payment ID</th>
            <th>Payment Rate</th>
            <th>Payment Year</th>
            <th>Action</th>
        </tr>

        <%
            int i = 1;
            List<PaymentBean> payList = PaymentDAO.listPayments(); // method must return list
            for (PaymentBean pay : payList) {
        %>

        <tr>
            <td><%= i %></td>
            <td><%= pay.getPaymentId() %></td>
            <td><%= pay.getPaymentRate() %></td>
            <td><%= pay.getPaymentYear() %></td>

            <!-- Only EDIT allowed -->
            <td>
                <a href="adminPaymentEdit.jsp?paymentId=<%= pay.getPaymentId() %>">
                    Edit
                </a>
            </td>
        </tr>

        <%
                i++;
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

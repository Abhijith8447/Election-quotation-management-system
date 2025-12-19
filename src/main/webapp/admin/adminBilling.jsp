<%@ page import="com.election.dao.BillingDAO" %>
<%@ page import="com.luminar.model.BillingBean" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.election.dao.DBDAO" %>
<%@ page import="java.sql.*" %>

<%@ include file="adminHeader.jsp" %>

<h2 style="text-align:center;">Billing</h2>

<!-- Owner Selection -->
<form method="get" action="adminBilling.jsp" style="text-align:center; margin:20px;">
    Select Owner:
    <select name="ownerId">
        <%
            Connection con = DBDAO.getDbCon();
            PreparedStatement ps = con.prepareStatement("SELECT owner_id, owner_name FROM owners");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
        %>
            <option value="<%= rs.getInt("owner_id") %>"><%= rs.getString("owner_name") %></option>
        <%
            }
        %>
    </select>
    <button type="submit">Get Billing</button>
</form>

<%
    String ownerParam = request.getParameter("ownerId");
    if (ownerParam != null) {
        int ownerId = Integer.parseInt(ownerParam);

        BillingDAO billingDAO = new BillingDAO();
        BillingBean billing = billingDAO.getBillingDetails(ownerId);

        BigDecimal totalKmRun = billing.getTotalKmRun();
        BigDecimal paymentRate = billing.getPaymentRate();
        BigDecimal totalExpenses = billing.getTotalExpenses();
        BigDecimal totalBillingAmount = billing.getTotalBillingAmount();
%>

<div class="billing-summary" style="width:50%; margin:auto; border:1px solid #ccc; padding:20px;">
    <h3>Billing Summary</h3>
    <p><strong>Total Km Run:</strong> <%= totalKmRun %> km</p>
    <p><strong>Payment Rate:</strong> <%= paymentRate %></p>
    <p><strong>Total Expenses:</strong> <%= totalExpenses %></p>
    <p><strong>Total Billing Amount:</strong> <%= totalBillingAmount %></p>
</div>

<%
    }
%>

<%@ include file="../footer.html" %>

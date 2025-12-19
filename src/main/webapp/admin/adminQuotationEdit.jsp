<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.QuotationBean" %>
<%@ page import="com.election.dao.QuotationDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="java.util.List" %>

<%
    int quotationId = Integer.parseInt(request.getParameter("quotationId"));
    QuotationBean bean = QuotationDAO.fetchQuotationById(quotationId);
%>

<div align="center">
    <h2>Edit Quotation</h2>

    <form method="post" action="adminQuotationEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden Quotation ID -->
            <tr>
                <td></td>
                <td>
                    <input type="hidden" name="quotation-id" value="<%= bean.getQuotationId() %>">
                </td>
            </tr>

            <!-- VEHICLE DROPDOWN -->
            <tr>
                <td><b>Vehicle:</b></td>
                <td>
                    <select name="vehicle-id" style="width:350px;" required>
                        <%
                            List<VehicleBean> vList = VehicleDAO.listVehicles();
                            for (VehicleBean v : vList) {
                                String selected = (v.getVehicleId() == bean.getVehicleId()) ? "selected" : "";
                        %>
                            <option value="<%= v.getVehicleId() %>" <%= selected %>>
                                <%= v.getVehicleNo() %> - <%= v.getVehicleType() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- START DATE -->
            <tr>
                <td><b>Start Date:</b></td>
                <td><input type="date" name="start-date" value="<%= bean.getStartDate() %>" style="width:350px;" required></td>
            </tr>

            <!-- END DATE -->
            <tr>
                <td><b>End Date:</b></td>
                <td><input type="date" name="end-date" value="<%= bean.getEndDate() %>" style="width:350px;" required></td>
            </tr>

            <!-- CONTRACT STATUS -->
            <tr>
                <td><b>Contract Status:</b></td>
                <td>
                    <select name="contract-status" style="width:350px;">
                        <option value="active"   <%= bean.getContractStatus().equals("active") ? "selected" : "" %>>Active</option>
                        <option value="expired"  <%= bean.getContractStatus().equals("expired") ? "selected" : "" %>>Expired</option>
                        <option value="pending"  <%= bean.getContractStatus().equals("pending") ? "selected" : "" %>>Pending</option>
                    </select>
                </td>
            </tr>

            <!-- SUBMIT -->
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE">
                </td>
            </tr>

        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

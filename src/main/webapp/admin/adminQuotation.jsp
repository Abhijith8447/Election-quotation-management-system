<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.QuotationDAO" %>
<%@ page import="com.election.beans.QuotationBean" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>

<%
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist!!! Please check...";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS !!! Failure. Please insert again...";
    else if (v.equals("4")) caption = "Updated...";
    else if (v.equals("5")) caption = "Deleted...";
%>

<div style="text-align:center; margin-top:20px; width:100%;">
    <h2 style="text-align:center; margin:0 auto;">QUOTATION DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div style="width:50%; margin:0 auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="adminQuotationInsert.jsp">
        <table style="margin:0 auto;">

            <!-- VEHICLE DROPDOWN -->
            <tr>
                <td>Vehicle:</td>
                <td>
                    <select name="vehicle-id" style="width:340px;" required>
                        <option value="">-- Select Vehicle --</option>
                        <%
                            List<VehicleBean> vehicleList = VehicleDAO.listVehicles();
                            for (VehicleBean vBean : vehicleList) {
                        %>
                            <option value="<%= vBean.getVehicleId() %>">
                                <%= vBean.getVehicleNo() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <!-- START DATE -->
            <tr>
                <td>Start Date:</td>
                <td><input type="date" name="start-date" required style="width:340px;"></td>
            </tr>

            <!-- END DATE -->
            <tr>
                <td>End Date:</td>
                <td><input type="date" name="end-date" required style="width:340px;"></td>
            </tr>

            <!-- STATUS -->
            <tr>
                <td>Status:</td>
                <td>
                    <select name="contract-status" style="width:340px;">
                        <option value="pending" selected>Pending</option>
                        <option value="approved">Approved</option>
                        <option value="rejected">Rejected</option>
                        <option value="expired">Expired</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Save">
                </td>
            </tr>

        </table>
    </form>
</div>

<br>

<!-- QUOTATION LIST TABLE -->
<div style="width:80%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>Quotation ID</th>
            <th>Vehicle No</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<QuotationBean> qList = QuotationDAO.listQuotations();
            for (QuotationBean qbean : qList) {
        %>

        <tr>
            <td><%= i %></td>
            <td><%= qbean.getQuotationId() %></td>

            <!-- FETCH VEHICLE NO -->
            <td>
                <%
                    VehicleBean veh = VehicleDAO.fetchVehicleById(qbean.getVehicleId());
                    if (veh != null) out.print(veh.getVehicleNo());
                    else out.print("-");
                %>
            </td>

            <td><%= qbean.getStartDate() %></td>
            <td><%= qbean.getEndDate() %></td>
            <td><%= qbean.getContractStatus() %></td>

            <td>
                <a href="adminQuotationEdit.jsp?quotationId=<%= qbean.getQuotationId() %>">Edit</a>
            </td>

            <td>
                <a href="adminQuotationDelete.jsp?quotationId=<%= qbean.getQuotationId() %>"
                    onclick="return confirm('Are you sure you want to delete?')">Delete</a>
            </td>
        </tr>

        <%
                i++;
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

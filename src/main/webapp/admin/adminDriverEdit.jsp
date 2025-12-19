<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.DriverDAO" %>

<%
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    DriverBean bean = DriverDAO.fetchDriverById(driverId);
%>

<div align="center">
    <h2>Edit Driver Status</h2>

    <form method="post" action="adminDriverEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- HIDDEN FIELDS (Admin cannot edit) -->
            <input type="hidden" name="driver-id" value="<%= bean.getDriverId() %>">
            <input type="hidden" name="owner-id" value="<%= bean.getOwnerId() %>">
            <input type="hidden" name="driver-name" value="<%= bean.getDriverName() %>">
            <input type="hidden" name="driver-contact" value="<%= bean.getDriverContact() %>">
            <input type="hidden" name="aadhar-no" value="<%= bean.getAadharNo() %>">

            <!-- VISIBLE STATUS FIELD -->
            <tr>
                <td><b>Status:</b></td>
                <td>
                    <select name="status" style="width:350px;">
                        <option value="pending"  <%= bean.getStatus().equals("pending") ? "selected" : "" %> >Pending</option>
                        <option value="approved" <%= bean.getStatus().equals("approved") ? "selected" : "" %> >Approved</option>
                        <option value="rejected" <%= bean.getStatus().equals("rejected") ? "selected" : "" %> >Rejected</option>
                    </select>
                </td>
            </tr>

            <!-- SUBMIT -->
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE STATUS">
                </td>
            </tr>

        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

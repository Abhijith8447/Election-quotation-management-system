<%@ include file="ownerHeader.jsp" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="java.util.List" %>

<%
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    DriverBean bean = DriverDAO.fetchDriverById(driverId);
%>

<div align="center">
    <h2>Edit Driver</h2>

    <form method="post" action="ownerDriverEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden Driver ID -->
            <input type="hidden" name="driver-id" value="<%= bean.getDriverId() %>">

            <!-- OWNER DROPDOWN (Visible) -->
            <tr>
                <td><b>Owner:</b></td>
                <td>
                    <select name="owner-id" style="width:350px;" required>
                        <%
                            List<OwnerBean> ownerList = OwnerDAO.listOwners();
                            for (OwnerBean o : ownerList) {
                                String selected = (o.getOwnerId() == bean.getOwnerId()) ? "selected" : "";
                        %>
                            <option value="<%= o.getOwnerId() %>" <%= selected %>>
                                <%= o.getOwnerName() %>
                            </option>
                        <% } %>
                    </select>
                </td>
            </tr>

            <!-- DRIVER NAME (Visible) -->
            <tr>
                <td><b>Driver Name:</b></td>
                <td><input type="text" name="driver-name" value="<%= bean.getDriverName() %>" style="width:350px;"></td>
            </tr>

            <!-- CONTACT (Visible) -->
            <tr>
                <td><b>Contact:</b></td>
                <td><input type="text" name="driver-contact" value="<%= bean.getDriverContact() %>" style="width:350px;"></td>
            </tr>

            <!-- AADHAR (Visible) -->
            <tr>
                <td><b>Aadhar No:</b></td>
                <td><input type="text" name="aadhar-no" value="<%= bean.getAadharNo() %>" style="width:350px;"></td>
            </tr>

            <!-- STATUS HIDDEN -->
            <input type="hidden" name="status" value="<%= bean.getStatus() %>">

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

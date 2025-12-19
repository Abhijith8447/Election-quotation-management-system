<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.DriverBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>

<%
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist! Please check...";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS! Failure. Please try again...";
    else if (v.equals("4")) caption = "Updated...";
    else if (v.equals("5")) caption = "Deleted...";
%>

<div style="text-align:center; margin-top:20px;">
    <h2>DRIVER DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%= caption %></span>
</div>

<!-- DRIVER LIST TABLE -->
<div style="width:80%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SL NO</th>
            <th>Driver ID</th>
            <th>Owner</th>
            <th>Driver Name</th>
            <th>Contact</th>
            <th>Aadhar No</th>
            <th>Status</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<DriverBean> driverList = DriverDAO.listDrivers();
            for (DriverBean driver : driverList) {
        %>

        <tr>
            <td><%= i %></td>
            <td><%= driver.getDriverId() %></td>

            <!-- Owner Name -->
            <td>
                <%
                    OwnerBean owner = OwnerDAO.fetchOwnerById(driver.getOwnerId());
                    out.print(owner != null ? owner.getOwnerName() : "-");
                %>
            </td>

            <td><%= driver.getDriverName() %></td>
            <td><%= driver.getDriverContact() %></td>
            <td><%= driver.getAadharNo() %></td>

            <!-- STATUS -->
            <td><%= driver.getStatus() %></td>

            <!-- EDIT (only status editable in next page) -->
            <td>
                <a href="adminDriverEdit.jsp?driverId=<%= driver.getDriverId() %>">Status Update</a>
            </td>

            <!-- DELETE -->
            <td>
                <a href="adminDriverDelete.jsp?driverId=<%= driver.getDriverId() %>"
                   onclick="return confirm('Are you sure you want to delete?')">
                    Delete
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

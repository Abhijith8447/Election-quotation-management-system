<%@ include file="ownerHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.DriverDAO" %>
<%@ page import="com.election.beans.DriverBean" %>

<%
    Integer ownerId = (Integer) session.getAttribute("ownerId");

    if (ownerId == null) {
        response.sendRedirect("../login.jsp?v=2");
        return;
    }

    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS !!! Failure. Please insert again...";
    else if (v.equals("4")) caption = "Updated...";
    else if (v.equals("5")) caption = "Deleted...";
%>

<div style="text-align:center; margin-top:20px; width:100%;">
    <h2>MY DRIVERS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div style="width:50%; margin:0 auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="ownerDriverInsertAction.jsp">
        <table style="margin:0 auto;">

            <!-- Driver Name -->
            <tr>
                <td>Driver Name:</td>
                <td><input type="text" name="driver-name" required style="width:340px;"></td>
            </tr>

            <!-- Contact -->
            <tr>
                <td>Driver Contact:</td>
                <td><input type="text" name="driver-contact" required style="width:340px;"></td>
            </tr>

            <!-- Aadhar -->
            <tr>
                <td>Aadhar No:</td>
                <td><input type="text" name="aadhar-no" required style="width:340px;"></td>
            </tr>

            <!-- STATUS ALWAYS PENDING -->
            <input type="hidden" name="status" value="pending">

            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Save">
                </td>
            </tr>
        </table>
    </form>
</div>

<br>

<!-- DRIVER LIST TABLE -->
<div style="width:80%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>Driver Name</th>
            <th>Contact</th>
            <th>Aadhar No</th>
            <th>Status</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<DriverBean> driverList = DriverDAO.listDriversByOwner(ownerId);

            for (DriverBean driver : driverList) {
        %>
        <tr>
            <td><%= i %></td>
            <td><%= driver.getDriverName() %></td>
            <td><%= driver.getDriverContact() %></td>
            <td><%= driver.getAadharNo() %></td>
            <td><%= driver.getStatus() %></td>

            <td>
                <a href="ownerDriverEdit.jsp?driverId=<%= driver.getDriverId() %>">Edit</a>
            </td>

            <td>
                <a href="ownerDriverDelete.jsp?driverId=<%= driver.getDriverId() %>"
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

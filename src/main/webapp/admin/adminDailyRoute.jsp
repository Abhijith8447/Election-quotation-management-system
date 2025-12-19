<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.DailyRouteDAO" %>
<%@ page import="com.election.beans.DailyRouteBean" %>
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
    <h2 style="text-align:center; margin:0 auto;">DAILY ROUTE DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div style="width:50%; margin:0 auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="adminDailyRouteInsert.jsp">
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

            <!-- ROUTE -->
            <tr>
                <td>Route:</td>
                <td><input type="text" name="route" required style="width:340px;"></td>
            </tr>

            <!-- START KILOMETER -->
            <tr>
                <td>Start Kilometer:</td>
                <td><input type="number" step="0.001" name="start-km" required style="width:340px;"></td>
            </tr>

            <!-- END KILOMETER -->
            <tr>
                <td>End Kilometer:</td>
                <td><input type="number" step="0.001" name="end-km" required style="width:340px;"></td>
            </tr>

            <!-- DATE -->
            <tr>
                <td>Date:</td>
                <td><input type="date" name="date" required style="width:340px;"></td>
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

<!-- DAILY ROUTES LIST TABLE -->
<div style="width:80%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>Daily ID</th>
            <th>Vehicle No</th>
            <th>Route</th>
            <th>Start Km</th>
            <th>End Km</th>
            <th>Actual Km</th>
            <th>Date</th>
            <th colspan="2">Action</th>
        </tr>

        <%
            int i = 1;
            List<DailyRouteBean> dList = DailyRouteDAO.listDailyRoutes();
            for (DailyRouteBean bean : dList) {
        %>

        <tr>
            <td><%= i %></td>
            <td><%= bean.getDailyId() %></td>

            <!-- VEHICLE NUMBER -->
            <td>
                <%
                    VehicleBean vb = VehicleDAO.fetchVehicleById(bean.getVehicleId());
                    if (vb != null) out.print(vb.getVehicleNo());
                    else out.print("-");
                %>
            </td>

            <td><%= bean.getRoute() %></td>
            <td><%= bean.getStartKilometer() %></td>
            <td><%= bean.getEndKilometer() %></td>
            <td><%= bean.getActualKilometer() %></td>
            <td><%= bean.getDate() %></td>

            <td>
                <a href="adminDailyRouteEdit.jsp?dailyId=<%= bean.getDailyId() %>">Edit</a>
            </td>

            <td>
                <a href="adminDailyRouteDelete.jsp?dailyId=<%= bean.getDailyId() %>"
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

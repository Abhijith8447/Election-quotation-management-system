<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.DailyRouteBean" %>
<%@ page import="com.election.dao.DailyRouteDAO" %>
<%@ page import="com.election.dao.VehicleDAO" %>
<%@ page import="com.election.beans.VehicleBean" %>
<%@ page import="java.util.List" %>

<%
    int dailyId = Integer.parseInt(request.getParameter("dailyId"));
    DailyRouteBean bean = DailyRouteDAO.fetchDailyRouteById(dailyId);
%>

<div align="center">
    <h2>Edit Daily Route</h2>

    <form method="post" action="adminDailyRouteEditAction.jsp">
        <table border="0" cellpadding="5">

            <!-- Hidden Daily ID -->
            <tr>
                <td></td>
                <td>
                    <input type="hidden" name="daily-id" value="<%= bean.getDailyId() %>">
                </td>
            </tr>

            <!-- VEHICLE SELECT -->
            <tr>
                <td><b>Vehicle:</b></td>
                <td>
                    <select name="vehicle-id" style="width:250px;">
                        <%
                            List<VehicleBean> vList = VehicleDAO.listVehicles();
                            for (VehicleBean vBean : vList) {
                                String selected = (vBean.getVehicleId() == bean.getVehicleId()) ? "selected" : "";
                        %>
                            <option value="<%= vBean.getVehicleId() %>" <%= selected %>>
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
                <td><b>Route:</b></td>
                <td>
                    <input type="text" name="route" value="<%= bean.getRoute() %>" size="30">
                </td>
            </tr>

            <!-- START KM -->
            <tr>
                <td><b>Start Kilometer:</b></td>
                <td>
                    <input type="number" step="0.001" name="start-km" 
                           value="<%= bean.getStartKilometer() %>" size="30">
                </td>
            </tr>

            <!-- END KM -->
            <tr>
                <td><b>End Kilometer:</b></td>
                <td>
                    <input type="number" step="0.001" name="end-km"
                           value="<%= bean.getEndKilometer() %>" size="30">
                </td>
            </tr>

            <!-- DATE -->
            <tr>
                <td><b>Date:</b></td>
                <td>
                    <input type="date" name="date" value="<%= bean.getDate() %>" size="30">
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="UPDATE">
                </td>
            </tr>

        </table>
    </form>
</div>

<%@ include file="../footer.html" %>

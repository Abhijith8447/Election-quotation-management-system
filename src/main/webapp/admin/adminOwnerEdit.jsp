<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.beans.OwnerBean" %>
<%@ page import="com.election.dao.OwnerDAO" %>

<%
    int ownerId = Integer.parseInt(request.getParameter("ownerId"));
    OwnerBean bean = OwnerDAO.fetchOwnerById(ownerId);
%>

<div align="center">
    <h2>Edit Owner</h2>

    <form method="post" action="adminOwnerEditAction.jsp">
        <table border="0" cellpadding="5">
            <tr>
                <td></td>
                <td>
                    <input type="hidden" name="owner-id" value="<%= bean.getOwnerId() %>">
                </td>
            </tr>

            <tr>
                <td><b>Owner Name:</b></td>
                <td>
                    <input type="text" name="owner-name" value="<%= bean.getOwnerName() %>" size="30">
                </td>
            </tr>

            <tr>
                <td><b>Address:</b></td>
                <td>
                    <input type="text" name="owner-address" value="<%= bean.getOwnerAddress() %>" size="30">
                </td>
            </tr>

            <tr>
                <td><b>Contact No:</b></td>
                <td>
                    <input type="text" name="owner-contact" value="<%= bean.getOwnerContact() %>" size="30">
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

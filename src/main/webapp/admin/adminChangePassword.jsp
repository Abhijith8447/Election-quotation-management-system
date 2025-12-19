<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.LoginDAO" %>
<%@ page import="com.election.beans.LoginBean" %>

<h2 style="text-align:center; margin-top:20px;">All Owners</h2>

<%
    List<LoginBean> owners = LoginDAO.viewOwners();
%>

<table border="1" align="center" cellpadding="10" cellspacing="0" 
       style="background:white; border-collapse:collapse; margin-top:20px;">

    <tr style="background:#2c3e50; color:white;">
        <th>Username</th>
        <th>Password</th>
        <th>Edit</th>
        <th>Delete</th>
    </tr>

    <%
        if (owners != null && !owners.isEmpty()) {
            for (LoginBean owner : owners) {
    %>

    <tr>
        <td><%= owner.getLoginUserName() %></td>
        <td><%= owner.getLoginPassword() %></td>

        <td>
            <a href="adOwnerLoginEdit.jsp?username=<%= owner.getLoginUserName() %>"
               style="color:blue; text-decoration:none;">Edit</a>
        </td>

        <td>
            <a href="adOwnerLoginDelete.jsp?username=<%= owner.getLoginUserName() %>"
               style="color:red; text-decoration:none;"
               onclick="return confirm('Are you sure you want to delete?');">Delete</a>
        </td>
    </tr>

    <%
            }
        } else {
    %>

    <tr>
        <td colspan="4" style="text-align:center; color:red;">No owners found.</td>
    </tr>

    <% } %>

</table>

<%@ include file="../footer.html" %>

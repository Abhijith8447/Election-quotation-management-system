<%@ include file="adminHeader.jsp" %>
<%@ page import="com.election.dao.LoginDAO" %>
<%@ page import="com.election.beans.LoginBean" %>

<%
    String username = request.getParameter("username");
    LoginBean owner = null;

    for (LoginBean lb : LoginDAO.viewOwners()) {
        if (lb.getLoginUserName().equals(username)) {
            owner = lb;
            break;
        }
    }
%>

<h2 style="text-align:center;">Edit Owner</h2>

<form action="adOwnerLoginEditAction.jsp" method="post" 
      style="width:400px; margin:auto; background:#fff; padding:20px;">

    <input type="hidden" name="oldUsername" value="<%= owner.getLoginUserName() %>">

    Username:<br>
    <input type="text" name="username" value="<%= owner.getLoginUserName() %>" required><br><br>

    Password:<br>
    <input type="text" name="password" value="<%= owner.getLoginPassword() %>" required><br><br>

    <button type="submit">Update</button>
</form>

<%@ include file="../footer.html" %>

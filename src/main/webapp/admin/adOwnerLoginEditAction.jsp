<%@ page import="com.election.dao.LoginDAO" %>

<%
    String oldUsername = request.getParameter("oldUsername");
    String newUsername = request.getParameter("username");
    String password = request.getParameter("password");

    boolean updated = LoginDAO.updateOwner(oldUsername, newUsername, password);

    if (updated) {
        response.sendRedirect("adminChangePassword.jsp");
    } else {
        out.print("<h3>Error updating owner.</h3>");
    }
%>

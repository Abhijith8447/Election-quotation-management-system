<%@ page import="com.election.dao.LoginDAO" %>

<%
    String username = request.getParameter("username");

    boolean deleted = LoginDAO.deleteOwner(username);

    if (deleted) {
        response.sendRedirect("adminChangePassword.jsp");
    } else {
        out.print("<h3>Error deleting owner.</h3>");
    }
%>

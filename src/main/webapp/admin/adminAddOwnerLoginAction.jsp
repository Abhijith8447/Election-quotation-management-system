<%@ page import="com.election.dao.LoginDAO" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean added = LoginDAO.addOwner(username, password);

    if (added) {
        response.sendRedirect("adminAddOwnerLogin.jsp?success=1");
    } else {
        response.sendRedirect("adminAddOwnerLogin.jsp?error=1");
    }
%>

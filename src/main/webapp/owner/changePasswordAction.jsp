<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.election.dao.LoginDAO" %>

<%
    String username = (String) session.getAttribute("user");

    // -------- FIXED: Redirect to login.jsp --------
    if (username == null) {
        response.sendRedirect("index.html");
        return;
    }

    String oldPassword = request.getParameter("oldPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    String msg = "";

    if (oldPassword == null || newPassword == null || confirmPassword == null ||
        oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {

        msg = "All fields are required!";

    } else if (!newPassword.equals(confirmPassword)) {

        msg = "New Password and Confirm Password do not match!";

    } else if (!LoginDAO.checkOldPassword(username, oldPassword)) {

        msg = "Old Password is incorrect!";

    } else {

        boolean updated = LoginDAO.updatePassword(username, newPassword);
        if (updated)
            msg = "Password updated successfully!";
        else
            msg = "Failed to update password!";
    }

    response.sendRedirect("changePasswordOwner.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="ownerHeader.jsp" %>

<div class="page-content">

	<h2>CHANGE PASSWORD</h2>
	<br>

	<div
		style="width: 50%; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px;">
    <% 
        String msg = request.getParameter("msg");
        if(msg != null) {
    %>
        <p style="color:red; font-weight:bold;"><%= msg %></p>
    <% } %>

    <form method="post" action="changePasswordAction.jsp">
        <table style="width:100%;">
            <tr>
                <td>Old Password:</td>
                <td><input type="password" name="oldPassword" required style="width:100%;"></td>
            </tr>
            <tr>
                <td>New Password:</td>
                <td><input type="password" name="newPassword" required style="width:100%;"></td>
            </tr>
            <tr>
                <td>Confirm Password:</td>
                <td><input type="password" name="confirmPassword" required style="width:100%;"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Change Password">
                </td>
            </tr>
        </table>
    </form>
</div>
</div>

<%@ include file="../footer.html" %>

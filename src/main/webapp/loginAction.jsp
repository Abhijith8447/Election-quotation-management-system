<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.election.beans.LoginBean" %>
<%@ page import="com.election.dao.LoginDAO" %>
<%@ page import="com.election.dao.DBDAO" %>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("pass");

    if(username != null && password != null) {

        // Create login bean
        LoginBean loginBean = new LoginBean();
        loginBean.setLoginUserName(username);
        loginBean.setLoginPassword(password);

        // Check login
        LoginBean checkBean = LoginDAO.checkLogin(loginBean);

        if(checkBean != null && checkBean.getLoginUserName() != null) {
            String userName = checkBean.getLoginUserName();
            String userRole = checkBean.getLoginRole();

            // Set basic session attributes
            session.setAttribute("user", userName);
            session.setAttribute("role", userRole);

            if("admin".equalsIgnoreCase(userRole)) {
                response.sendRedirect("admin/adminHome.jsp");

            } else if("owner".equalsIgnoreCase(userRole)) {

                // Fetch ownerId from DB using username (not owner_name)
                int ownerId = -1;
                String sql = "SELECT owner_id FROM owners WHERE owner_name=?";
                try (Connection con = DBDAO.getDbCon();
                     PreparedStatement pst = con.prepareStatement(sql)) {

                    pst.setString(1, userName);
                    try (ResultSet rs = pst.executeQuery()) {
                        if(rs.next()) {
                            ownerId = rs.getInt("owner_id");
                        }
                    }

                } catch(Exception e) {
                    e.printStackTrace();
                }

                // Set ownerId in session
                session.setAttribute("ownerId", ownerId);

                // Redirect to ownerHeader.jsp
                response.sendRedirect("owner/ownerHome.jsp");

            } else {
                // Unknown role
                response.sendRedirect("index.html");
            }

        } else {
            out.println("<p style='color:red; text-align:center;'>Invalid username or password</p>");
        }

    } else {
        out.println("<p style='color:red; text-align:center;'>Please enter username and password</p>");
    }
%>

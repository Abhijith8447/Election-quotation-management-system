<%@ page import="com.election.beans.ExpenseBean" %>
<%@ page import="com.election.dao.ExpenseDAO" %>
<%@ page import="java.sql.*" %>

<%
    try {
        int expenseId = Integer.parseInt(request.getParameter("expense_id"));
        String status = request.getParameter("status");

        // Update STATUS only (admin rights)
        String sql = "UPDATE expense SET status=? WHERE expense_id=?";

        Connection con = ExpenseDAO.getConnection();
        PreparedStatement pst = con.prepareStatement(sql);

        pst.setString(1, status);
        pst.setInt(2, expenseId);

        int updated = pst.executeUpdate();

        pst.close();
        con.close();

        if (updated > 0) {
            response.sendRedirect("adminExpense.jsp?v=2");   // Successfully updated
        } else {
            response.sendRedirect("adminExpense.jsp?v=4");   // Failed
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminExpense.jsp?v=4"); // error
    }
%>

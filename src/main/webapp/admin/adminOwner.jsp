<%@ include file="adminHeader.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.election.dao.OwnerDAO" %>
<%@ page import="com.election.beans.OwnerBean" %>

<%
    String v = request.getParameter("v");
    String caption = "";

    if (v == null || v.equals("0")) caption = "";
    else if (v.equals("1")) caption = "Already Exist!!! Please check...";
    else if (v.equals("2")) caption = "Inserted...";
    else if (v.equals("3")) caption = "OOPS !!! Failure. Please insert again...";
    else if (v.equals("4")) caption = "Updated...";
    else if (v.equals("5")) caption = "Deleted...";
%>

<div style="text-align:center; margin-top:20px;">
    <h2>OWNER DETAILS</h2>
</div>

<div style="text-align:center; margin:15px;">
    <span style="color:red; font-weight:bold;"><%=caption%></span>
</div>

<!-- INSERT FORM -->
<div style="width:50%; margin:0 auto; padding:20px; border:1px solid #ccc; border-radius:10px;">
    <form method="post" action="adminOwnerInsertAction.jsp">
        <table style="margin:0 auto;">
            <tr>
                <td>Name:</td>
                <td><input type="text" name="owner-name" style="width:250px;"></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><input type="text" name="owner-address" style="width:250px;"></td>
            </tr>
            <tr>
                <td>Contact:</td>
                <td><input type="text" name="owner-contact" style="width:250px;"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center; padding-top:10px;">
                    <input type="submit" value="Save">
                </td>
            </tr>
        </table>
    </form>
</div>

<br>

<!-- OWNER LIST TABLE -->
<div style="width:70%; margin:0 auto;">
    <table border="1" style="width:100%; border-collapse:collapse;">
        <tr>
            <th>SLNO</th>
            <th>OWNER NAME</th>
            <th>ADDRESS</th>
            <th>CONTACT NO</th>
            <th colspan="2">ACTION</th>
        </tr>

        <%
            int i = 1;
            List<OwnerBean> ownerList = OwnerDAO.listOwners();
            for (OwnerBean owner : ownerList) {
        %>
        <tr>
            <td><%= i %></td>
            <td><%= owner.getOwnerName() %></td>
            <td><%= owner.getOwnerAddress() %></td>
            <td><%= owner.getOwnerContact() %></td>

            <td>
                <a href="adminOwnerEdit.jsp?ownerId=<%= owner.getOwnerId() %>">Edit</a>
            </td>

            <td>
                <a href="adminOwnerDelete.jsp?ownerId=<%= owner.getOwnerId() %>"
                   onclick="return confirm('Are you sure you want to delete?')">Delete</a>
            </td>
        </tr>
        <%
                i++;
            }
        %>
    </table>
</div>

<%@ include file="../footer.html" %>

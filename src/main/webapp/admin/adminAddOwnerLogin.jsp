<%@ include file="adminHeader.jsp" %>

<h2 style="text-align:center;">Add New Owner</h2>

<form action="adminAddOwnerLoginAction.jsp" method="post"
      style="width:400px; margin:auto; background:#fff; padding:20px;">

    Username:<br>
    <input type="text" name="username" required><br><br>

    Password:<br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Add Owner</button>
</form>

<%@ include file="../footer.html" %>

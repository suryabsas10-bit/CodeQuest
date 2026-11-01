
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest - Admin Setup</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="register-container">
    <div class="register-box">

        <h1>Create Admin Account</h1>
        <p>Set up your first CodeQuest administrator.</p>

        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/admin-setup"
              method="post">

            <label>Admin Username</label>
            <input type="text" name="username"
                   maxlength="50" required>

            <label>Admin Password</label>
            <input type="password" name="password"
                   minlength="8" maxlength="128" required>

            <button type="submit" class="register-btn">
                CREATE ADMIN
            </button>

        </form>

    </div>
</div>

</body>
</html>

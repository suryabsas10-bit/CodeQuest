
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Admin Login</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<header>
    <nav class="navbar">
        <h2 class="logo">CODEQUEST</h2>

        <div class="nav-links">
            <a href="index.html">Home</a>
            <a href="login.jsp">Student Login</a>
        </div>
    </nav>
</header>

<div class="register-container">

    <div class="register-box">

        <h1>Admin Login</h1>

        <p>Welcome back, Administrator!</p>

        <%
            String error = (String) request.getAttribute("errorMessage");

            if (error != null) {
        %>
            <div class="error-message">
                <%= error %>
            </div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/admin-login"
              method="post">

            <label>Admin Username</label>

            <input type="text"
                   name="username"
                   placeholder="Enter admin username"
                   required>

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter admin password"
                   required>

            <button type="submit" class="register-btn">
                ADMIN LOGIN
            </button>

        </form>

        <p class="login-text">
            Are you a student?
            <a href="login.jsp">Student Login</a>
        </p>

    </div>

</div>

</body>
</html>

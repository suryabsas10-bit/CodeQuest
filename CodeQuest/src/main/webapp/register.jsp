
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>CodeQuest - Student Registration</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/style.css">
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<header>
    <nav class="navbar">

        <h2 class="logo">CODEQUEST</h2>

        <div class="nav-links">
            <a href="index.html">Home</a>
            <a href="login.jsp">Student Login</a>
            <a href="admin-login.jsp">Admin Login</a>
        </div>

    </nav>
</header>

<div class="register-container">

    <div class="register-box">

        <h1>Create Your Account</h1>

        <p>Join CodeQuest and start your coding journey.</p>

        <%
            String error =
                (String) request.getAttribute("errorMessage");

            String success =
                (String) request.getAttribute("successMessage");

            if (error != null) {
        %>

            <div class="error-message">
                <%= error %>
            </div>

        <%
            }

            if (success != null) {
        %>

            <div class="success-message">
                <%= success %>
            </div>

        <%
            }
        %>

     <form action="<%= request.getContextPath() %>/register"
      method="post">

            <label>Username</label>

            <input type="text"
                   name="username"
                   placeholder="Enter username"
                   minlength="3"
                   maxlength="50"
                   pattern="[a-zA-Z0-9_]{3,50}"
                   required>

            <label>Email Address</label>

            <input type="email"
                   name="email"
                   placeholder="Enter email address"
                   maxlength="100"
                   required>

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Create password"
                   minlength="8"
                   maxlength="128"
                   required>

            <label>Confirm Password</label>

            <input type="password"
                   name="confirmPassword"
                   placeholder="Confirm password"
                   minlength="8"
                   maxlength="128"
                   required>

            <button type="submit" class="register-btn">
                CREATE ACCOUNT
            </button>

        </form>

        <p class="login-text">
            Already have an account?
            <a href="login.jsp">Login Here</a>
        </p>

    </div>

</div>

<div class="register-container">
    <div class="register-box">

        <h1>Join CodeQuest</h1>
        <p>Create your student account</p>

        <!-- Keep your existing registration form here -->

        <div class="login-text">
            Already have an account?
            <a href="<%= request.getContextPath() %>/login.jsp">
                Login
            </a>
        </div>

    </div>
</div>

</body>
</html>

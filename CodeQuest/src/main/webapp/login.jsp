
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CodeQuest - Login</title>
    <link rel="stylesheet" href="css/style.css">
    
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
    
</head>
<body>


<div class="login-container">

    <div class="login-box">

        <h1 class="brand-title">CodeQuest</h1>

        <h2>Student Login</h2>

        <!-- Keep your existing error message here if present -->

        <form action="<%= request.getContextPath() %>/login"
              method="post">

            <label>Username or Email</label>
            <input type="text" name="username" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>

        </form>

        <p class="create-account">
            Don't have an account?
            <a href="<%= request.getContextPath() %>/register.jsp">
                Create Account
            </a>
        </p>

    </div>

</div>
</body>
</html>

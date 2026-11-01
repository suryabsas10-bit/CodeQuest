
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest - Welcome</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background: radial-gradient(circle, #142d53, #080d1a);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
        }

        .main-container {
            width: 100%;
            max-width: 950px;
            text-align: center;
        }

        .logo {
            color: #00e5ff;
            font-size: 48px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #b6c3d4;
            margin-bottom: 45px;
            font-size: 17px;
        }

        .login-options {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .login-card {
            background: #111a2e;
            border: 1px solid #00c8e8;
            border-radius: 18px;
            padding: 40px 25px;
            box-shadow: 0 0 25px rgba(0, 200, 232, 0.12);
            transition: 0.3s;
        }

        .login-card:hover {
            transform: translateY(-7px);
        }

        .login-card h2 {
            color: #00e5ff;
            margin-bottom: 15px;
        }

        .login-card p {
            color: #b6c3d4;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .login-btn {
            display: inline-block;
            width: 100%;
            padding: 14px;
            background: #00d9f5;
            color: #080d1a;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .admin-card {
            border-color: #a78bfa;
        }

        .admin-card h2 {
            color: #c4b5fd;
        }

        .admin-btn {
            background: #8b5cf6;
            color: white;
        }

        .register-link {
            margin-top: 35px;
            color: #b6c3d4;
        }

        .register-link a {
            color: #00e5ff;
            text-decoration: none;
            font-weight: bold;
        }

        .footer {
            margin-top: 45px;
            color: #64748b;
            font-size: 13px;
        }

        @media(max-width: 650px) {
            .login-options {
                grid-template-columns: 1fr;
            }

            .logo {
                font-size: 36px;
            }

            .login-card {
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>
<div class="main-container">

    <h1 class="logo">CodeQuest</h1>

    <p class="subtitle">
        Welcome to the Programming Learning Platform
    </p>

    <div class="login-options">

        <div class="login-card">
            <h2>Student Login</h2>
            <p>
                Learn programming, complete missions,
                earn XP and improve your coding skills.
            </p>

            <a class="login-btn"
               href="<%= request.getContextPath() %>/login.jsp">
                Student Login
            </a>
        </div>

        <div class="login-card admin-card">
            <h2>Admin Login</h2>
            <p>
                Manage programming missions,
                monitor students and view performance reports.
            </p>

            <a class="login-btn admin-btn"
               href="<%= request.getContextPath() %>/admin-login.jsp">
                Admin Login
            </a>
        </div>

    </div>

    <div class="register-link">
        New Student?
        <a href="<%= request.getContextPath() %>/register.jsp">
            Create Account
        </a>
    </div>

    <div class="footer">
        CodeQuest © 2026 | Learn • Practice • Achieve
    </div>

</div>
</body>
</html>

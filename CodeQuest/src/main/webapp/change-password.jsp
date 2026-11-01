
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String passwordMessage =
        (String) session.getAttribute("passwordMessage");

    session.removeAttribute("passwordMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Change Password</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 15px;
            font-family: Arial, sans-serif;
            background: #101827;
            color: white;
        }

        .container {
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 15px;
        }

        h1 {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 8px;
            color: #cbd5e1;
        }

        input {
            width: 100%;
            padding: 13px;
            background: #263449;
            border: 1px solid #475569;
            border-radius: 8px;
            color: white;
            font-size: 15px;
        }

        input:focus {
            outline: 2px solid #0ea5e9;
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 25px;
            background: #0ea5e9;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #0284c7;
        }

        .message {
            padding: 12px;
            margin-bottom: 15px;
            background: #263449;
            color: #38bdf8;
            border-radius: 8px;
            text-align: center;
        }

        .back {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #38bdf8;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>🔐 Change Password</h1>

    <% if (passwordMessage != null) { %>
        <div class="message">
            <%= passwordMessage %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/change-password"
          method="post">

        <label>Current Password</label>
        <input type="password"
               name="currentPassword"
               required>

        <label>New Password</label>
        <input type="password"
               name="newPassword"
               minlength="8"
               required>

        <label>Confirm New Password</label>
        <input type="password"
               name="confirmPassword"
               minlength="8"
               required>

        <button type="submit">
            UPDATE PASSWORD
        </button>

    </form>

    <a class="back"
       href="<%= request.getContextPath() %>/dashboard.jsp">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>

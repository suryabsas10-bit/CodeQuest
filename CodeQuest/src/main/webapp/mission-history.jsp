
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> history =
        (ArrayList<Map<String, Object>>) request.getAttribute("history");

    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Mission History - CodeQuest</title>

    <style>
        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #101827;
            color: white;
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        h1 {
            color: #38bdf8;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            color: #cbd5e1;
            margin-bottom: 30px;
        }

        .history-card {
            background: #1e293b;
            padding: 20px;
            margin-bottom: 18px;
            border-radius: 12px;
            border: 1px solid #334155;
        }

        .history-card h3 {
            color: #38bdf8;
            margin-top: 0;
        }

        .correct {
            color: #4ade80;
            font-weight: bold;
        }

        .incorrect {
            color: #f87171;
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            padding: 12px 20px;
            background: #0284c7;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .empty {
            text-align: center;
            padding: 30px;
            background: #1e293b;
            border-radius: 12px;
        }

        @media (max-width: 600px) {
            body {
                padding: 15px;
            }
        }
    </style>
    
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
    
</head>

<body>

<div class="container">

    <h1>My Mission History</h1>

    <p class="subtitle">
        Welcome, <%= username %>! Review your previous attempts.
    </p>

    <a class="back-btn"
       href="<%= request.getContextPath() %>/dashboard.jsp">
       Back to Dashboard
    </a>

    <% if (history == null || history.isEmpty()) { %>

        <div class="empty">
            <h3>No Mission History Yet</h3>
            <p>Complete a programming mission to see your history here.</p>
        </div>

    <% } else { %>

        <% for (Map<String, Object> item : history) { %>

            <div class="history-card">

                <h3><%= item.get("title") %></h3>

                <p>
                    <strong>Your Answer:</strong>
                    <%= item.get("answer") %>
                </p>

                <p>
                    <strong>Result:</strong>

                    <% if (Boolean.TRUE.equals(item.get("isCorrect"))) { %>
                        <span class="correct">Correct</span>
                    <% } else { %>
                        <span class="incorrect">Incorrect</span>
                    <% } %>
                </p>

                <p>
                    <strong>XP Earned:</strong>
                    <%= item.get("xpEarned") %> XP
                </p>

                <p>
                    <strong>Submitted At:</strong>
                    <%= item.get("completedAt") %>
                </p>

            </div>

        <% } %>

    <% } %>

</div>

</body>
</html>

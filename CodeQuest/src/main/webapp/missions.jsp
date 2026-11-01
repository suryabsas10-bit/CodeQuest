
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.util.Map" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> missions =
        (ArrayList<Map<String, Object>>) request.getAttribute("missions");

    String resultMessage =
        (String) request.getAttribute("resultMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest - Programming Missions</title>

    <link rel="stylesheet" href="css/style.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

    <style>
        .missions-container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
            color: white;
        }

        .missions-heading {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 30px;
        }

        .student-mission-card {
            background: #172b49;
            border: 1px solid #00bcd4;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
        }

        .student-mission-card h2 {
            color: #00e5ff;
        }

        .mission-details {
            color: #9ddbea;
        }

        .answer-option {
            display: block;
            background: #243c5c;
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
        }

        .back-dashboard {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            margin-bottom: 25px;
        }

        .success-message {
            background: #263449;
            color: #38bdf8;
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="missions-container">

    <h1 class="missions-heading">Programming Missions</h1>

    <% if (resultMessage != null) { %>

        <div class="success-message">
            <%= resultMessage %>
        </div>

    <% } %>

    <a class="back-dashboard"
       href="<%= request.getContextPath() %>/dashboard.jsp">
        Back to Dashboard
    </a>

    <% if (missions == null || missions.isEmpty()) { %>

        <div class="student-mission-card">
            <h2>No Missions Available</h2>
            <p>
                Please check again later. New programming missions
                will appear here when the administrator creates them.
            </p>
        </div>

    <% } else {

        for (Map<String, Object> mission : missions) {
    %>

        <div class="student-mission-card">

            <h2><%= mission.get("title") %></h2>

            <p><%= mission.get("description") %></p>

            <p class="mission-details">
                Category: <%= mission.get("category") %>
                |
                Difficulty: <%= mission.get("difficulty") %>
                |
                XP Reward: <%= mission.get("xpReward") %>
            </p>

            <h3>Choose Your Answer</h3>

            <form action="<%= request.getContextPath() %>/submit-mission"
                  method="post">

                <input type="hidden"
                       name="missionId"
                       value="<%= mission.get("id") %>">

                <label class="answer-option">
                    <input type="radio" name="answer" value="A" required>
                    A. <%= mission.get("optionA") %>
                </label>

                <label class="answer-option">
                    <input type="radio" name="answer" value="B">
                    B. <%= mission.get("optionB") %>
                </label>

                <label class="answer-option">
                    <input type="radio" name="answer" value="C">
                    C. <%= mission.get("optionC") %>
                </label>

                <label class="answer-option">
                    <input type="radio" name="answer" value="D">
                    D. <%= mission.get("optionD") %>
                </label>

                <button type="submit" class="register-btn">
                    SUBMIT ANSWER
                </button>

            </form>

        </div>

    <%
        }
    }
    %>

</div>

</body>
</html>

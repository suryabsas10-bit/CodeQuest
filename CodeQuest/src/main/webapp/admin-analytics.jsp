
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    Integer totalStudents = (Integer) request.getAttribute("totalStudents");
    Integer totalMissions = (Integer) request.getAttribute("totalMissions");
    Integer totalSubmissions = (Integer) request.getAttribute("totalSubmissions");
    Integer correctAnswers = (Integer) request.getAttribute("correctAnswers");
    Integer incorrectAnswers = (Integer) request.getAttribute("incorrectAnswers");
    Integer totalXP = (Integer) request.getAttribute("totalXP");

    if (totalStudents == null) totalStudents = 0;
    if (totalMissions == null) totalMissions = 0;
    if (totalSubmissions == null) totalSubmissions = 0;
    if (correctAnswers == null) correctAnswers = 0;
    if (incorrectAnswers == null) incorrectAnswers = 0;
    if (totalXP == null) totalXP = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Admin Analytics</title>

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
            max-width: 1100px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #aab8ca;
            margin-bottom: 35px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .stat-card {
            background: #1e293b;
            padding: 28px 18px;
            border-radius: 15px;
            text-align: center;
            border: 1px solid #334155;
        }

        .stat-card h2 {
            color: #38bdf8;
            font-size: 18px;
        }

        .stat-card p {
            font-size: 32px;
            font-weight: bold;
            color: #4ade80;
            margin: 15px 0 0;
        }

        .correct p {
            color: #4ade80;
        }

        .incorrect p {
            color: #f87171;
        }

        .xp p {
            color: #facc15;
        }

        .back-btn {
            display: inline-block;
            margin-top: 35px;
            padding: 13px 22px;
            background: #0ea5e9;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }

        .back-btn:hover {
            background: #0284c7;
        }

        @media (max-width: 750px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
        .performance-card {
    background: #1e293b;
    padding: 25px;
    margin-top: 25px;
    border-radius: 15px;
    border: 1px solid #334155;
}

.performance-card h2 {
    color: #38bdf8;
}

.progress-background {
    width: 100%;
    height: 18px;
    background: #334155;
    border-radius: 20px;
    overflow: hidden;
    margin: 12px 0 20px;
}

.correct-progress {
    height: 100%;
    background: #4ade80;
}

.incorrect-progress {
    height: 100%;
    background: #f87171;
}

.attempt-total {
    color: #facc15;
    font-weight: bold;
}
    </style>
</head>

<body>

<div class="container">

    <h1>📊 Admin Analytics Dashboard</h1>

    <p class="subtitle">
        Monitor CodeQuest student and mission performance
    </p>

    <div class="stats-grid">

        <div class="stat-card">
            <h2>👨‍🎓 Total Students</h2>
            <p><%= totalStudents %></p>
        </div>

        <div class="stat-card">
            <h2>💻 Total Missions</h2>
            <p><%= totalMissions %></p>
        </div>

        <div class="stat-card">
            <h2>📝 Total Submissions</h2>
            <p><%= totalSubmissions %></p>
        </div>

        <div class="stat-card correct">
            <h2>✅ Correct Answers</h2>
            <p><%= correctAnswers %></p>
        </div>

        <div class="stat-card incorrect">
            <h2>❌ Incorrect Answers</h2>
            <p><%= incorrectAnswers %></p>
        </div>

        <div class="stat-card xp">
            <h2>⭐ Total Student XP</h2>
            <p><%= totalXP %></p>
        </div>

    </div>

<%
    int totalAttempts = correctAnswers + incorrectAnswers;

    int correctPercentage = 0;
    int incorrectPercentage = 0;

    if (totalAttempts > 0) {
        correctPercentage = (correctAnswers * 100) / totalAttempts;
        incorrectPercentage = 100 - correctPercentage;
    }
%>

<div class="performance-card">

    <h2>Mission Performance Analysis</h2>

    <p>Correct Answers: <%= correctPercentage %>%</p>

    <div class="progress-background">
        <div class="correct-progress"
             style="width:<%= correctPercentage %>%;">
        </div>
    </div>

    <p>Incorrect Answers: <%= incorrectPercentage %>%</p>

    <div class="progress-background">
        <div class="incorrect-progress"
             style="width:<%= incorrectPercentage %>%;">
        </div>
    </div>

    <p class="attempt-total">
        Total Attempts: <%= totalAttempts %>
    </p>

</div>

    <center>
        <a class="back-btn"
           href="<%= request.getContextPath() %>/admin-dashboard.jsp">
            ← Back to Admin Dashboard
        </a>
    </center>

</div>

</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    Object studentId = request.getAttribute("studentId");

    if (studentId == null) {
        response.sendRedirect(request.getContextPath() + "/view-students");
        return;
    }

    String username = (String) request.getAttribute("username");
    String email = (String) request.getAttribute("email");

    int totalXp = (Integer) request.getAttribute("totalXp");
    int playerLevel = (Integer) request.getAttribute("playerLevel");
    int attempted = (Integer) request.getAttribute("attempted");
    int correct = (Integer) request.getAttribute("correctAnswers");
    int incorrect = (Integer) request.getAttribute("incorrectAnswers");

    double percentage = (Double) request.getAttribute("percentage");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Performance - CodeQuest</title>

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
    max-width: 1000px;
    margin: auto;
}

h1 {
    text-align: center;
    color: #00e5ff;
}

.profile-card {
    background: #1e293b;
    padding: 25px;
    border-radius: 15px;
    margin: 25px 0;
    line-height: 1.8;
}

.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 18px;
}

.stat-card {
    background: #1e293b;
    padding: 25px;
    border-radius: 12px;
    text-align: center;
}

.stat-card h3 {
    color: #38bdf8;
}

.stat-card h2 {
    font-size: 30px;
}

.xp {
    color: #4ade80;
}

.correct {
    color: #4ade80;
}

.incorrect {
    color: #f87171;
}

.progress-container {
    background: #334155;
    height: 18px;
    border-radius: 20px;
    overflow: hidden;
    margin-top: 15px;
}

.progress-bar {
    height: 100%;
    background: #22c55e;
}

.back-btn {
    display: inline-block;
    margin-top: 30px;
    padding: 12px 22px;
    background: #0ea5e9;
    color: white;
    text-decoration: none;
    border-radius: 8px;
}
</style>
</head>

<body>

<div class="container">

<h1>Student Performance Report</h1>

<div class="profile-card">

    <h2><%= username %></h2>

    <p><strong>Student ID:</strong> <%= studentId %></p>

    <p><strong>Email:</strong> <%= email %></p>

    <p><strong>Player Level:</strong> Level <%= playerLevel %></p>

    <p class="xp">
        <strong>Total XP:</strong> <%= totalXp %> XP
    </p>

</div>

<div class="stats">

    <div class="stat-card">
        <h3>Missions Attempted</h3>
        <h2><%= attempted %></h2>
    </div>

    <div class="stat-card">
        <h3>Correct Answers</h3>
        <h2 class="correct"><%= correct %></h2>
    </div>

    <div class="stat-card">
        <h3>Incorrect Answers</h3>
        <h2 class="incorrect"><%= incorrect %></h2>
    </div>

    <div class="stat-card">
        <h3>Success Rate</h3>
        <h2><%= String.format("%.1f", percentage) %>%</h2>
    </div>

</div>

<div class="profile-card">

    <h2>Mission Performance</h2>

    <p>Correct answer percentage</p>

    <div class="progress-container">
        <div class="progress-bar"
             style="width:<%= percentage %>%;">
        </div>
    </div>

</div>

<a class="back-btn"
   href="<%= request.getContextPath() %>/view-students">
    Back to Students
</a>

</div>

</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check student login session
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");

    Integer totalXp = (Integer) session.getAttribute("totalXp");
    Integer playerLevel = (Integer) session.getAttribute("playerLevel");

    if (totalXp == null) totalXp = 0;
    if (playerLevel == null) playerLevel = 1;
%>

<!DOCTYPE html>
<html>
<head>

<style>
    body {
        margin: 0;
        padding: 25px;
        font-family: Arial, sans-serif;
        background: #101827;
        color: white;
    }

    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
        margin-top: 30px;
    }

    .stat-card {
        background: #1e293b;
        padding: 22px;
        border-radius: 12px;
        border: 1px solid #334155;
        text-align: center;
    }

    .stat-card h3 {
        color: #38bdf8;
    }

    .stat-card p {
        color: #cbd5e1;
    }

    .stat-card a {
        display: inline-block;
        margin-top: 10px;
        padding: 10px 16px;
        background: #0284c7;
        color: white;
        text-decoration: none;
        border-radius: 7px;
    }

    .stat-card a:hover {
        background: #0369a1;
    }
</style>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Student Dashboard</title>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

    <div class="dashboard-container">

        <!-- Dashboard Header -->
        <div class="dashboard-header">

            <h1>Welcome to CodeQuest!</h1>

            <h2>Hello, <%= username %></h2>

            <p>Your programming journey starts here.</p>

        </div>

        <!-- Student Progress Cards -->
        <div class="dashboard-cards">

            <div class="dashboard-card">
                <h3>Total XP</h3>
                <p><%= totalXp %></p>
            </div>

            <div class="dashboard-card">
                <h3>Player Level</h3>
                <p><%= playerLevel %></p>
            </div>

<div class="stats-container">

    <div class="stat-card">
        <h3>My Learning</h3>
        <p>Continue your programming journey!</p>
        <a href="<%= request.getContextPath() %>/student-progress">
            View Progress
        </a>
    </div>

    <div class="stat-card">
        <h3>Mission History</h3>
        <p>Review your previous mission attempts.</p>
        <a href="<%= request.getContextPath() %>/mission-history">
            View History
        </a>
    </div>

    <div class="stat-card">
        <h3>Leaderboard</h3>
        <p>Compare your XP with other students.</p>
        <a href="<%= request.getContextPath() %>/leaderboard">
            View Rankings
        </a>
    </div>

</div>

        </div>

        <!-- Learning Activities -->
        <h2 class="activities-title">Learning Activities</h2>

<div class="dashboard-menu">

    <a href="<%= request.getContextPath() %>/student-missions">
        View Programming Missions
    </a>
<a href="<%= request.getContextPath() %>/leaderboard">
    View Leaderboard
</a>

   <a href="<%= request.getContextPath() %>/student-profile">
    My Profile
</a>
<a href="<%= request.getContextPath() %>/student-progress">
    My Learning Progress
</a>
    <a href="<%= request.getContextPath() %>/logout">
        Logout
    </a>
    <a href="<%= request.getContextPath() %>/change-password.jsp">
    Change Password
</a>

<a href="<%= request.getContextPath() %>/mission-history">
    My Mission History
</a>
</div>

    </div>

</body>
</html>

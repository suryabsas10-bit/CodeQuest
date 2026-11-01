
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String username = (String) request.getAttribute("username");

    Integer totalXp = (Integer) request.getAttribute("totalXp");
    Integer playerLevel = (Integer) request.getAttribute("playerLevel");
    Integer attempted = (Integer) request.getAttribute("attempted");
    Integer correctAnswers = (Integer) request.getAttribute("correctAnswers");

    if (totalXp == null) totalXp = 0;
    if (playerLevel == null) playerLevel = 1;
    if (attempted == null) attempted = 0;
    if (correctAnswers == null) correctAnswers = 0;

    int xpForNextLevel = 100 - (totalXp % 100);
    int progress = totalXp % 100;

    if (totalXp > 0 && totalXp % 100 == 0) {
        xpForNextLevel = 100;
        progress = 0;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Student Progress</title>

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

        .heading {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 30px;
        }

        .welcome {
            text-align: center;
            color: #cbd5e1;
            margin-bottom: 30px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .stat-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
        }

        .stat-card h3 {
            color: #38bdf8;
        }

        .stat-card p {
            font-size: 30px;
            font-weight: bold;
            color: #4ade80;
        }

        .level-card {
            margin-top: 25px;
            padding: 25px;
            background: #1e293b;
            border-radius: 15px;
        }

        .level-card h2 {
            color: #c084fc;
        }

        .progress-bg {
            height: 20px;
            background: #334155;
            border-radius: 20px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #22c55e;
        }

        .achievements {
            margin-top: 25px;
            padding: 25px;
            background: #1e293b;
            border-radius: 15px;
        }

        .achievements h2 {
            color: #facc15;
        }

        .badge-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .achievement {
            background: #263449;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
        }

        .achievement span {
            font-size: 35px;
        }

        .locked {
            opacity: 0.4;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 13px 22px;
            background: #0ea5e9;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }

        @media(max-width: 700px) {
            .stats, .badge-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
    
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
    
</head>

<body>

<div class="container">

    <h1 class="heading">🏆 My Learning Progress</h1>

    <p class="welcome">
        Welcome, <%= username == null ? "Student" : username %>!
        Keep learning and earn more XP.
    </p>

    <div class="stats">

        <div class="stat-card">
            <h3>⭐ Total XP</h3>
            <p><%= totalXp %></p>
        </div>

        <div class="stat-card">
            <h3>🎮 Player Level</h3>
            <p><%= playerLevel %></p>
        </div>

        <div class="stat-card">
            <h3>📝 Missions Attempted</h3>
            <p><%= attempted %></p>
        </div>

    </div>

    <div class="level-card">

        <h2>Level Progress</h2>

        <p>Current Level: <%= playerLevel %></p>

        <div class="progress-bg">
            <div class="progress-fill"
                 style="width:<%= progress %>%;">
            </div>
        </div>

        <p><%= progress %> / 100 XP completed for this level.</p>

        <p>
            <%= xpForNextLevel %> XP needed for the next level.
        </p>

    </div>

    <div class="achievements">

        <h2>🏅 Achievement Badges</h2>

        <div class="badge-list">

            <div class="achievement <%= attempted >= 1 ? "" : "locked" %>">
                <span>🚀</span>
                <h3>First Mission</h3>
                <p>Attempt your first mission.</p>
            </div>

            <div class="achievement <%= correctAnswers >= 5 ? "" : "locked" %>">
                <span>🎯</span>
                <h3>Quick Learner</h3>
                <p>Get 5 correct answers.</p>
            </div>

            <div class="achievement <%= totalXp >= 100 ? "" : "locked" %>">
                <span>👑</span>
                <h3>XP Champion</h3>
                <p>Earn 100 XP.</p>
            </div>

        </div>

    </div>

    <center>
        <a class="back-btn"
           href="<%= request.getContextPath() %>/dashboard.jsp">
            ← Back to Dashboard
        </a>
    </center>

</div>

</body>
</html>

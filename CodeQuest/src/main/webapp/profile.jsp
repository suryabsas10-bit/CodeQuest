
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String username = (String) request.getAttribute("username");
    String email = (String) request.getAttribute("email");

    Integer totalXp = (Integer) request.getAttribute("totalXp");
    Integer playerLevel = (Integer) request.getAttribute("playerLevel");
    Integer attempted = (Integer) request.getAttribute("attempted");
    Integer completed = (Integer) request.getAttribute("completed");

    if (totalXp == null) totalXp = 0;
    if (playerLevel == null) playerLevel = 1;
    if (attempted == null) attempted = 0;
    if (completed == null) completed = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Student Profile</title>

    <link rel="stylesheet" href="css/style.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

    <style>
        .profile-container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
            color: white;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .profile-header h1 {
            color: #00e5ff;
            font-size: 36px;
        }

        .profile-card {
            background: #172b49;
            border: 1px solid #00bcd4;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 25px;
        }

        .profile-card h2 {
            color: #00e5ff;
            margin-bottom: 20px;
        }

        .profile-detail {
            padding: 12px;
            border-bottom: 1px solid #34516e;
            font-size: 17px;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
        }

        .profile-stat {
            background: #243c5c;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
        }

        .profile-stat h3 {
            color: #00e5ff;
        }

        .profile-stat p {
            font-size: 30px;
            font-weight: bold;
        }

        .profile-back {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 13px 22px;
            border-radius: 8px;
            text-decoration: none;
        }

        .profile-back:hover {
            background: #00e5ff;
            color: #06152b;
        }
    </style>
</head>

<body>

<div class="profile-container">

    <div class="profile-header">
        <h1>My CodeQuest Profile</h1>
        <p>Your programming journey and achievements.</p>
    </div>

    <!-- Student Information -->
    <div class="profile-card">

        <h2>Student Information</h2>

        <div class="profile-detail">
            <strong>Username:</strong> <%= username %>
        </div>

        <div class="profile-detail">
            <strong>Email:</strong> <%= email %>
        </div>

        <div class="profile-detail">
            <strong>Student ID:</strong>
            <%= session.getAttribute("userId") %>
        </div>

    </div>

    <!-- Student Statistics -->
    <div class="profile-card">

        <h2>My Learning Statistics</h2>

        <div class="profile-stats">

            <div class="profile-stat">
                <h3>Total XP</h3>
                <p><%= totalXp %></p>
            </div>

            <div class="profile-stat">
                <h3>Player Level</h3>
                <p><%= playerLevel %></p>
            </div>

            <div class="profile-stat">
                <h3>Attempts</h3>
                <p><%= attempted %></p>
            </div>

            <div class="profile-stat">
                <h3>Correct Missions</h3>
                <p><%= completed %></p>
            </div>

        </div>

    </div>

    <!-- Navigation -->
    <div style="text-align:center; margin-top:30px;">

        <a class="profile-back" href="dashboard.jsp">
            Back to Dashboard
        </a>

        <a class="profile-back"
           href="<%= request.getContextPath() %>/student-missions">
            View Missions
        </a>

    </div>

</div>

</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.util.Map" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> missions =
        (ArrayList<Map<String, Object>>) request.getAttribute("missions");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest - Manage Missions</title>
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

        .mission-card {
            background: #172b49;
            border: 1px solid #00bcd4;
            border-radius: 12px;
            padding: 22px;
            margin: 20px 0;
        }

        .mission-card h2 {
            color: #00e5ff;
        }

        .mission-card p {
            line-height: 1.6;
        }

        .mission-options {
            padding-left: 20px;
        }

        .mission-options li {
            margin: 8px 0;
        }

        .mission-meta {
            color: #9ddbea;
        }
        .mission-actions {
    margin-top: 20px;
}

.edit-btn {
    display: inline-block;
    padding: 10px 22px;
    background: #00bcd4;
    color: #ffffff;
    text-decoration: none;
    border-radius: 7px;
    font-weight: bold;
}

.edit-btn:hover {
    background: #0097a7;
}
.delete-btn {
    padding: 10px 22px;
    background: #dc2626;
    color: white;
    border: none;
    border-radius: 7px;
    font-weight: bold;
    cursor: pointer;
}

.delete-btn:hover {
    background: #b91c1c;
}
    </style>
</head>

<body>

<div class="missions-container">

    <h1 style="text-align:center;color:#00e5ff;">
        Manage Programming Missions
    </h1>

    <p style="text-align:center;">
        View all missions created by administrators.
    </p>

    <p style="text-align:center;">
        <a href="add-mission.jsp">+ Create New Mission</a>
        |
        <a href="admin-dashboard.jsp">Back to Dashboard</a>
    </p>

    <%
        if (missions == null || missions.isEmpty()) {
    %>

        <h3 style="text-align:center;">
            No missions available. Create your first mission!
        </h3>

    <%
        } else {
            for (Map<String, Object> mission : missions) {
    %>

        <div class="mission-card">

            <h2><%= mission.get("title") %></h2>

            <p><%= mission.get("description") %></p>

            <p class="mission-meta">
                Category: <%= mission.get("category") %>
                |
                Difficulty: <%= mission.get("difficulty") %>
                |
                XP: <%= mission.get("xpReward") %>
            </p>

            <h3>Answer Options</h3>

            <ul class="mission-options">
                <li>A. <%= mission.get("optionA") %></li>
                <li>B. <%= mission.get("optionB") %></li>
                <li>C. <%= mission.get("optionC") %></li>
                <li>D. <%= mission.get("optionD") %></li>
            </ul>
<div class="mission-actions">

    <a href="<%= request.getContextPath() %>/edit-mission?id=<%= mission.get("id") %>"
       class="edit-btn">
        Edit Mission
    </a>

    <form action="<%= request.getContextPath() %>/delete-mission"
          method="post"
          style="display:inline;"
          onsubmit="return confirm('Are you sure you want to delete this mission?');">

        <input type="hidden" name="id"
               value="<%= mission.get("id") %>">

        <button type="submit" class="delete-btn">
            Delete Mission
        </button>

    </form>

</div>
        </div>

    <%
            }
        }
    %>

</div>

</body>
</html>

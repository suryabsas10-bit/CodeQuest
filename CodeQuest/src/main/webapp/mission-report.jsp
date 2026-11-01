
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.util.Map" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> reports =
        (ArrayList<Map<String, Object>>) request.getAttribute("reports");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Mission Performance - CodeQuest</title>

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
    max-width: 1150px;
    margin: auto;
}

h1 {
    text-align: center;
    color: #00e5ff;
    margin-bottom: 30px;
}

.mission-card {
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 12px;
    padding: 22px;
    margin-bottom: 20px;
}

.mission-card h2 {
    color: #38bdf8;
}

.meta {
    color: #cbd5e1;
    line-height: 1.8;
}

.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
    gap: 12px;
    margin-top: 18px;
}

.stat {
    background: #263449;
    padding: 15px;
    border-radius: 8px;
    text-align: center;
}

.stat h3 {
    margin: 5px 0;
    color: #4ade80;
    font-size: 24px;
}

.stat p {
    margin: 5px 0;
    color: #cbd5e1;
    font-size: 13px;
}

.progress-container {
    height: 15px;
    background: #334155;
    border-radius: 20px;
    overflow: hidden;
    margin-top: 12px;
}

.progress-bar {
    height: 100%;
    background: #22c55e;
}

.empty {
    background: #1e293b;
    padding: 25px;
    text-align: center;
    border-radius: 10px;
}

.back-btn {
    display: inline-block;
    margin-top: 20px;
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

<h1>Mission Performance Report</h1>

<%
    if (reports == null || reports.isEmpty()) {
%>

    <div class="empty">
        No programming missions available.
    </div>

<%
    } else {

        for (Map<String, Object> report : reports) {

            double percentage =
                (Double) report.get("percentage");
%>

    <div class="mission-card">

        <h2><%= report.get("title") %></h2>

        <p class="meta">
            Mission ID: <%= report.get("id") %><br>
            Category: <%= report.get("category") %><br>
            Difficulty: <%= report.get("difficulty") %>
        </p>

        <div class="stats">

            <div class="stat">
                <p>Total Attempts</p>
                <h3><%= report.get("attempted") %></h3>
            </div>

            <div class="stat">
                <p>Correct Answers</p>
                <h3><%= report.get("correct") %></h3>
            </div>

            <div class="stat">
                <p>Incorrect Answers</p>
                <h3><%= report.get("incorrect") %></h3>
            </div>

            <div class="stat">
                <p>Success Rate</p>
                <h3><%= String.format("%.1f", percentage) %>%</h3>
            </div>

        </div>

        <p>Correct Answer Percentage</p>

        <div class="progress-container">
            <div class="progress-bar"
                 style="width:<%= percentage %>%;">
            </div>
        </div>

    </div>

<%
        }
    }
%>

<a class="back-btn"
   href="<%= request.getContextPath() %>/admin-dashboard.jsp">
    Back to Admin Dashboard
</a>

</div>

</body>
</html>

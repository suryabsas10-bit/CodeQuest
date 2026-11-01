<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> students =
        (ArrayList<Map<String, Object>>) request.getAttribute("students");

    if (students == null) {
        students = new ArrayList<Map<String, Object>>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>CodeQuest - Leaderboard</title>

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
            max-width: 850px;
            margin: auto;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #38bdf8;
            font-size: 32px;
        }

        .header p {
            color: #aab8ca;
        }

        .leaderboard {
            background: #1e293b;
            padding: 25px;
            border-radius: 15px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 450px;
        }

        th, td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid #334155;
        }

        th {
            color: #38bdf8;
            background: #263449;
        }

        td {
            color: #e2e8f0;
        }

        tr:hover {
            background: #29384f;
        }

        .rank {
            font-weight: bold;
            color: #facc15;
        }

        .xp {
            color: #4ade80;
            font-weight: bold;
        }

        .level {
            color: #c084fc;
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 22px;
            background: #0ea5e9;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }

        .back-btn:hover {
            background: #0284c7;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #cbd5e1;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>🏆 CodeQuest Leaderboard</h1>
        <p>Compete with other students and become the top programmer!</p>
    </div>

    <div class="leaderboard">

        <% if (students.isEmpty()) { %>

            <div class="empty">
                No students are available in the leaderboard yet.
            </div>

        <% } else { %>

            <table>
                <tr>
                    <th>Rank</th>
                    <th>Student</th>
                    <th>Total XP</th>
                    <th>Level</th>
                </tr>

                <%
                    int rank = 1;

                    for (Map<String, Object> student : students) {
                %>

                <tr>
                    <td class="rank">
                        <%= rank %>
                        <% if (rank == 1) { %> 🥇
                        <% } else if (rank == 2) { %> 🥈
                        <% } else if (rank == 3) { %> 🥉
                        <% } %>
                    </td>

                    <td>
                        <%= student.get("username") %>
                    </td>

                    <td class="xp">
                        <%= student.get("totalXp") %> XP
                    </td>

                    <td class="level">
                        Level <%= student.get("playerLevel") %>
                    </td>
                </tr>

                <%
                        rank++;
                    }
                %>

            </table>

        <% } %>

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
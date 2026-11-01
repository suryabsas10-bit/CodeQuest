
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.util.Map" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> submissions =
        (ArrayList<Map<String, Object>>) request.getAttribute("submissions");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Student Submissions</title>

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
            max-width: 1200px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 30px;
        }

        .table-container {
            background: #1e293b;
            padding: 20px;
            border-radius: 15px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th, td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #334155;
        }

        th {
            background: #263449;
            color: #38bdf8;
        }

        tr:hover {
            background: #29384f;
        }

        .correct {
            color: #4ade80;
            font-weight: bold;
        }

        .incorrect {
            color: #f87171;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #cbd5e1;
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
    </style>
</head>

<body>

<div class="container">

    <h1>📋 Student Mission Submissions</h1>

    <div class="table-container">

        <% if (submissions == null || submissions.isEmpty()) { %>

            <div class="empty">
                No student submissions available yet.
            </div>

        <% } else { %>

            <table>

                <tr>
                    <th>Submission ID</th>
                    <th>Student</th>
                    <th>Mission</th>
                    <th>Answer</th>
                    <th>Result</th>
                    <th>Submitted At</th>
                </tr>

                <% for (Map<String, Object> submission : submissions) { %>

                    <tr>

                        <td>
                            <%= submission.get("id") %>
                        </td>

                        <td>
                            <%= submission.get("username") %>
                        </td>

                        <td>
                            <%= submission.get("title") %>
                        </td>

                        <td>
                            <%= submission.get("answer") %>
                        </td>

                        <td>
                            <% if (Boolean.TRUE.equals(
                                submission.get("isCorrect"))) { %>

                                <span class="correct">Correct</span>

                            <% } else { %>

                                <span class="incorrect">Incorrect</span>

                            <% } %>
                        </td>

                        <td>
                            <%= submission.get("completedAt") %>
                        </td>

                    </tr>

                <% } %>

            </table>

        <% } %>

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

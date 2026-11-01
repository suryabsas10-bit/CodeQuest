
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.util.Map" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    ArrayList<Map<String, Object>> students =
        (ArrayList<Map<String, Object>>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - View Students</title>

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
            margin-bottom: 30px;
        }

        .student-table {
            background: #1e293b;
            padding: 20px;
            border-radius: 15px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th, td {
            padding: 15px;
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

        .empty {
            text-align: center;
            padding: 25px;
            color: #cbd5e1;
        }
        .student-controls {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 20px;
}

.student-controls input,
.student-controls select {
    padding: 12px;
    border: 1px solid #334155;
    border-radius: 8px;
    background: #263449;
    color: white;
    font-size: 14px;
}

.student-controls input {
    flex: 1;
    min-width: 220px;
}

.student-controls select {
    min-width: 150px;
}
.details-btn {
    display: inline-block;
    padding: 9px 14px;
    background: #0ea5e9;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    font-weight: bold;
}

.details-btn:hover {
    background: #0284c7;
}
    </style>
    
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
    
</head>

<body>

<div class="container">

    <h1>👨‍🎓 Registered Students</h1>
<div class="student-controls">

    <input type="text"
           id="studentSearch"
           placeholder="Search username or email..."
           onkeyup="filterStudents()">

    <select id="levelFilter" onchange="filterStudents()">
        <option value="all">All Levels</option>
        <option value="1">Level 1</option>
        <option value="2">Level 2</option>
        <option value="3">Level 3</option>
        <option value="4">Level 4</option>
        <option value="5">Level 5</option>
    </select>

    <select id="xpSort" onchange="sortStudents()">
        <option value="default">Sort by XP</option>
        <option value="high">Highest XP First</option>
        <option value="low">Lowest XP First</option>
    </select>

</div>
    <div class="student-table">

        <% if (students == null || students.isEmpty()) { %>

            <div class="empty">
                No students registered yet.
            </div>

        <% } else { %>

<table id="studentsTable">

    <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Total XP</th>
            <th>Player Level</th>
            <th>Performance</th>
        </tr>
    </thead>

    <tbody>

                <% for (Map<String, Object> student : students) { %>

<tr class="student-row"
    data-username="<%= student.get("username") %>"
    data-email="<%= student.get("email") %>"
    data-level="<%= student.get("playerLevel") %>"
    data-xp="<%= student.get("totalXp") %>">

    <td><%= student.get("id") %></td>

    <td><%= student.get("username") %></td>

    <td><%= student.get("email") %></td>

    <td class="xp">
        <%= student.get("totalXp") %> XP
    </td>

    <td class="level">
        Level <%= student.get("playerLevel") %>
    </td>
    <td>
    <a class="details-btn"
       href="<%= request.getContextPath() %>/student-details?id=<%= student.get("id") %>">
        View Details
    </a>
</td>
</tr>

<% } %>
</tbody>
</table>

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
<script>

function filterStudents() {

    let search = document.getElementById("studentSearch")
                         .value.toLowerCase();

    let level = document.getElementById("levelFilter").value;

    let rows = document.querySelectorAll(".student-row");

    rows.forEach(function(row) {

        let username = row.dataset.username.toLowerCase();
        let email = row.dataset.email.toLowerCase();
        let studentLevel = row.dataset.level;

        let matchesSearch =
            username.includes(search) || email.includes(search);

        let matchesLevel =
            level === "all" || studentLevel === level;

        row.style.display =
            matchesSearch && matchesLevel ? "" : "none";
    });
}

function sortStudents() {

    let table = document.getElementById("studentsTable");
    let rows = Array.from(table.querySelectorAll(".student-row"));

    let sort = document.getElementById("xpSort").value;

    if (sort === "default") return;

    rows.sort(function(a, b) {

        let xpA = Number(a.dataset.xp);
        let xpB = Number(b.dataset.xp);

        return sort === "high" ? xpB - xpA : xpA - xpB;
    });

    let tbody = table.querySelector("tbody");

    rows.forEach(function(row) {
        tbody.appendChild(row);
    });

    filterStudents();
}

</script>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    String adminUsername =
            (String) session.getAttribute("adminUsername");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Admin Dashboard</title>

    <link rel="stylesheet" href="css/style.css">
    
<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">
    
</head>

<body>

<div class="dashboard-container">

    <div class="dashboard-header">

        <h1>CODEQUEST ADMIN PANEL</h1>

        <h2>Welcome, <%= adminUsername %></h2>

        <p>Manage programming missions and student activities.</p>

    </div>

    <h2 class="activities-title">Administration Panel</h2>

    
<div class="dashboard-menu">

    <a href="<%= request.getContextPath() %>/add-mission.jsp">
        Create New Mission
    </a>

    <a href="<%= request.getContextPath() %>/manage-missions">
        Manage Missions
    </a>

    <a href="<%= request.getContextPath() %>/view-students">
        View Students
    </a>
    <a href="<%= request.getContextPath() %>/export-students">
    Download Student Report (Excel)
</a>

    <a href="<%= request.getContextPath() %>/view-submissions">
        View Student Submissions
    </a>

    <a href="<%= request.getContextPath() %>/admin-analytics">
        Admin Analytics
    </a>
<a href="<%= request.getContextPath() %>/mission-report">
    Mission Performance Report
</a>
    <a href="<%= request.getContextPath() %>/admin-logout">
        Logout
    </a>

</div>

</div>

</body>
</html>

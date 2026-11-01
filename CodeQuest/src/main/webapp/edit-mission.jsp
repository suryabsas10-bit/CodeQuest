
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession adminSession = request.getSession(false);

    if (adminSession == null || adminSession.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }

    Object missionId = request.getAttribute("missionId");

    if (missionId == null) {
        response.sendRedirect(request.getContextPath() + "/manage-missions");
        return;
    }

    String title = (String) request.getAttribute("title");
    String description = (String) request.getAttribute("description");
    String category = (String) request.getAttribute("category");
    String difficulty = (String) request.getAttribute("difficulty");
    String optionA = (String) request.getAttribute("optionA");
    String optionB = (String) request.getAttribute("optionB");
    String optionC = (String) request.getAttribute("optionC");
    String optionD = (String) request.getAttribute("optionD");
    String correctAnswer = (String) request.getAttribute("correctAnswer");
    int xpReward = (Integer) request.getAttribute("xpReward");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Mission - CodeQuest</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

<style>
body {
    font-family: Arial, sans-serif;
    background: #101827;
    color: white;
    margin: 0;
    padding: 30px;
}

.container {
    max-width: 650px;
    margin: auto;
    background: #1e293b;
    padding: 30px;
    border-radius: 12px;
}

h2 {
    text-align: center;
    color: #38bdf8;
}

label {
    display: block;
    margin-top: 15px;
}

input, textarea, select {
    width: 100%;
    padding: 11px;
    margin-top: 7px;
    border: none;
    border-radius: 6px;
    box-sizing: border-box;
}

textarea {
    min-height: 90px;
}

button {
    width: 100%;
    padding: 13px;
    margin-top: 22px;
    background: #0ea5e9;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    cursor: pointer;
}

.back {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #38bdf8;
    text-decoration: none;
}
</style>
</head>

<body>

<div class="container">

<h2>Edit Programming Mission</h2>

<form action="<%= request.getContextPath() %>/edit-mission" method="post">

<input type="hidden" name="id" value="<%= missionId %>">

<label>Mission Title</label>
<input type="text" name="title" value="<%= title %>" required>

<label>Description</label>
<textarea name="description" required><%= description %></textarea>

<label>Category</label>
<input type="text" name="category" value="<%= category %>" required>

<label>Difficulty</label>
<select name="difficulty" required>
    <option value="Easy" <%= "Easy".equals(difficulty) ? "selected" : "" %>>Easy</option>
    <option value="Medium" <%= "Medium".equals(difficulty) ? "selected" : "" %>>Medium</option>
    <option value="Hard" <%= "Hard".equals(difficulty) ? "selected" : "" %>>Hard</option>
</select>

<label>Option A</label>
<input type="text" name="optionA" value="<%= optionA %>" required>

<label>Option B</label>
<input type="text" name="optionB" value="<%= optionB %>" required>

<label>Option C</label>
<input type="text" name="optionC" value="<%= optionC %>" required>

<label>Option D</label>
<input type="text" name="optionD" value="<%= optionD %>" required>

<label>Correct Answer</label>
<select name="correctAnswer" required>
    <option value="A" <%= "A".equals(correctAnswer) ? "selected" : "" %>>Option A</option>
    <option value="B" <%= "B".equals(correctAnswer) ? "selected" : "" %>>Option B</option>
    <option value="C" <%= "C".equals(correctAnswer) ? "selected" : "" %>>Option C</option>
    <option value="D" <%= "D".equals(correctAnswer) ? "selected" : "" %>>Option D</option>
</select>

<label>XP Reward</label>
<input type="number" name="xpReward" min="0" value="<%= xpReward %>" required>

<button type="submit">Update Mission</button>

</form>

<a class="back" href="<%= request.getContextPath() %>/manage-missions">
    Back to Manage Missions
</a>

</div>

</body>
</html>
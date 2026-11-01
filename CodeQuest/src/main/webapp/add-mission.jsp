
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest - Create Mission</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="register-container">

    <div class="register-box">

        <h1>Create Programming Mission</h1>

        <p>Add a new coding challenge for students.</p>

        <%
            String error = (String) request.getAttribute("errorMessage");
            String success = (String) request.getAttribute("successMessage");

            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }

            if (success != null) {
        %>
            <div class="success-message"><%= success %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/add-mission"
              method="post">

            <label>Mission Title</label>
            <input type="text" name="title"
                   maxlength="100" required>

            <label>Mission Description</label>
            <textarea name="description"
                      rows="5" required></textarea>

            <label>Category</label>
            <select name="category" required>
                <option value="">Select Category</option>
                <option value="Java">Java</option>
                <option value="Python">Python</option>
                <option value="C">C Programming</option>
                <option value="C++">C++</option>
                <option value="HTML">HTML</option>
                <option value="SQL">SQL</option>
            </select>

            <label>Difficulty</label>
            <select name="difficulty" required>
                <option value="">Select Difficulty</option>
                <option value="Easy">Easy</option>
                <option value="Medium">Medium</option>
                <option value="Hard">Hard</option>
            </select>

            <label>Option A</label>
            <input type="text" name="optionA" maxlength="255" required>

            <label>Option B</label>
            <input type="text" name="optionB" maxlength="255" required>

            <label>Option C</label>
            <input type="text" name="optionC" maxlength="255" required>

            <label>Option D</label>
            <input type="text" name="optionD" maxlength="255" required>

            <label>Correct Answer</label>
            <select name="correctAnswer" required>
                <option value="">Select Correct Answer</option>
                <option value="A">Option A</option>
                <option value="B">Option B</option>
                <option value="C">Option C</option>
                <option value="D">Option D</option>
            </select>

            <label>XP Reward</label>
            <input type="number" name="xpReward"
                   min="1" max="10000" value="50" required>

            <button type="submit" class="register-btn">
                CREATE MISSION
            </button>

        </form>

        <p class="login-text">
            <a href="admin-dashboard.jsp">Back to Admin Dashboard</a>
        </p>

    </div>

</div>

</body>
</html>

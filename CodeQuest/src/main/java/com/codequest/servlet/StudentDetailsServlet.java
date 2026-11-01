
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/student-details")
public class StudentDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            int studentId = Integer.parseInt(
                request.getParameter("id"));

            String sql = "SELECT u.id, u.username, u.email, "
                    + "u.total_xp, u.player_level, "
                    + "COUNT(ms.id) AS attempted, "
                    + "COALESCE(SUM(CASE WHEN ms.is_correct = 1 "
                    + "THEN 1 ELSE 0 END), 0) AS correct_answers "
                    + "FROM users u "
                    + "LEFT JOIN mission_submissions ms "
                    + "ON u.id = ms.user_id "
                    + "WHERE u.id = ? "
                    + "GROUP BY u.id, u.username, u.email, "
                    + "u.total_xp, u.player_level";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, studentId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        int attempted = rs.getInt("attempted");
                        int correct = rs.getInt("correct_answers");

                        int incorrect = attempted - correct;

                        double percentage = attempted == 0
                                ? 0
                                : (correct * 100.0 / attempted);

                        request.setAttribute("studentId",
                                rs.getInt("id"));

                        request.setAttribute("username",
                                rs.getString("username"));

                        request.setAttribute("email",
                                rs.getString("email"));

                        request.setAttribute("totalXp",
                                rs.getInt("total_xp"));

                        request.setAttribute("playerLevel",
                                rs.getInt("player_level"));

                        request.setAttribute("attempted", attempted);
                        request.setAttribute("correctAnswers", correct);
                        request.setAttribute("incorrectAnswers", incorrect);
                        request.setAttribute("percentage", percentage);

                        request.getRequestDispatcher(
                                "/student-details.jsp")
                                .forward(request, response);

                    } else {
                        response.sendError(
                                HttpServletResponse.SC_NOT_FOUND,
                                "Student not found.");
                    }
                }
            }

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student ID.");
        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load student details.", e);
        }
    }
}
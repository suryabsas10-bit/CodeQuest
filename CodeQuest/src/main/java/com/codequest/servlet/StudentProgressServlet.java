
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

@WebServlet("/student-progress")
public class StudentProgressServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String sql =
            "SELECT u.username, u.total_xp, u.player_level, " +
            "COUNT(s.id) AS attempted, " +
            "COALESCE(SUM(CASE WHEN s.is_correct = TRUE THEN 1 ELSE 0 END), 0) AS correctAnswers " +
            "FROM users u " +
            "LEFT JOIN mission_submissions s ON u.id = s.user_id " +
            "WHERE u.id = ? " +
            "GROUP BY u.id, u.username, u.total_xp, u.player_level";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    request.setAttribute("username",
                        rs.getString("username"));

                    request.setAttribute("totalXp",
                        rs.getInt("total_xp"));

                    request.setAttribute("playerLevel",
                        rs.getInt("player_level"));

                    request.setAttribute("attempted",
                        rs.getInt("attempted"));

                    request.setAttribute("correctAnswers",
                        rs.getInt("correctAnswers"));
                }
            }

            request.getRequestDispatcher("/student-progress.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load student progress.", e);
        }
    }
}

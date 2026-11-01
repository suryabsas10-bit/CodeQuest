
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

@WebServlet("/admin-analytics")
public class AdminAnalyticsServlet extends HttpServlet {

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

        String sql =
            "SELECT " +
            "(SELECT COUNT(*) FROM users) AS totalStudents, " +
            "(SELECT COUNT(*) FROM missions) AS totalMissions, " +
            "(SELECT COUNT(*) FROM mission_submissions) AS totalSubmissions, " +
            "(SELECT COUNT(*) FROM mission_submissions WHERE is_correct = TRUE) AS correctAnswers, " +
            "(SELECT COUNT(*) FROM mission_submissions WHERE is_correct = FALSE) AS incorrectAnswers, " +
            "(SELECT COALESCE(SUM(total_xp), 0) FROM users) AS totalXP";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                request.setAttribute("totalStudents",
                    rs.getInt("totalStudents"));

                request.setAttribute("totalMissions",
                    rs.getInt("totalMissions"));

                request.setAttribute("totalSubmissions",
                    rs.getInt("totalSubmissions"));

                request.setAttribute("correctAnswers",
                    rs.getInt("correctAnswers"));

                request.setAttribute("incorrectAnswers",
                    rs.getInt("incorrectAnswers"));

                request.setAttribute("totalXP",
                    rs.getInt("totalXP"));
            }

            request.getRequestDispatcher("/admin-analytics.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load admin analytics.", e);
        }
    }
}

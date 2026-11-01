
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/view-submissions")
public class ViewSubmissionsServlet extends HttpServlet {

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

        ArrayList<Map<String, Object>> submissions = new ArrayList<>();

        String sql =
            "SELECT s.id, u.username, m.title, s.answer, " +
            "s.is_correct, s.completed_at " +
            "FROM mission_submissions s " +
            "JOIN users u ON s.user_id = u.id " +
            "JOIN missions m ON s.mission_id = m.id " +
            "ORDER BY s.completed_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> submission = new HashMap<>();

                submission.put("id", rs.getInt("id"));
                submission.put("username", rs.getString("username"));
                submission.put("title", rs.getString("title"));
                submission.put("answer", rs.getString("answer"));
                submission.put("isCorrect", rs.getBoolean("is_correct"));
                submission.put("completedAt", rs.getTimestamp("completed_at"));

                submissions.add(submission);
            }

            request.setAttribute("submissions", submissions);

            request.getRequestDispatcher("/view-submissions.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load student submissions.", e);
        }
    }
}

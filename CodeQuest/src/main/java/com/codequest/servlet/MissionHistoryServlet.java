
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.codequest.util.DBConnection;

@WebServlet("/mission-history")
public class MissionHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        ArrayList<Map<String, Object>> history = new ArrayList<>();

        String sql = "SELECT m.title, ms.answer, ms.is_correct, " +
                     "CASE WHEN ms.is_correct = 1 THEN m.xp_reward ELSE 0 END AS xp_earned, " +
                     "ms.completed_at " +
                     "FROM mission_submissions ms " +
                     "JOIN missions m ON ms.mission_id = m.id " +
                     "WHERE ms.user_id = ? " +
                     "ORDER BY ms.completed_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();

                    item.put("title", rs.getString("title"));
                    item.put("answer", rs.getString("answer"));
                    item.put("isCorrect", rs.getBoolean("is_correct"));
                    item.put("xpEarned", rs.getInt("xp_earned"));
                    item.put("completedAt", rs.getTimestamp("completed_at"));

                    history.add(item);
                }
            }

            request.setAttribute("history", history);
            request.getRequestDispatcher("/mission-history.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Unable to load mission history.", e);
        }
    }
}

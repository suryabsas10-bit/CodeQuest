
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

@WebServlet("/mission-report")
public class MissionReportServlet extends HttpServlet {

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

        String sql = "SELECT m.id, m.title, m.category, m.difficulty, "
                + "COUNT(ms.id) AS attempted, "
                + "COALESCE(SUM(CASE WHEN ms.is_correct = 1 "
                + "THEN 1 ELSE 0 END), 0) AS correct_answers "
                + "FROM missions m "
                + "LEFT JOIN mission_submissions ms "
                + "ON m.id = ms.mission_id "
                + "GROUP BY m.id, m.title, m.category, m.difficulty "
                + "ORDER BY attempted ASC, m.title ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            java.util.ArrayList<java.util.Map<String, Object>> reports =
                    new java.util.ArrayList<>();

            while (rs.next()) {

                int attempted = rs.getInt("attempted");
                int correct = rs.getInt("correct_answers");
                int incorrect = attempted - correct;

                double percentage = attempted == 0
                        ? 0
                        : correct * 100.0 / attempted;

                java.util.Map<String, Object> report =
                        new java.util.HashMap<>();

                report.put("id", rs.getInt("id"));
                report.put("title", rs.getString("title"));
                report.put("category", rs.getString("category"));
                report.put("difficulty", rs.getString("difficulty"));
                report.put("attempted", attempted);
                report.put("correct", correct);
                report.put("incorrect", incorrect);
                report.put("percentage", percentage);

                reports.add(report);
            }

            request.setAttribute("reports", reports);

            request.getRequestDispatcher("/mission-report.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load mission performance report.", e);
        }
    }
}


package com.codequest.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/export-students")
public class ExportStudentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private String csv(String value) {
        if (value == null) {
            value = "";
        }

        return "\"" + value.replace("\"", "\"\"") + "\"";
    }

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

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader(
            "Content-Disposition",
            "attachment; filename=\"CodeQuest_Student_Report.csv\"");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT u.id, u.username, u.email, u.total_xp, "
                 + "u.player_level, COUNT(ms.id) AS attempted, "
                 + "COALESCE(SUM(CASE WHEN ms.is_correct = 1 "
                 + "THEN 1 ELSE 0 END), 0) AS correct_answers "
                 + "FROM users u "
                 + "LEFT JOIN mission_submissions ms "
                 + "ON u.id = ms.user_id "
                 + "GROUP BY u.id, u.username, u.email, "
                 + "u.total_xp, u.player_level "
                 + "ORDER BY u.total_xp DESC")) {

            try (ResultSet rs = ps.executeQuery();
                 PrintWriter out = response.getWriter()) {

                // UTF-8 BOM helps Excel recognize UTF-8.
                out.write('\uFEFF');

                out.println(
                    "Student ID,Username,Email,Total XP,"
                    + "Player Level,Missions Attempted,"
                    + "Correct Answers,Incorrect Answers");

                while (rs.next()) {

                    int attempted = rs.getInt("attempted");
                    int correct = rs.getInt("correct_answers");
                    int incorrect = attempted - correct;

                    out.println(
                        rs.getInt("id") + ","
                        + csv(rs.getString("username")) + ","
                        + csv(rs.getString("email")) + ","
                        + rs.getInt("total_xp") + ","
                        + rs.getInt("player_level") + ","
                        + attempted + ","
                        + correct + ","
                        + incorrect
                    );
                }

                out.flush();
            }

        } catch (Exception e) {
            throw new ServletException(
                "Unable to export student report.", e);
        }
    }
}

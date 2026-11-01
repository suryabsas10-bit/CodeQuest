
package com.codequest.servlet;
import java.sql.ResultSet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/edit-mission")
public class EditMissionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            String sql = "SELECT * FROM missions WHERE id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        request.setAttribute("missionId", rs.getInt("id"));
                        request.setAttribute("title", rs.getString("title"));
                        request.setAttribute("description", rs.getString("description"));
                        request.setAttribute("category", rs.getString("category"));
                        request.setAttribute("difficulty", rs.getString("difficulty"));
                        request.setAttribute("optionA", rs.getString("option_a"));
                        request.setAttribute("optionB", rs.getString("option_b"));
                        request.setAttribute("optionC", rs.getString("option_c"));
                        request.setAttribute("optionD", rs.getString("option_d"));
                        request.setAttribute("correctAnswer", rs.getString("correct_answer"));
                        request.setAttribute("xpReward", rs.getInt("xp_reward"));

                        request.getRequestDispatcher("/edit-mission.jsp")
                               .forward(request, response);

                    } else {
                        response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Mission not found."
                        );
                    }
                }
            }

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid mission ID."
            );
        } catch (SQLException e) {
            throw new ServletException("Unable to load mission.", e);
        }
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String idText = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");
        String xpText = request.getParameter("xpReward");

        try {
            int id = Integer.parseInt(idText);
            int xpReward = Integer.parseInt(xpText);

            if (title == null || title.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || category == null || difficulty == null
                    || optionA == null || optionB == null
                    || optionC == null || optionD == null
                    || correctAnswer == null
                    || !correctAnswer.matches("[ABCD]")
                    || xpReward < 0) {

                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Please enter valid mission details.");
                return;
            }

            String sql = "UPDATE missions SET title=?, description=?, "
                    + "category=?, difficulty=?, option_a=?, option_b=?, "
                    + "option_c=?, option_d=?, correct_answer=?, xp_reward=? "
                    + "WHERE id=?";

            try (Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, title.trim());
                ps.setString(2, description.trim());
                ps.setString(3, category);
                ps.setString(4, difficulty);
                ps.setString(5, optionA.trim());
                ps.setString(6, optionB.trim());
                ps.setString(7, optionC.trim());
                ps.setString(8, optionD.trim());
                ps.setString(9, correctAnswer);
                ps.setInt(10, xpReward);
                ps.setInt(11, id);

                int updated = ps.executeUpdate();

                if (updated == 0) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND,
                            "Mission not found.");
                    return;
                }
            }

            response.sendRedirect(
                    request.getContextPath() + "/manage-missions");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid mission ID or XP reward.");
        } catch (SQLException e) {
            throw new ServletException("Unable to update mission.", e);
        }
    }
}
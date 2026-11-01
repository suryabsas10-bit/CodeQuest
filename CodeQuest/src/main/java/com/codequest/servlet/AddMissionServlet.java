
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-mission")
public class AddMissionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin session
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");

        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");

        String correctAnswer = request.getParameter("correctAnswer");
        String xpValue = request.getParameter("xpReward");

        try {

            if (title == null || title.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || optionA == null || optionB == null
                    || optionC == null || optionD == null
                    || !correctAnswer.matches("[ABCD]")
                    || xpValue == null) {

                request.setAttribute("errorMessage",
                        "Please complete all mission fields.");

                request.getRequestDispatcher("/add-mission.jsp")
                        .forward(request, response);
                return;
            }

            int xpReward = Integer.parseInt(xpValue);

            if (xpReward < 1 || xpReward > 10000) {
                throw new IllegalArgumentException("Invalid XP reward.");
            }

            int adminId = (Integer) session.getAttribute("adminId");

            String sql = "INSERT INTO missions "
                    + "(title, description, category, difficulty, "
                    + "option_a, option_b, option_c, option_d, "
                    + "correct_answer, xp_reward, created_by) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
                ps.setInt(11, adminId);

                ps.executeUpdate();
            }

            response.sendRedirect(
                    request.getContextPath() + "/manage-missions");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage",
                    "Please enter a valid XP reward and mission details.");

            request.getRequestDispatcher("/add-mission.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException("Unable to create mission.", e);
        }
    }
}

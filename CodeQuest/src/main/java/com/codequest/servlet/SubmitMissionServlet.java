
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/submit-mission")
public class SubmitMissionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String answer = request.getParameter("answer");
        String missionIdValue = request.getParameter("missionId");

        if (answer == null || !answer.matches("[ABCD]")
                || missionIdValue == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid mission answer.");
            return;
        }

        Connection con = null;

        try {
            int missionId = Integer.parseInt(missionIdValue);

            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String sql = "SELECT correct_answer, xp_reward "
                    + "FROM missions WHERE id = ?";

            String correctAnswer;
            int xpReward;

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, missionId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        con.rollback();
                        response.sendError(404, "Mission not found.");
                        return;
                    }

                    correctAnswer = rs.getString("correct_answer");
                    xpReward = rs.getInt("xp_reward");
                }
            }

            boolean isCorrect = answer.equalsIgnoreCase(correctAnswer);

            String insertSql = "INSERT INTO mission_submissions "
                    + "(user_id, mission_id, answer, is_correct) "
                    + "VALUES (?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(insertSql)) {

                ps.setInt(1, userId);
                ps.setInt(2, missionId);
                ps.setString(3, answer);
                ps.setBoolean(4, isCorrect);

                ps.executeUpdate();
            }


int updatedXp = -1;
int updatedLevel = -1;

if (isCorrect) {

    // Read current XP and lock the student record
    String selectXp = "SELECT total_xp FROM users WHERE id = ? FOR UPDATE";

    try (PreparedStatement ps = con.prepareStatement(selectXp)) {

        ps.setInt(1, userId);

        try (ResultSet rs = ps.executeQuery()) {

            if (!rs.next()) {
                throw new SQLException("Student account not found.");
            }

            updatedXp = rs.getInt("total_xp") + xpReward;
        }
    }

    // Calculate level: every 100 XP increases one level
    updatedLevel = (updatedXp / 100) + 1;

    // Update XP and player level
    String updateSql =
            "UPDATE users SET total_xp = ?, player_level = ? WHERE id = ?";

    try (PreparedStatement ps = con.prepareStatement(updateSql)) {

        ps.setInt(1, updatedXp);
        ps.setInt(2, updatedLevel);
        ps.setInt(3, userId);

        ps.executeUpdate();
    }
}


            con.commit();

            if (isCorrect) {
                session.setAttribute("totalXp", updatedXp);
                session.setAttribute("playerLevel", updatedLevel);

                session.setAttribute("resultMessage",
                        "Correct answer! You earned " + xpReward
                        + " XP. Your new level is " + updatedLevel + ".");

            } else {
                session.setAttribute("resultMessage",
                        "Incorrect answer. Better luck next time!");
            }

        } catch (NumberFormatException e) {

            if (con != null) rollbackQuietly(con);

            response.sendError(400, "Invalid mission ID.");
            return;

        } catch (SQLException e) {

            if (con != null) rollbackQuietly(con);

            if ("23000".equals(e.getSQLState())) {
            	session.setAttribute("resultMessage",
            	        "You have already attempted this mission.");
            } else {
                throw new ServletException("Submission failed.", e);
            }

        } catch (Exception e) {

            if (con != null) rollbackQuietly(con);

            throw new ServletException("Unable to submit mission.", e);

        } finally {

            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    log("Unable to close database connection.", e);
                }
            }
        }

        response.sendRedirect(
                request.getContextPath() + "/student-missions");
    }

    private void rollbackQuietly(Connection con) {
        try {
            con.rollback();
        } catch (SQLException e) {
            log("Transaction rollback failed.", e);
        }
    }
}

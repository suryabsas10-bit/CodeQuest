
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codequest.util.DBConnection;
import com.codequest.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null ||
            confirmPassword == null ||
            currentPassword.isEmpty() || newPassword.isEmpty() ||
            confirmPassword.isEmpty()) {

            session.setAttribute("passwordMessage",
                "Please fill in all password fields.");

            response.sendRedirect(request.getContextPath() + "/change-password.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("passwordMessage",
                "New password and confirmation do not match.");

            response.sendRedirect(request.getContextPath() + "/change-password.jsp");
            return;
        }

        if (newPassword.length() < 8) {
            session.setAttribute("passwordMessage",
                "New password must contain at least 8 characters.");

            response.sendRedirect(request.getContextPath() + "/change-password.jsp");
            return;
        }

        String sql = "SELECT password FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    throw new ServletException("Student account not found.");
                }

                String storedPassword = rs.getString("password");

                if (!PasswordUtil.verifyPassword(
                        currentPassword, storedPassword)) {

                    session.setAttribute("passwordMessage",
                        "Current password is incorrect.");

                    response.sendRedirect(
                        request.getContextPath() + "/change-password.jsp");
                    return;
                }
            }

            String hashedPassword =
                PasswordUtil.hashPassword(newPassword);

            String updateSql = "UPDATE users SET password = ? WHERE id = ?";

            try (PreparedStatement updatePs =
                    con.prepareStatement(updateSql)) {

                updatePs.setString(1, hashedPassword);
                updatePs.setInt(2, userId);
                updatePs.executeUpdate();
            }

            session.setAttribute("passwordMessage",
                "Password changed successfully!");

            response.sendRedirect(
                request.getContextPath() + "/change-password.jsp");

        } catch (Exception e) {
            throw new ServletException("Unable to change password.", e);
        }
    }
}

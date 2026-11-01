
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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || email == null ||
                password == null || confirmPassword == null ||
                !password.equals(confirmPassword)) {

            request.setAttribute("errorMessage",
                    "Please enter valid details and matching passwords.");
            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String checkSql =
                    "SELECT id FROM users WHERE username = ? OR email = ?";

            try (PreparedStatement check = con.prepareStatement(checkSql)) {

                check.setString(1, username);
                check.setString(2, email);

                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("errorMessage",
                                "Username or email already exists.");
                        request.getRequestDispatcher("/register.jsp")
                                .forward(request, response);
                        return;
                    }
                }
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            String insertSql =
                    "INSERT INTO users (username, email, password, total_xp, player_level) VALUES (?, ?, ?, 0, 1)";

            try (PreparedStatement insert = con.prepareStatement(insertSql)) {

                insert.setString(1, username);
                insert.setString(2, email);
                insert.setString(3, hashedPassword);

                insert.executeUpdate();
            }

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            throw new ServletException("Registration failed.", e);
        }
    }
}

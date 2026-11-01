
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

@WebServlet("/admin-setup")
public class AdminSetup extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()
                || password == null || password.length() < 8) {

            request.setAttribute("errorMessage",
                    "Enter a username and a password of at least 8 characters.");
            request.getRequestDispatcher("/admin-setup.jsp")
                    .forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String checkSql = "SELECT id FROM admins WHERE username = ?";

            try (PreparedStatement check = con.prepareStatement(checkSql)) {
                check.setString(1, username.trim());

                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("errorMessage",
                                "This admin username already exists.");
                        request.getRequestDispatcher("/admin-setup.jsp")
                                .forward(request, response);
                        return;
                    }
                }
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            String insertSql =
                    "INSERT INTO admins (username, password) VALUES (?, ?)";

            try (PreparedStatement insert = con.prepareStatement(insertSql)) {
                insert.setString(1, username.trim());
                insert.setString(2, hashedPassword);
                insert.executeUpdate();
            }

            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");

        } catch (Exception e) {
            throw new ServletException("Admin setup failed.", e);
        }
    }
}

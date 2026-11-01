
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private boolean verifyPassword(String password, String storedHash)
            throws Exception {

        String[] parts = storedHash.split(":");

        int iterations = Integer.parseInt(parts[0]);
        byte[] salt = Base64.getDecoder().decode(parts[1]);
        byte[] expectedHash = Base64.getDecoder().decode(parts[2]);

        KeySpec spec = new PBEKeySpec(
                password.toCharArray(), salt, iterations, 256);

        SecretKeyFactory factory =
                SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        byte[] actualHash = factory.generateSecret(spec).getEncoded();

        return MessageDigest.isEqual(expectedHash, actualHash);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String sql = "SELECT id, username, password FROM admins WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String storedHash = rs.getString("password");

                    if (storedHash != null &&
                            verifyPassword(password, storedHash)) {

                        HttpSession session = request.getSession();

                        session.setAttribute("adminId", rs.getInt("id"));
                        session.setAttribute("adminUsername",
                                rs.getString("username"));

                        response.sendRedirect(
                                request.getContextPath() + "/admin-dashboard.jsp");
                        return;
                    }
                }

                request.setAttribute("errorMessage",
                        "Invalid admin username or password.");

                request.getRequestDispatcher("/admin-login.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException("Admin login failed.", e);
        }
    }
}

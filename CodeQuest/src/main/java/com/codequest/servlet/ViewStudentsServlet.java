
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/view-students")
public class ViewStudentsServlet extends HttpServlet {

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

        ArrayList<Map<String, Object>> students = new ArrayList<>();

        String sql = "SELECT id, username, email, total_xp, player_level "
                   + "FROM users ORDER BY total_xp DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();

                student.put("id", rs.getInt("id"));
                student.put("username", rs.getString("username"));
                student.put("email", rs.getString("email"));
                student.put("totalXp", rs.getInt("total_xp"));
                student.put("playerLevel", rs.getInt("player_level"));

                students.add(student);
            }

            request.setAttribute("students", students);

            request.getRequestDispatcher("/view-students.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                "Unable to load student details.", e);
        }
    }
}

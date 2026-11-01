package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.codequest.util.DBConnection;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        ArrayList<Map<String, Object>> students = new ArrayList<>();

        String sql = "SELECT username, total_xp, player_level " +
                     "FROM users " +
                     "ORDER BY total_xp DESC, player_level DESC, username ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();

                student.put("username", rs.getString("username"));
                student.put("totalXp", rs.getInt("total_xp"));
                student.put("playerLevel", rs.getInt("player_level"));

                students.add(student);
            }

            request.setAttribute("students", students);

            request.getRequestDispatcher("/leaderboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Unable to load leaderboard.", e);
        }
    }
}
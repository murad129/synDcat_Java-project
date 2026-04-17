package com.mycompany.syndcat;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SaveChangesServlet")
public class SaveChangesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        if (username == null) {
            session.setAttribute("errorMsg", "Please login first.");
            response.sendRedirect("login.jsp");
            return;
        }

        String deletedText = request.getParameter("deleted_text");
        String newText = request.getParameter("new_text");

        if (deletedText == null || deletedText.trim().isEmpty() ||
            newText == null || newText.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Both fields are required.");
            response.sendRedirect("changes.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            String sql = "INSERT INTO changes (deleted_text, new_text, created_at) VALUES (?, ?, NOW())";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, deletedText.trim());
                ps.setString(2, newText.trim());

                int result = ps.executeUpdate();
                if (result > 0) {
                    session.setAttribute("successMsg", "Change saved successfully.");
                } else {
                    session.setAttribute("errorMsg", "Failed to save change.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database error: " + e.getMessage());
        }

        response.sendRedirect("changes.jsp");
    }
}
package com.mycompany.syndcat;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Password hashing
        String hashedPassword = hashPassword(password);

        HttpSession session = request.getSession();

        try (Connection conn = DBConnect.getConnection()) {

            // Check if email already exists
            String checkSql = "SELECT id FROM users WHERE email=?";
            try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                checkPs.setString(1, email);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        session.setAttribute("errorMsg", "Email Already Exists! Try another.");
                        response.sendRedirect("signup.jsp");
                        return;
                    }
                }
            }

            // Insert new user
            String insertSql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, hashedPassword);

                int result = ps.executeUpdate();
                if (result > 0) {
                    session.setAttribute("successMsg", "Signup Successful! Please Login.");
                    response.sendRedirect("login.jsp");
                } else {
                    session.setAttribute("errorMsg", "Something went wrong on server!");
                    response.sendRedirect("signup.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error!");
            response.sendRedirect("signup.jsp");
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
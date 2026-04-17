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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = hashPassword(password);  // hash entered password

        HttpSession session = request.getSession();

        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        if (hashedPassword.equals(dbPassword)) {
                            // Successful login
                            session.setAttribute("userEmail", rs.getString("email"));
                            session.setAttribute("username", rs.getString("username")); // consistent name
                            response.sendRedirect("index.html"); // or "dashboard.jsp"
                        } else {
                            session.setAttribute("errorMsg", "Invalid Email or Password");
                            response.sendRedirect("login.jsp");
                        }
                    } else {
                        session.setAttribute("errorMsg", "User not found");
                        response.sendRedirect("login.jsp");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Server Error!");
            response.sendRedirect("login.jsp");
        }
    }

    // Same hash method as in SignupServlet
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
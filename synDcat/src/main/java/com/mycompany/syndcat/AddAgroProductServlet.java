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

@WebServlet("/AddAgroProductServlet")
public class AddAgroProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Use consistent session attribute name (set in LoginServlet)
        String username = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("userEmail");
        // Optional: get farmerId from request (if passed from farmerdetails.jsp)
        String farmerIdStr = request.getParameter("farmerId");

        if (username == null || email == null) {
            session.setAttribute("errorMsg", "Please login first!");
            response.sendRedirect("login.jsp");
            return;
        }

        String productName = request.getParameter("productname");
        String productDesc = request.getParameter("productdesc");
        String priceStr = request.getParameter("price");

        if (productName == null || productName.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Product name is required!");
            response.sendRedirect("addagroproducts.jsp");
            return;
        }

        int price;
        try {
            price = Integer.parseInt(priceStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Price!");
            response.sendRedirect("addagroproducts.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            // If farmerId is provided, store it (optional)
            String sql = "INSERT INTO addagroproducts (username, email, productname, productdesc, price, farmer_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, productName);
            ps.setString(4, productDesc);
            ps.setInt(5, price);
            if (farmerIdStr != null && !farmerIdStr.isEmpty()) {
                ps.setInt(6, Integer.parseInt(farmerIdStr));
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }

            int result = ps.executeUpdate();

            if (result > 0) {
                session.setAttribute("successMsg", "Product Added Successfully!");
                response.sendRedirect("agroproducts.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to Add Product!");
                response.sendRedirect("addagroproducts.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error: " + e.getMessage());
            response.sendRedirect("addagroproducts.jsp");
        }
    }
}
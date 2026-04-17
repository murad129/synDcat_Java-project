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

@WebServlet("/RegisterFarmerServlet")
public class RegisterFarmerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String farmerName = request.getParameter("farmername");
        String nidNumber = request.getParameter("nidnumber");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");
        String farmingType = request.getParameter("farmingtype");

        HttpSession session = request.getSession();
        
        // সেশন থেকে লগইন করা ইউজারের নাম ধরছি
        String loggedInUsername = (String) session.getAttribute("username");
        if (loggedInUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // --- Basic Validation ---
        if (farmerName == null || farmerName.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Farmer Name is required.");
            response.sendRedirect("farmer.jsp");
            return;
        }
        if (nidNumber == null || nidNumber.trim().isEmpty()) {
            session.setAttribute("errorMsg", "NID Number is required.");
            response.sendRedirect("farmer.jsp");
            return;
        }
        // NID length validation (10 or 17 digits)
        if (!nidNumber.matches("\\d{10}|\\d{17}")) {
            session.setAttribute("errorMsg", "NID must be 10 or 17 digits.");
            response.sendRedirect("farmer.jsp");
            return;
        }

        int age = 0;
        try {
            age = Integer.parseInt(ageStr);
            if (age < 18 || age > 120) {
                session.setAttribute("errorMsg", "Age must be between 18 and 120.");
                response.sendRedirect("farmer.jsp");
                return;
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Age!");
            response.sendRedirect("farmer.jsp");
            return;
        }

        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Phone Number is required.");
            response.sendRedirect("farmer.jsp");
            return;
        }
        // Simple phone validation (Bangladeshi format)
        if (!phoneNumber.matches("01[3-9]\\d{8}")) {
            session.setAttribute("errorMsg", "Phone number must be a valid Bangladeshi number (e.g., 017xxxxxxx).");
            response.sendRedirect("farmer.jsp");
            return;
        }

        if (address == null || address.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Address is required.");
            response.sendRedirect("farmer.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            // নতুন কলাম 'username' এবং তার জন্য একটি '?' যোগ করা হয়েছে
            String sql = "INSERT INTO register (farmername, nidnumber, age, gender, phonenumber, address, farming, username) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, farmerName.trim());
                ps.setString(2, nidNumber.trim());
                ps.setInt(3, age);
                ps.setString(4, gender);
                ps.setString(5, phoneNumber.trim());
                ps.setString(6, address.trim());
                ps.setString(7, farmingType);
                ps.setString(8, loggedInUsername); // লগইন করা ইউজারনেমটি ডাটাবেসে সেভ হচ্ছে

                int result = ps.executeUpdate();
                if (result > 0) {
                    session.setAttribute("successMsg", "Farmer Registered Successfully!");
                    response.sendRedirect("farmerdetails.jsp");
                } else {
                    session.setAttribute("errorMsg", "Failed to Register Farmer. Please try again.");
                    response.sendRedirect("farmer.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error! Please contact support.");
            response.sendRedirect("farmer.jsp");
        }
    }
}
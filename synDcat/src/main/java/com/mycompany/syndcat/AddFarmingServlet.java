package com.mycompany.syndcat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddFarmingServlet")
public class AddFarmingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // JSP ফর্ম থেকে farmingType এর মান গ্রহণ করা
        String farmingType = request.getParameter("farmingType");
        
        HttpSession session = request.getSession();

        try {
            // ডেটাবেস কানেকশন নেওয়া
            Connection conn = DBConnect.getConnection(); 
            
            // ⚠️ আপনার ডেটাবেস টেবিলের আসল নাম এখানে দিন (যেমন: "farming" বা "farming_info")
            String tableName = "farming"; 
            
            // ডেটাবেসে ইনসার্ট করার আপডেট করা SQL কোয়েরি
            String sql = "INSERT INTO " + tableName + " (farmingtype) VALUES (?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // কলামে ভ্যালু সেট করা
            ps.setString(1, farmingType);
            
            // কোয়েরি এক্সিকিউট করা
            int i = ps.executeUpdate();
            
            if (i > 0) {
                session.setAttribute("successMsg", "Farming type added successfully!");
                response.sendRedirect("farming.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to add farming type. Please try again.");
                response.sendRedirect("farming.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Server Error: " + e.getMessage());
            response.sendRedirect("farming.jsp");
        }
    }
}
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

@WebServlet("/UpdateFarmerServlet")
public class UpdateFarmerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String farmerName = request.getParameter("farmername");
        String nidNumber = request.getParameter("nidnumber");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");
        String farmingType = request.getParameter("farmingtype");

        HttpSession session = request.getSession();

        int id, age;

        try {
            id = Integer.parseInt(idStr);
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Input!");
            response.sendRedirect("farmerdetails.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {

            String sql = "UPDATE register SET farmername=?, nidnumber=?, age=?, gender=?, phonenumber=?, address=?, farming=? WHERE rid=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, farmerName);
            ps.setString(2, nidNumber);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setString(5, phoneNumber);
            ps.setString(6, address);
            ps.setString(7, farmingType);
            ps.setInt(8, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                session.setAttribute("successMsg", "Farmer updated successfully!");
                response.sendRedirect("farmerdetails.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to update farmer!");
                response.sendRedirect("edit.jsp?id=" + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error!");
            response.sendRedirect("farmerdetails.jsp");
        }
    }
}
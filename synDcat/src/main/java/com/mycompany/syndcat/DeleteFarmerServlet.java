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

@WebServlet("/DeleteFarmerServlet")
public class DeleteFarmerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        HttpSession session = request.getSession();

        int id;

        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Farmer ID!");
            response.sendRedirect("farmerdetails.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {

            String sql = "DELETE FROM register WHERE rid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                session.setAttribute("successMsg", "Farmer deleted successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to delete farmer!");
            }

            response.sendRedirect("farmerdetails.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error!");
            response.sendRedirect("farmerdetails.jsp");
        }
    }
}
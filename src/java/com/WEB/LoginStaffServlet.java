/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author M S I
 */
@WebServlet(name = "LoginStaffServlet", urlPatterns = {"/LoginStaffServlet"})
public class LoginStaffServlet extends HttpServlet {
private String mapRole(String inputRole) {
    switch (inputRole) {
        case "manager":
            return "Manager";
        case "staff":
            return "Operational Staff";
        case "delPerson":
            return "Delivery Personnel";
        default:
            return "";
    }
}

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String staffEmail = request.getParameter("staffEmail");
        String staffPassword = request.getParameter("staffPassword");
        String inputRole = request.getParameter("role");
        
        // Debugging: Print the values to check if they're being retrieved correctly
        System.out.println("Email: " + staffEmail);
        System.out.println("Password: " + staffPassword);  // Check if password is retrieved correctly
        System.out.println("Selected Role: " + inputRole);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load database driver and establish connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin");

            // Query to authenticate user and fetch role
            String sql = "SELECT * FROM staff WHERE staffEmail = ? AND staffPassword = ? AND role = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, staffEmail);
            stmt.setString(2, staffPassword);
            stmt.setString(3, mapRole(inputRole)); // mapped to match DB value

            rs = stmt.executeQuery();

            if (rs.next()) {
                // Start session and store user details
                HttpSession session = request.getSession();
                session.setAttribute("staffName", rs.getString("staffName"));
                session.setAttribute("staffEmail", rs.getString("staffEmail"));
                session.setAttribute("staffPassword", rs.getString("staffPassword"));
                session.setAttribute("staffPhone", rs.getString("staffPhone"));
                session.setAttribute("role", rs.getString("role"));
                session.setAttribute("staffID", rs.getInt("staffID"));
                session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

                // Redirect based on role
                String role = rs.getString("role");
                session.setAttribute("role", role);  // Set role to session

                if ("Manager".equalsIgnoreCase(role)) {
                    response.sendRedirect("NewOrderCountServlet");
                } else if ("Operational Staff".equalsIgnoreCase(role)) {
                    response.sendRedirect("staff_dashboard.jsp");
                } else if ("Delivery Personnel".equalsIgnoreCase(role)) {
                    response.sendRedirect("delPerson_dashboard.jsp");
                } else {
                    response.sendRedirect("staff_login.jsp?error=invalidRole");
                }
            }else {
        // Failed login
        response.sendRedirect("staff_login.jsp?error=invalid");
    }
        } catch (ClassNotFoundException e) {
            out.println("Database Driver not found: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            out.println("Database connection problem: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for staff login with role-based redirection";
    }// </editor-fold>

}

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
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "EditProfileStaffServlet", urlPatterns = {"/EditProfileStaffServlet"})
public class EditProfileStaffServlet extends HttpServlet {

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
        
        String staffName = request.getParameter("staffName");
        String staffPhone = request.getParameter("staffPhone");
        String staffPassword = request.getParameter("staffPassword");
        
        HttpSession session = request.getSession();
        String staffEmail = (String) session.getAttribute("staffEmail");
        
        if (staffEmail == null) {
            response.sendRedirect("staff_login.jsp");
            return;
        }


        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin")) {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Update to the correct driver class
            
        StringBuilder sqlBuilder = new StringBuilder("UPDATE staff SET");
        List<Object> parameters = new ArrayList<>();

        if (staffName != null) {
            sqlBuilder.append(" staffName = ?,");
            parameters.add(staffName);
        }
        if (staffPhone != null) {
            sqlBuilder.append(" staffPhone = ?,");
            parameters.add(staffPhone);
        }
        if (staffPassword != null) {
            sqlBuilder.append(" staffPassword = ?,");
            parameters.add(staffPassword);
        }

        // Remove the trailing comma and add the WHERE clause
        sqlBuilder.deleteCharAt(sqlBuilder.length() - 1);
        sqlBuilder.append(" WHERE staffEmail = ?");
        
        try (PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
                for (int i = 0; i < parameters.size(); i++) {
                    stmt.setObject(i + 1, parameters.get(i));
                }
                stmt.setString(parameters.size() + 1, staffEmail);

                stmt.executeUpdate();
            }

            // Update session attributes if necessary
            if (staffName != null) {
                session.setAttribute("staffName", staffName);
            }
            if (staffPhone != null) {
                session.setAttribute("staffPhone", staffPhone);
            }
            if (staffPassword != null) {
                session.setAttribute("staffPassword", staffPassword);
            }

            response.sendRedirect("staff_profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, add user-friendly error handling
            response.sendRedirect("error.jsp");
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
        return "Short description";
    }// </editor-fold>

}

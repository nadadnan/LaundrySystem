/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
@WebServlet("/EditProfileCustServlet")
public class EditProfileCustServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String custName = request.getParameter("custName");
        String custPhone = request.getParameter("custPhone");
        String custPassword = request.getParameter("custPassword");
        String custAddress = request.getParameter("custAddress"); 
        
        HttpSession session = request.getSession();
        String custEmail = (String) session.getAttribute("custEmail");
        
        if (custEmail == null) {
            response.sendRedirect("cust_login.jsp");
            return;
        }
    
        //Connection conn = null;
        //PreparedStatement stmt = null;

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin")) {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Update to the correct driver class
           
        StringBuilder sqlBuilder = new StringBuilder("UPDATE customer SET");
        List<Object> parameters = new ArrayList<>();

        if (custName != null) {
            sqlBuilder.append(" custName = ?,");
            parameters.add(custName);
        }
        if (custPhone != null) {
            sqlBuilder.append(" custPhone = ?,");
            parameters.add(custPhone);
        }
        if (custPassword != null) {
            sqlBuilder.append(" custPassword = ?,");
            parameters.add(custPassword);
        }
        if (custAddress != null) { // Add address update condition
            sqlBuilder.append(" custAddress = ?,");
            parameters.add(custAddress);
        }
        
        // Remove the trailing comma and add the WHERE clause
            if (parameters.isEmpty()) {
                response.sendRedirect("cust_profile.jsp");
                return;
            }

        sqlBuilder.deleteCharAt(sqlBuilder.length() - 1);
        sqlBuilder.append(" WHERE custEmail = ?");
        
        try (PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
                for (int i = 0; i < parameters.size(); i++) {
                    stmt.setObject(i + 1, parameters.get(i));
                }
                stmt.setString(parameters.size() + 1, custEmail);

                stmt.executeUpdate();
            }

            // Update session attributes if necessary
            if (custName != null) {
                session.setAttribute("custName", custName);
            }
            if (custPhone != null) {
                session.setAttribute("custPhone", custPhone);
            }
            if (custPassword != null) {
                session.setAttribute("custPassword", custPassword);
            }
            if (custAddress != null) {
                session.setAttribute("custAddress", custAddress);
            }

            response.sendRedirect("profile.jsp");

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

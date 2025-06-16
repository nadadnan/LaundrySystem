/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.customerDAO;
import com.Model.CoverageArea;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * Author: NUR NADIYATUL HUSNA BINTI ADNAN (S65470)
 */
public class SaveCoverageAreaServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        List<String> validPostalCodes = customerDAO.getValidPostalCodes(); // Fetch from DB
        request.getSession().setAttribute("validPostalCodes", validPostalCodes);

        try {
            // Retrieve form data
            String postal_code = request.getParameter("postal_code");
            String area_name = request.getParameter("area_name");

            CoverageArea c = new CoverageArea();
            c.setPostal_code(postal_code);
            c.setArea_name(area_name);

            // Save Customer to DB
            int status = customerDAO.saveCoverageArea(c);

            // Redirect or display message based on status
            if (status > 0) {
                // Successful registration
                request.setAttribute("status", "success");
                RequestDispatcher dispatcher = request.getRequestDispatcher("coverageArea.jsp");
                dispatcher.forward(request, response);
            } else {
                // Registration failed
                request.setAttribute("status", "failed");
                response.getWriter().println("<h3>Add new Failed. Please try again!</h3>");
                RequestDispatcher dispatcher = request.getRequestDispatcher("coverageArea.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("manager_dashboard.jsp").forward(request, response);
        }

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

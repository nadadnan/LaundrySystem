/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.DBUtil;
import com.DAO.ordersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author M S I
 */
public class CancelOrderServlet extends HttpServlet {

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
        // Get session and customer ID
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("cust_login.jsp");
        return;
    }

    String custID = (String) session.getAttribute("custID");

    // Get the orderID from the request and parse it as an integer
    String orderIDStr = request.getParameter("orderID");
    int orderID = Integer.parseInt(orderIDStr);  // Convert the orderID to int

    // Clear the cart by removing the cart attribute from the session
    session.removeAttribute("cart");

    // Remove the specific order from the database
    try {
        removeOrderFromDatabase(custID, orderID);  // Pass both customer ID and order ID
    } catch (Exception e) {
        e.printStackTrace();
        // Handle the error, you can show an error message if needed
    }

    // Redirect back to the dashboard or the menu page
    response.sendRedirect("orderHistory.jsp");  // Redirect to the customer's dashboard
}

    
    private void removeOrderFromDatabase(String custID, int orderID) throws Exception {
        // Assuming you have a database connection and a method to delete the order by custID and orderID
        Connection conn = DBUtil.getConnection();
        try {
            // Delete from the orders table where both orderID and custID match
            String deleteOrderQuery = "DELETE FROM orders WHERE orderID = ? AND custID = ?";
            PreparedStatement ps = conn.prepareStatement(deleteOrderQuery);
            ps.setInt(1, orderID);  // Set the specific orderID as an integer
            ps.setString(2, custID);  // Ensure it's the order belonging to the specific customer
            int rowsAffected = ps.executeUpdate();

            // Check if the deletion was successful by verifying the affected rows
            if (rowsAffected == 0) {
                throw new Exception("No order found for the customer to delete.");
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
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

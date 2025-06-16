/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;
import com.DAO.DBUtil;


public class PaymentCallbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("PaymentCallbackServlet triggered");

        String billCode = request.getParameter("billcode");
        String transactionID = request.getParameter("transaction_id");
        String orderIDParam = request.getParameter("order_id");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Validate parameters
        if (billCode == null || transactionID == null || orderIDParam == null) {
            out.println("Invalid request: missing parameters.");
            return;
        }

        try {
            // Extract numeric orderID (e.g., ORDER241 -> 241)
            int orderID = Integer.parseInt(orderIDParam.replaceAll("\\D", ""));

            // Simulate ToyyibPay JSON callback (since it's a GET request here)
            String responseJson = "[{\"billCode\":\"" + billCode + "\",\"transactionId\":\"" + transactionID + "\",\"order_id\":\"" + orderIDParam + "\",\"status\":\"1\"}]";
            JSONArray jsonArray = new JSONArray(responseJson);
            JSONObject transaction = jsonArray.getJSONObject(0);
            String paymentStatus = transaction.getString("status");

            if ("1".equals(paymentStatus)) {
                try (Connection con = DBUtil.getConnection()) {

                    // Check if order exists
                    String checkOrderSQL = "SELECT * FROM orders WHERE orderID = ?";
                    try (PreparedStatement checkOrder = con.prepareStatement(checkOrderSQL)) {
                        checkOrder.setInt(1, orderID);
                        try (ResultSet rs = checkOrder.executeQuery()) {
                            if (!rs.next()) {
                                out.println("Error: orderID " + orderID + " does not exist in orders table.");
                                return;
                            }
                        }
                    }

                    // Check if payment for this transactionID already exists (to prevent duplicates)
                    String checkPaymentSQL = "SELECT * FROM payment WHERE transactionID = ?";
                    try (PreparedStatement checkPayment = con.prepareStatement(checkPaymentSQL)) {
                        checkPayment.setString(1, transactionID);
                        try (ResultSet rs = checkPayment.executeQuery()) {
                            if (rs.next()) {
                                out.println("Payment already recorded for this transaction.");
                                return;
                            }
                        }
                    }

                    // Insert payment record
                    String insertSQL = "INSERT INTO payment (orderID, transactionID, paymentStatus, paymentDate, paymentMethod) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement ps = con.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
                        ps.setInt(1, orderID);
                        ps.setString(2, transactionID);
                        ps.setString(3, "Completed");
                        ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                        ps.setString(5, "ToyyibPay");

                        int rowsInserted = ps.executeUpdate();
                        if (rowsInserted > 0) {
                            System.out.println("Payment inserted successfully for orderID: " + orderID);
                        } else {
                            System.out.println("Failed to insert payment.");
                        }
                    }
                }

                // Redirect to success page
                response.sendRedirect("paymentSuccess.jsp?order_id=" + orderIDParam + "&transaction_id=" + transactionID);
            } else {
                System.out.println("Payment status not successful.");
                response.sendRedirect("paymentFailed.jsp?order_id=" + orderIDParam + "&transaction_id=" + transactionID);
            }

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // handle POST the same way as GET
    }

    @Override
    public String getServletInfo() {
        return "Handles ToyyibPay callback and updates payment records";
    }
}

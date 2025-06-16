<%-- 
    Document   : view_order_details
    Created on : 18 May 2025, 10:14:00 pm
    Author     : M S I
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int orderID = Integer.parseInt(request.getParameter("orderID"));

    // Database objects
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Order summary
    String orderStatus = "";
    double totalPrice = 0;
    String pickupDate = "";
    String pickupTime = "";
    String custName = "";
    String custPhone = "";
    String custAddress = "";

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    body {
        font-family: Arial, sans-serif;
        padding: 20px;
        margin: 0;
        background-color: #f5f5f5;
    }

    .order-container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    .order-header {
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    .summary {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #007bff;
        color: white;
    }

    .back-btn {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        padding: 10px 15px;
        background-color: #007bff;
        color: white;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .back-btn:hover {
        background-color: #0056b3;
    }

    /* Responsive for small screens */
    @media (max-width: 600px) {
        body {
            padding: 10px;
        }

        .order-container {
            padding: 15px;
        }

        .summary p {
            font-size: 14px;
        }

        h2, h3 {
            font-size: 18px;
        }

        table {
            display: block;
            width: 100%;
            overflow-x: auto;
            white-space: nowrap;
        }

        th, td {
            font-size: 14px;
        }

        .back-btn {
            font-size: 14px;
            padding: 8px 12px;
        }
    }
</style>

    </head>
    <body>
        <div class="order-container">
            <div class="order-header">
                <h2>Order Details #<%= orderID%></h2>
            </div>

            <%
                try {
                    // 1. Get database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin");

                    // 2. Get order summary
                    String orderSql = "SELECT o.*, c.custName, c.custPhone, c.custAddress FROM orders o "
                            + "JOIN customer c ON o.custID = c.custID "
                            + "WHERE o.orderID = ?";

                    stmt = conn.prepareStatement(orderSql);
                    stmt.setInt(1, orderID);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        orderStatus = rs.getString("orderStatus");
                        totalPrice = rs.getDouble("totalPrice");
                        pickupDate = rs.getString("pickupDate");
                        pickupTime = rs.getString("pickupTime");
                        custName = rs.getString("custName");
                        custPhone = rs.getString("custPhone");
                        custAddress = rs.getString("custAddress");

                    } else {
                        out.println("<p>Order not found</p>");
                        return;
                    }
                    rs.close();
            %>

            <div class="summary">
                <h3>Order Summary</h3>
                <p><strong>Customer:</strong> <%= custName%></p>
                <p><strong>Phone:</strong> <%= custPhone%></p>
                <p><strong>Address:</strong> <%= custAddress%></p>
                <p><strong>Status:</strong> <%= orderStatus%></p>
                <p><strong>Total Price:</strong> RM <%= String.format("%.2f", totalPrice)%></p>
                <p><strong>Pickup Date:</strong> <%= pickupDate%></p>
                <p><strong>Pickup Time:</strong> <%= pickupTime%></p>
            </div>


            <h3>Order Items</h3>
            <table>
                <thead>
                    <tr>
                        <th>Package</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // 3. Get order items
                        String itemsSql = "SELECT lp.packageName, oi.quantity, oi.pricePerUnit "
                                + "FROM order_items oi "
                                + "JOIN laundryPackage lp ON oi.packageID = lp.packageID "
                                + "WHERE oi.orderID = ?";
                        stmt = conn.prepareStatement(itemsSql);
                        stmt.setInt(1, orderID);
                        rs = stmt.executeQuery();

                        boolean hasItems = false;
                        while (rs.next()) {
                            hasItems = true;
                            String packageName = rs.getString("packageName");
                            int quantity = rs.getInt("quantity");
                            double unitPrice = rs.getDouble("pricePerUnit");
                            double subtotal = unitPrice * quantity;
                    %>
                    <tr>
                        <td><%= packageName%></td>
                        <td><%= quantity%></td>
                        <td>RM <%= String.format("%.2f", unitPrice)%></td>
                        <td>RM <%= String.format("%.2f", subtotal)%></td>
                    </tr>
                    <%
                        }

                        if (!hasItems) {
                    %>
                    <tr>
                        <td colspan="4" style="text-align: center;">No items found for this order</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color: red'>Error loading order details: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                    } catch (SQLException e) {
                    }
                    try {
                        if (stmt != null) {
                            stmt.close();
                        }
                    } catch (SQLException e) {
                    }
                    try {
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                    }
                }
            %>

            <p><a href="orderHistory.jsp" class="back-btn">Back to Order History</a></p>
        </div>
    </body>
</html>
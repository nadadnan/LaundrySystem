<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 80px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #2e7d32;
        }

        p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }

        .details {
            text-align: left;
            margin-top: 30px;
        }

        .details p {
            margin: 6px 0;
        }

        .btn {
            margin-top: 30px;
            padding: 10px 25px;
            font-size: 16px;
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #1b5e20;
        }
    </style>
</head>
<body>

<%
    String orderID = request.getParameter("order_id");
    String transactionID = request.getParameter("transaction_id");

    double amountPaid = 0.0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "admin");

        int numericOrderID = Integer.parseInt(orderID.replaceAll("[^0-9]", ""));

        String query = "SELECT totalPrice FROM orders WHERE orderID = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, numericOrderID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            amountPaid = rs.getDouble("totalPrice");
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="container">
    <h2>Payment Successful!</h2>
    <p>Thank you for your payment. Your transaction has been processed successfully.</p>

    <div class="details">
        <p><strong>Order ID:</strong> <%= orderID %></p>
        <p><strong>Transaction ID:</strong> <%= transactionID %></p>
        <p><strong>Amount Paid:</strong> RM <%= String.format("%.2f", amountPaid) %></p>
    </div>

    <a href="cust_dashboard1.jsp" class="btn">Go to Dashboard</a>
</div>

</body>
</html>

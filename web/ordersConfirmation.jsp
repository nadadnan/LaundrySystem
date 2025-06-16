<%@page import="com.Model.laundryPackage"%>
<%@page import="com.Model.Cart"%>
<%@page import="com.Model.CartItem"%>
<%@page import="com.Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check if the session exists and customer is logged in
    session = request.getSession(false); // Get the current session
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("cust_login.jsp"); // Redirect to login page if no session or customer is not logged in
        return; // Prevent further processing
    }

    // Retrieve Cart from the request attribute (after being set in the servlet)
    Cart cart = (Cart) request.getAttribute("cart");

    // If the cart is still not found, fall back to session
    if (cart == null) {
        cart = (Cart) session.getAttribute("cart");
    }

    // Retrieve customer details from session
    String custName = (String) session.getAttribute("custName");
    String custEmail = (String) session.getAttribute("custEmail");
    String custAddress = (String) session.getAttribute("custAddress");
    String custID = (String) session.getAttribute("custID");
    
    String pickupDate = (String) request.getAttribute("pickupDate");
    String pickupTime = (String) request.getAttribute("pickupTime");

    if (cart != null && !cart.isEmpty()) { // Check if cart is not null and not empty
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        header a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
        }
        header a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2, h3 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .total {
            text-align: right;
            font-weight: bold;
            margin-top: 20px;
        }
        .button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #5cb85c;
            color: white;
            border: none;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            cursor: pointer;
        }
        .button-history {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: orange;
            color: black;
            border: none;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #4cae4c;
        }
        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-top: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }
        .order-summary {
            margin-top: 20px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
        }
        .cancel 
        { background-color: #d9534f; color: white; }
    </style>
</head>
<body>

    <div class="container">
        <h2>Order Confirmation</h2>
        
        <!-- Display customer details -->
        <p>Thank you, <strong><%= custName %></strong>!</p>
        <p>Your order has been successfully placed.</p>
        <p>Email: <%= custEmail %></p>
        <p>Address: <%= custAddress %></p>
        <p><strong>Pickup Date</strong> <%= pickupDate %></p>
        <p><strong>Pickup Time:</strong> <%= pickupTime %></p>
        

        <!-- Display the Cart items -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Package Name</th>
                    <th>Price (RM)</th>
                    <th>Quantity</th>
                    <th>Total (RM)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    double total = 0;
                    // Iterate over the items in the cart
                    for (CartItem item : cart.getItems().values()) {
                        laundryPackage laundryPackage = item.getLaundryPackage(); // Access the LaundryPackage object from CartItem
                        double price = laundryPackage.getPackagePrice();  // Assuming LaundryPackage has getPackagePrice method
                        int quantity = item.getQuantity();      // Access quantity directly from CartItem
                        double itemTotal = price * quantity;
                        total += itemTotal;
                %>
                <tr>
                    <td><%= laundryPackage.getPackageName() %></td>
                    <td><%= String.format("%.2f", price) %></td>
                    <td><%= quantity %></td>
                    <td><%= String.format("%.2f", itemTotal) %></td>
                </tr>
                <%
                    }
                    
                    // Add the delivery fee of RM 10
                    double deliveryFee = 10.0;
                    total += deliveryFee;
                %>
                <tr>
                    <td colspan="3"><strong>Delivery Fee</strong></td>
                    <td>RM <%= String.format("%.2f", deliveryFee) %></td>
                </tr>
            </tbody>
        </table>

        <!-- Display total -->
        <p><strong>Total: RM <%= String.format("%.2f", total) %></strong></p>

        <!-- Button to confirm order or go back -->
        <form action="paymentPage.jsp" method="post">
            <button type="submit" class="button">Proceed to Payment</button>
        </form>
        
        <!--form action="CancelOrderServlet" method="post">
    <button type="submit" class="button cancel">Cancel Order</button>
</form-->

        <!--a href="orderHistory.jsp" class="button-history">View Order History</a-->

        
    </div>

</body>
</html>
<%
    } else {
        out.println("<p>Your cart is empty.</p>");
    }
%>

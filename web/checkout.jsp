<%-- 
    Document   : checkout
    Created on : 9 Jan 2025, 9:55:16 pm
    Author     : M S I
--%>

<%@ page import="com.Model.Cart" %>
<%@ page import="java.util.*, com.Model.CartItem" %>
<%@ page session="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Checkout</h1>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
        <div class="alert alert-warning" role="alert">
            Your cart is empty. Add some items to your cart!
        </div>
        <%
            } else {
                String pickupDate = request.getParameter("pickupDate");
                String pickupTime = request.getParameter("pickupTime");
                String address = request.getParameter("address");
        %>
        
        <!-- Summary Section -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                Order Summary
            </div>
            <div class="card-body">
                <p><strong>Pickup Date:</strong> <%= pickupDate %></p>
                <p><strong>Pickup Time:</strong> <%= pickupTime %></p>
                <p><strong>Address:</strong> <%= address %></p>
                <p><strong>Grand Total:</strong> RM <%= cart.getTotalPrice() + 10 %></p>
            </div>
        </div>

        <!-- Payment Section -->
        <form action="PaymentServlet" method="post" class="mt-4">
            <input type="hidden" name="pickupDate" value="<%= pickupDate %>">
            <input type="hidden" name="pickupTime" value="<%= pickupTime %>">
            <input type="hidden" name="address" value="<%= address %>">
            <div class="form-group">
                <label for="paymentMethod">Choose Payment Method:</label>
                <select name="paymentMethod" id="paymentMethod" class="form-control" required>
                    <option value="credit_card">Credit Card</option>
                    <option value="online_banking">Online Banking</option>
                    <option value="cash">Cash on Delivery</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success btn-block">Pay Now</button>
        </form>

        <%
            }
        %>

        <div class="mt-4 text-center">
            <a href="cart2.jsp" class="btn btn-info">Back to Cart</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="com.Model.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Redirect to login page if user is not logged in (custID not found in session)
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("cust_login.jsp");
        return;
    }

    String custID = (String) session.getAttribute("custID"); // Get logged-in customer's ID

    // Declare JDBC resources and lists to store orders
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Orders> activeOrders = new ArrayList<>();
    List<Orders> completedOrders = new ArrayList<>();

    try {
        // Load MySQL JDBC Driver and establish DB connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin");

        // Prepare SQL to fetch orders for current customer
        String sql = "SELECT orderID, totalPrice, orderStatus FROM orders WHERE custID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, custID);
        rs = stmt.executeQuery();

        // Loop through results and categorize orders into active or completed
        while (rs.next()) {
            Orders order = new Orders();
            order.setOrderID(rs.getInt("orderID"));
            order.setTotalPrice(rs.getDouble("totalPrice"));
            order.setOrderStatus(rs.getString("orderStatus"));

            if ("Completed".equalsIgnoreCase(order.getOrderStatus())) {
                completedOrders.add(order);
            } else {
                activeOrders.add(order);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();  // Print any exception that occurs
    } finally {
        // Close JDBC resources
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<%!
    // Custom method to fetch order item names and quantities by order ID
    public String getOrderDetails(int orderId) {
        StringBuilder details = new StringBuilder();
        Connection c = null;
        PreparedStatement ps = null;
        ResultSet r = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS", "root", "admin");

            // Join query to get item names and quantity for an order
            String query = "SELECT packageName, quantity FROM order_details od JOIN laundryPackage lp ON od.packageID = lp.packageID WHERE od.orderID = ?";
            ps = c.prepareStatement(query);
            ps.setInt(1, orderId);
            r = ps.executeQuery();

            // Append each item to a string (e.g., "Basic Wash (x2), Ironing (x1)")
            while (r.next()) {
                String packageName = r.getString("packageName");
                int quantity = r.getInt("quantity");
                if (details.length() > 0) {
                    details.append(", ");
                }
                details.append(packageName).append(" (x").append(quantity).append(")");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close all JDBC resources
            try {
                if (r != null) {
                    r.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (c != null) {
                    c.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return details.toString();  // Return the formatted string
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Order History</title>

        <!-- Include stylesheets and fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">

        <style>
            .container {
                margin-top: 50px;
                margin-bottom: 50px;
            }

            h2 {
                text-align: center;
                font-size: 2.5em;
                color: #333;
                margin-bottom: 20px;
            }

            .table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
                border-radius: 8px;
            }

            .table th, .table td {
                padding: 12px 15px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 1.1em;
            }

            .table th {
                background-color: #007bff;
                color: white;
            }

            .table td {
                background-color: #f8f9fa;
            }

            .table tbody tr:hover {
                background-color: #f1f1f1;
            }

            .btn-action {
                padding: 8px 15px;
                font-size: 0.9em;
                margin-right: 5px;
            }

            .btn-action:hover {
                opacity: 0.8;
            }

            .no-orders-message {
                text-align: center;
                font-size: 1.2em;
                color: #888;
                margin-top: 30px;
            }

            .cancel-button {
                background-color: #d9534f;
                color: white;
                padding: 8px 12px;
                border: none;
                cursor: pointer;
            }

            .cancel-button:hover {
                background-color: #c9302c;
            }
        </style>

    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">

            <!-- Preloader shown while page loads -->
            <div class="preloader flex-column justify-content-center align-items-center">
                <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
            </div>

            <!-- Top Navbar -->
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- Left navbar links -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="cust_dashboard1.jsp" class="nav-link">Home</a>
                    </li>
                </ul>

                <!-- Right navbar links -->
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link"  href="cart2.jsp" role="button">
                            <i class="fa fa-shopping-cart"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutCustServlet" role="logout">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Sidebar for navigation -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Brand Logo -->
                <a href="cust_dashboard1.jsp" class="brand-link">
                    <img src="dist/img/background/logo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light">Coin Laundry</span>
                </a>

                <!-- Sidebar user info and menu -->
                <div class="sidebar">
                    <!-- Sidebar user panel (optional) -->
                    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                        <div class="info">
                            <!-- Display customer name from session -->
                            <a href="profile.jsp" class="d-block">
                                <%= session.getAttribute("custName")%>
                            </a>
                        </div>
                    </div>

                    <!-- Sidebar search Form -->
                    <div class="form-inline">
                        <div class="input-group" data-widget="sidebar-search">
                            <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                            <div class="input-group-append">
                                <button class="btn btn-sidebar">
                                    <i class="fas fa-search fa-fw"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar navigation menu -->
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <li class="nav-item">
                                <a href="cust_dashboard1.jsp" class="nav-link">
                                    <i class="nav-icon fas fa-home"></i>
                                    <p>
                                        Home
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="ViewPackageServlet" class="nav-link">
                                    <i class="nav-icon fas fa-th"></i>
                                    <p>
                                        Laundry Package
                                        <span class="right badge badge-danger">Menu</span>
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="orderHistory.jsp" class="nav-link">
                                    <i class="nav-icon fas fa-truck"></i>
                                    <p>
                                        Track Order
                                    </p>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </aside>

            <!-- Main content area -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0"><strong>Order History</strong></h1>
                            </div>       
                        </div>
                    </div>
                </div>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <% if (activeOrders.isEmpty() && completedOrders.isEmpty()) { %>
                        <div class="alert alert-warning text-center">
                            No orders found! You haven't placed any orders yet.
                        </div>
                        <% } %>

                        <% if (!activeOrders.isEmpty()) { %>
                        <h4 style="color:blue;">Ongoing Orders</h4>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Total Price (RM)</th>
                                    <th>Order Status</th>
                                    <th>Order Details</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Orders order : activeOrders) {%>
                                <tr>
                                    <td><%= order.getOrderID()%></td>
                                    <td><%= String.format("%.2f", order.getTotalPrice())%></td>
                                    <td><%= order.getOrderStatus()%></td>
                                    <td><a href="view_order_details.jsp?orderID=<%= order.getOrderID()%>" class="btn btn-primary btn-action">View Details</a></td> <!-- Show details -->
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% } %>

                        <% if (!completedOrders.isEmpty()) { %>
                        <h4 style="color:green;">Completed Orders</h4>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Total Price (RM)</th>
                                    <th>Order Status</th>
                                    <th>Order Details</th> <!-- New column -->
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Orders order : completedOrders) {%>
                                <tr>
                                    <td><%= order.getOrderID()%></td>
                                    <td><%= String.format("%.2f", order.getTotalPrice())%></td>
                                    <td><%= order.getOrderStatus()%></td>
                                    <td><a href="view_order_details.jsp?orderID=<%= order.getOrderID()%>" class="btn btn-primary btn-action">View Details</a></td> <!-- Show details -->
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% }%>
                    </div>

                </section>
            </div>

            <!-- Footer -->
            <footer class="main-footer">
                <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
                All rights reserved.
                <div class="float-right d-none d-sm-inline-block">
                    <b>Version</b> 3.2.0
                </div>
            </footer>

        </div>

        <!-- Include JavaScript files -->
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
        <script>
            // Resolve conflict in jQuery UI tooltip with Bootstrap tooltip
            $.widget.bridge('uibutton', $.ui.button);
        </script>
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <script src="dist/js/adminlte.js"></script>

    </body>
</html>

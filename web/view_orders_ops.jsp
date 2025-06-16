<%-- 
    Document   : view_orders_ops
    Created on : 20 Apr 2025, 11:28:50 am
    Author     : M S I
--%>

<%@page import="com.Model.Orders"%>
<%@page import="com.DAO.ordersDAO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>


<%
    Integer staffID = (Integer) session.getAttribute("staffID");

    if (staffID == null || session.getAttribute("staffName") == null || session.getAttribute("role") == null) {
        response.sendRedirect("staff_login.jsp");
        return;
    }

    String staffName = (String) session.getAttribute("staffName");
    String role = (String) session.getAttribute("role");

    ordersDAO orderDAO = new ordersDAO();
    //List<Orders> inLaundryOrders = orderDAO.getOrdersByStatus("In Laundry");
    List<Orders> inLaundryOrders = orderDAO.getOrdersByMultipleStatuses(new String[]{"In Laundry", "Ready for Delivery"});

%>

<%    //HttpSession session = request.getSession(false); // Check for existing session, don't create a new one
    if (session == null || session.getAttribute("staffName") == null || session.getAttribute("role") == null) {
        // Redirect to login page if session is invalid or attributes are missing
        response.sendRedirect("staff_login.jsp");
        return;
    }

%>
<%

    List<Orders> completedOrders = orderDAO.getOrdersByStatus("Completed");

%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Operational Staff - Laundry Orders</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Tempusdominus Bootstrap 4 -->
        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- JQVMap -->
        <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
        <!-- summernote -->
        <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">

            <!-- Preloader -->
            <div class="preloader flex-column justify-content-center align-items-center">
                <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
            </div>

            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- Left navbar links -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="staff_dashboard.jsp" class="nav-link">Home</a>
                    </li>
                </ul>

                <!-- Right navbar links -->
                <ul class="navbar-nav ml-auto">

                    <li class="nav-item">
                        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutStaffServlet" role="logout">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.navbar -->

            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Brand Logo -->
                <a href="staff_dashboard.jsp" class="brand-link">
                    <img src="dist/img/background/logo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light">Coin Laundry</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar user panel (optional) -->
                    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                        
                        <div class="info">
                            <a href="staff_profile.jsp" class="d-block">
                                <%= staffName%></a>
                            <span class="d-block" style="color:lightslategrey"><%= role%></span> 
                            <!-- nama di dashboard -->
                        </div>
                    </div>

                    <!-- SidebarSearch Form -->
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

                    <!-- Sidebar Menu -->
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <!-- Add icons to the links using the .nav-icon class
                                 with font-awesome or any other icon font library -->
                            <li class="nav-item">
                                <a href="staff_dashboard.jsp" class="nav-link active">
                                    <i class="nav-icon fas fa-home"></i>
                                    <p>
                                        Home
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="StaffViewPackageServlet" class="nav-link">
                                    <i class="nav-icon fas fa-th"></i>
                                    <p>
                                        Laundry Package
                                        <span class="right badge badge-danger">Menu</span>
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="view_orders_ops.jsp" class="nav-link">
                                    <i class="nav-icon fa fa-shopping-basket"></i>
                                    <p>
                                        Process Orders
                                    </p>
                                </a>
                            </li>
                    </nav>
                    <!-- /.sidebar-menu -->
                </div>
                <!-- /.sidebar -->
            </aside>

            <div class="wrapper">
                <div class="content-wrapper">
                    <div class="content-header">
                        <h1 class="m-3">Orders Currently In Laundry</h1>
                    </div>
                    <div class="col-12">
                    <div class="card">
                    <div class="card-body table-responsive p-0">
                        <table class="table table-hover text-nowrap">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Pickup Date</th>
                                    <th>Pickup Time</th>
                                    <th>Current Status</th>
                                    <th>Update Status</th>
                                    <th>Order Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (inLaundryOrders != null && !inLaundryOrders.isEmpty()) {
                                        for (Orders order : inLaundryOrders) {
                                %>
                                <tr>
                                    <td><%= order.getOrderID()%></td>
                                    <td><%= order.getCustID()%></td>
                                    <td><%= order.getPickupDate()%></td>
                                    <td><%= order.getPickupTime()%></td>
                                    <td><strong><%= order.getOrderStatus()%></strong></td>
                                    <td>
                                        <form action="UpdateOrderStatusServlet" method="post" class="d-flex align-items-center">
                                            <input type="hidden" name="orderID" value="<%= order.getOrderID()%>"/>
                                            <select name="orderStatus" class="form-control mr-2" style="width:auto;">
                                                <option value="In Laundry" <%= order.getOrderStatus().equals("In Laundry") ? "selected" : ""%>>In Laundry</option>
                                                <!--option value="Ready for Delivery">Ready for Delivery</option-->
                                                <option value="Ready for Delivery" <%= order.getOrderStatus().equals("Ready for Delivery") ? "selected" : ""%>>Ready for Delivery</option>
                                            </select>
                                            <input type="submit" class="btn btn-sm btn-primary ml-2" value="Update"/>
                                        </form>
                                    </td>
                                    <td><a href="view_orders_ops_details.jsp?orderID=<%= order.getOrderID() %>" class="btn btn-primary btn-action">View Details</a></td> <!-- Show details -->
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="5">No orders currently in laundry.</td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                    </div>
                            </div>
                            
<div class="content-header">
                        <h1 class="m-3">Complete Orders</h1>
                    </div>
                    <div class="col-12">
                    <div class="card">
                    <div class="card-body table-responsive p-0">

<div class="content p-3">
    <table class="table table-hover text-nowrap">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Pickup Date</th>
                <th>Pickup Time</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (completedOrders != null && !completedOrders.isEmpty()) {
                    for (Orders order : completedOrders) {
            %>
            <tr>
                <td><%= order.getOrderID() %></td>
                <td><%= order.getCustID() %></td>
                <td><%= order.getPickupDate() %></td>
                <td><%= order.getPickupTime() %></td>
                <td><strong><%= order.getOrderStatus() %></strong></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5">No completed orders found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

                    </div>
 </div>
                </div>
            </div>
            </div>

            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
                All rights reserved.
                <div class="float-right d-none d-sm-inline-block">
                    <b>Version</b> 3.2.0
                </div>
            </footer>

            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
                <!-- Control sidebar content goes here -->
            </aside>
            <!-- /.control-sidebar -->
        </div>
        <!-- ./wrapper -->

        <!-- jQuery -->
        <script src="plugins/jquery/jquery.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button)
        </script>
        <!-- Bootstrap 4 -->
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- ChartJS -->
        <script src="plugins/chart.js/Chart.min.js"></script>
        <!-- Sparkline -->
        <script src="plugins/sparklines/sparkline.js"></script>
        <!-- JQVMap -->
        <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
        <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
        <!-- jQuery Knob Chart -->
        <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
        <!-- daterangepicker -->
        <script src="plugins/moment/moment.min.js"></script>
        <script src="plugins/daterangepicker/daterangepicker.js"></script>
        <!-- Tempusdominus Bootstrap 4 -->
        <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Summernote -->
        <script src="plugins/summernote/summernote-bs4.min.js"></script>
        <!-- overlayScrollbars -->
        <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <!-- AdminLTE App -->
        <script src="dist/js/adminlte.js"></script>

    </body>
</html>


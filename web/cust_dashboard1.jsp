<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Check if a session exists and if the customer is logged in
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("cust_login.jsp"); // Redirect to login page if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Customer dashboard</title>

        <!-- Include stylesheets and fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
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
                                <!-- Welcome message with customer name -->
                                <h1>Welcome, 
                                    <a href="profile.jsp" style="color: black;"><%= session.getAttribute("custName")%>!</a>
                                </h1>
                            </div>      
                        </div>
                    </div>
                </div>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Dashboard shortcuts -->
                        <div class="row">
         
                            <!-- Make Order Box -->
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="small-box bg-info">
                                    <div class="inner">
                                        <h3>Make Orders</h3>
                                        <p>Laundry Packages</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-bag"></i>
                                    </div>
                                    <a href="ViewPackageServlet" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            
                            <!-- Track Order Box -->
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="small-box bg-warning">
                                    <div class="inner">
                                        <h3>Track Order</h3>
                                        <p>Order Tracking and History</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-folder"></i>
                                    </div>
                                    <a href="orderHistory.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>

                        </div>
                        
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

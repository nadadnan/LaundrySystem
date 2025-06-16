<%-- 
    Document   : staffMenuLaundry
    Created on : 13 Jan 2025, 11:03:47 pm
    Author     : M S I
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.WEB.ViewPackageServlet" %>

<%
    //HttpSession session = request.getSession(false); // Use an existing session
    if (session == null || session.getAttribute("staffName") == null || session.getAttribute("role") == null) {
        // Redirect to login page if session is invalid
        response.sendRedirect("staff_login.jsp");
        return;
    }
    String staffName = (String) session.getAttribute("staffName");
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>View Laundry Packages</title>

        <style>
            .package-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }
            .package-card {
                border: 1px solid #ddd;
                padding: 20px;
                margin: 10px;
                width: 30%;
                min-width: 250px;
                max-width: 350px;
                text-align: center;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .package-card:hover {
                transform: translateY(-10px);
            }

            .package-card img {
                width: 100%;
                height: auto;
                object-fit: cover; /* Ensures the aspect ratio is maintained, and the image covers the entire space */
            }


            .package-card h3 {
                font-size: 1.5rem;
                margin-top: 10px;
            }

            .package-card p {
                font-size: 1rem;
                color: #555;
            }

            .package-card .price {
                font-size: 1.25rem;
                color: #007bff;
                margin-top: 10px;
            }

            .package-card button {
                margin: 5px;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.3s ease;
            }

            .package-card button i {
                margin-right: 5px;
            }

            .btn-cart {
                background-color: #007bff;
                color: white;
            }

            .btn-cart:hover {
                background-color: #0056b3;
            }

            .btn-buy {
                background-color: #28a745;
                color: white;
            }

            .btn-buy:hover {
                background-color: #1e7e34;
            }

            .quantity-container {
                margin: 10px 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .quantity-container label {
                margin-right: 10px;
                font-weight: bold;
            }

            .quantity-input {
                width: 50px;
                text-align: center;
                padding: 5px;
                font-size: 14px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

        </style>

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

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">

                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">View Laundry Packages</h1>
                            </div><!-- /.col -->        
                        </div><!-- /.row -->
                    </div><!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->

                <!-- Main Content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <c:forEach var="pkg" items="${laundryPackages}">
                                <div class="package-card">
                                    <img src="packageImages/${pkg.packageImage}" alt="${pkg.packageName}">
                                    <h3><b>${pkg.packageName}</b></h3>
                                    <p>Package ID: ${pkg.packageID}</p>
                                    <p>${pkg.packageDesc}</p>
                                    <p class="price">RM 
                                        <fmt:formatNumber value="${pkg.packagePrice}" type="number" minFractionDigits="2" />
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </div>
    </body>
</html>



<script>
    // Update the hidden quantity field before form submission for Add to Cart
    function updateHiddenQuantity(packageID) {
        var quantity = document.getElementById("quantity-" + packageID).value;
        document.getElementById("hidden-quantity-" + packageID).value = quantity;
    }

    // Update the hidden quantity field for the Buy Now form
    function updateHiddenQuantityBuy(packageID) {
        var quantity = document.getElementById("quantity-" + packageID).value;
        document.getElementById("hidden-buy-quantity-" + packageID).value = quantity;
    }
</script>

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

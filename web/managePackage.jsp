<%-- 
    Document   : manageMenu
    Created on : 21 Dec 2024, 4:16:15 pm
    Author     : M S I
--%>

<%@page import="com.DAO.laundryPackageDAO"%>
<%@page import="com.Model.laundryPackage"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String staffName = (String) session.getAttribute("staffName");
    String role = (String) session.getAttribute("role");%>
<%
    //HttpSession session = request.getSession(false); // Use an existing session
    if (session == null || session.getAttribute("staffName") == null || session.getAttribute("role") == null) {
        // Redirect to login page if session is invalid
        response.sendRedirect("staff_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Laundry Package</title>

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
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- DataTables CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css"/>
    </head>
    
    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function () {
            $('#laundryPackageTable').DataTable(); // Use your table's ID
        });
    </script>

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
                        <a href="NewOrderCountServlet" class="nav-link">Home</a>
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
                <a href="manager_dashboard.jsp" class="brand-link">
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
                                <a href="NewOrderCountServlet" class="nav-link">
                                    <i class="nav-icon fas fa-home"></i>
                                    <p>
                                        Home
                                    </p>
                                </a>
                            </li>


                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-copy"></i>
                                    <p>
                                        Registration
                                        <i class="fas fa-angle-left right"></i>
                                        <span class="badge badge-info right">2</span>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="staff_register.jsp" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Employee Registration</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="listCustomer.jsp" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Customer list</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li class="nav-item">
                                <a href="managePackage.jsp" class="nav-link">
                                    <i class="nav-icon fas fa-th"></i>
                                    <p>
                                        Laundry Package
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="coverageArea.jsp" class="nav-link">
                                    <i class="nav-icon fa fa-location-arrow"></i>
                                    <p>
                                        Coverage Area
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item"> 
                                <a href="view_reports.jsp" class="nav-link">
                                    <i class="nav-icon ion-stats-bars"></i>
                                    <p>
                                        Reports                                       
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
                                <h1 class="m-0">Manage Laundry Package</h1>
                            </div><!-- /.col -->        
                        </div><!-- /.row -->
                    </div><!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->
                <div class="row justify-content-center">
                    <!-- Left col -->
                    <section class="col-md-6 connectedSortable">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Add New Laundry Package</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form action="SavePackageServlet" method="post" enctype="multipart/form-data">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="packageName">Package Name</label>
                                        <input type="text" class="form-control" id="packageName" name="packageName" placeholder="Enter package name">
                                    </div>
                                    <div class="form-group">
                                        <label for="packageDesc">Package Description</label>
                                        <input type="text" class="form-control" id="packageDesc" name="packageDesc" placeholder="Description">
                                    </div>
                                    <div class="form-group">
                                        <label for="packagePrice">Package Price</label>
                                        <input type="number" class="form-control" id="packagePrice" name="packagePrice" placeholder="RM0">
                                    </div>
                                    <div class="form-group">
                                        <label for="packageImage">Upload Image</label>
                                        <div class="input-group">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="packageImage" name="packageImage">
                                                <label class="custom-file-label" for="packageImage">Choose file</label>
                                            </div>
                                            <div class="input-group-append">
                                                <span class="input-group-text">Upload</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card-body -->

                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                        <!-- /.card -->
                    </section>
                </div>

                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">List of Laundry Package</h3>

                        </div>
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-0">
                            <table id="laundryPackageTable" class="table table-bordered table-striped">
                                <%
                                    List<laundryPackage> list = laundryPackageDAO.getAllLaundryPackage();
                                %>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Image</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (laundryPackage e : list) {
                                            out.print("<tr><td>" + e.getPackageID() + "</td>"
                                                    + "<td>" + e.getPackageName() + "</td>"
                                                    + "<td>" + e.getPackageDesc() + "</td>"
                                                    + "<td>RM " + e.getPackagePrice() + "</td>"
                                                    + "<td><img src='packageImages/" + e.getPackageImage() + "' alt='" + e.getPackageName() + "' style='width:100px;height:auto;'/></td>"
                                                    + "<td class='project-actions'>"
                                                    + "<a class='btn btn-info btn-sm' href='EditPackageServlet?packageID=" + e.getPackageID() + "'>"
                                                    + "<i class='fas fa-pencil-alt'></i> Edit</a> "
                                                    + "<a class='btn btn-danger btn-sm' href='DeletePackageServlet?packageID=" + e.getPackageID() + "'>"
                                                    + "<i class='fas fa-trash'></i> Delete</a>"
                                                    + "</td></tr>");
                                        }
                                    %>
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
            </div>

            <!-- Edit Package Modal -->
            <div class="modal fade" id="editPackageModal" tabindex="-1" aria-labelledby="editPackageModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editPackageModalLabel">Edit Laundry Package</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editPackageForm" action="EditPackageServlet2" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="packageID" id="editPackageID">
                                <div class="mb-3">
                                    <label for="editPackageName" class="form-label">Package Name</label>
                                    <input type="text" class="form-control" id="editPackageName" name="packageName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editPackageDesc" class="form-label">Package Description</label>
                                    <textarea class="form-control" id="editPackageDesc" name="packageDesc" rows="3" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editPackagePrice" class="form-label">Package Price</label>
                                    <input type="number" class="form-control" id="editPackagePrice" name="packagePrice" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editPackageImage" class="form-label">Update Image</label>
                                    <input type="file" class="form-control" id="editPackageImage" name="packageImage">
                                </div>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- jQuery -->
            <script src="plugins/jquery/jquery.min.js"></script>
            <!-- jQuery UI 1.11.4 -->
            <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
            <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
            <script>
$.widget.bridge('uibutton', $.ui.button);
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

<%-- 
    Document   : staff_profile
    Created on : 2 Dec 2024, 9:29:10 am
    Author     : M S I
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    //out.println("Role is: " + role); // This will print the role to the page for debugging
    String dashboardLink = "default_dashboard.jsp"; // Default link

    if ("Manager".equals(role)) {
        dashboardLink = "manager_dashboard.jsp";
    } else if ("Operational Staff".equals(role)) {
        dashboardLink = "staff_dashboard.jsp";
    } else if ("Delivery Personnel".equals(role)) {
        dashboardLink = "delPerson_dashboard.jsp";
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Staff Profile</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">


        <style>

            body {
                font-family: Arial, sans-serif;

                margin: 0;
                background-size: cover; /* Cover the entire background */
                background-position: center;
                overflow-x: hidden;

                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                background-image: url('images/card-bg1.png');
                background-size: cover;
                background-position: center;
                padding: 20px;
                border-radius: 5px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-bottom: 3%;
                margin-top: 10%;
                position:relative;
                flex: 1;
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                font-size: 35px;
            }

            label {
                font-weight: bold;
                display: block;
                text-align: left;
                margin-bottom: 5px;
                font-size: 15px;
            }

            h3 {
                font-size: 20px;
            }

            p {
                font-size: 15px;
            }

            input[type="text"],
            input[type="tel"],
            input[type="email"],
            input[type="password"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin: 5px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 20px;
                margin: 5px;
            }

            button:hover {
                background-color: #0056b3;
            }

            .btn-red {
                background-color: #dc3545;
            }

            .btn-red:hover {
                background-color: #c82333;
            }

            .btn-black {
                background-color: black;
                color: white;
            }

            .btn-black:hover {
                background-color: #333;
            }

            .btn-green {
                background-color: green;
            }
            .btn-green:hover {
                background-color: #4CAF50
            }


            .btn-small {
                padding: 5px 10px;
                font-size: 14px;
            }

            .hidden-form {
                display: none;
            }

           /* Password toggle styling */
            .password-toggle {
                position: relative;
            }
            .password-toggle input[type="password"] {
                padding-right: 30px; /* Space for the toggle icon */
            }
            .password-toggle .toggle-password {
                position: absolute;
                right: 15px;
                top: 40%;
                transform: translateY(-50%);
                cursor: pointer;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #e0e0e0;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                right: 0;
            }

            .dropdown-content a {
                color: #333;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                font-size: 16px;
            }

            .dropdown-content a:hover {
                background-color: white;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            @media screen and (max-width: 768px) {
                .navbar {
                    
                }

                .dropdown-content {
                    position: static;
                    min-width: 100%;
                    box-shadow: none;
                }

                .icons {
                    display: flex;
                    justify-content: space-between;
                    width: 100%;
                }

                .dropdown-content a {
                    font-size: 14px;
                }
            }

        </style>

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
                        <a href="<%= dashboardLink%>" class="nav-link">Home</a>
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
                <a href="<%= dashboardLink%>" class="brand-link">
                    <img src="dist/img/background/logo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light">Coin Laundry</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar user panel (optional) -->
                    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                        
                        <div class="info">
                            <a href="staff_profile.jsp" class="d-block">
                                <%= session.getAttribute("staffName")%></a>
                            <span class="d-block" style="color:grey"><%= role%></span>
                            </a> <!-- nama di dashboard -->
                        </div>
                    </div>        

                </div>
                <!-- /.sidebar -->
            </aside>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">


                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">


                        <!-- /.row -->
                        <!-- Main row -->
                        <div class="row justify-content-center">
                            <!-- Left col -->
                            <section class="col-md-6 connectedSortable">

                                <div class="container">

                                    <h1><%= role%> Profile</h1>

                                    <% String staffName = (String) session.getAttribute("staffName"); %>
                                    <% String staffEmail = (String) session.getAttribute("staffEmail"); %>
                                    <% String staffPhone = (String) session.getAttribute("staffPhone"); %>
                                    <%String staffPassword = (String) session.getAttribute("staffPassword"); %>
                                    

                                    <!--h3><strong>Welcome, <!--%= role%>  staffName%>!</strong></h3><br-->
                                    <p><strong>Email:</strong> <%= staffEmail%></p></br>
                                    <p><strong>Phone:</strong> <%= staffPhone%></p> </br>


                                    <button class="btn-small" onclick="toggleEditForm()">Edit Profile</button>
                                    <form id="editForm" class="hidden-form" action="EditProfileStaffServlet" method="post">
                                        <label for="staffName">Name</label>
                                        <input type="text" id="staffName" name="staffName" value="<%= staffName%>">

                                        <label for="staffPhone">Phone</label>
                                        <input type="tel" id="staffPhone" name="staffPhone" value="<%= staffPhone%>">

                                        <!-- Password Field in Edit Profile Form with toggle visibility -->
                                        <label for="password">Password</label>
                                        <div class="password-toggle">
                                            <input type="password" id="staffPassword" name="staffPassword" value="<%=staffPassword%>">
                                            <i id="togglePassword" class="fas fa-eye-slash toggle-password" onclick="togglePassword()"></i>
                                        </div>
                                            
                                        <button class="btn-small btn-green" type="submit">Update Profile</button>
                                    </form>               

                                </div> 

                            </section>
                            <!-- /.Left col -->
                        </div>

                        <!-- /.row (main row) -->
                    </div><!-- /.container-fluid -->
                </section>
                <!-- /.content -->
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

        <!-- AdminLTE App -->
        <script src="dist/js/adminlte.js"></script>



        <script>
        function toggleEditForm() {
            var form = document.getElementById("editForm");
            form.style.display = form.style.display === "none" ? "block" : "none";
        }

        function toggleEditPasswordForm() {
            var form = document.getElementById("editPasswordForm");
            form.style.display = form.style.display === "none" ? "block" : "none";
        }
        </script>
        
        <script>
    function togglePassword() {
        var passwordField = document.getElementById("staffPassword");
        var toggleIcon = document.getElementById("togglePassword");

        // Toggle the type between password and text
        if (passwordField.type === "password") {
            passwordField.type = "text"; // Show password
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye");
        } else {
            passwordField.type = "password"; // Hide password
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash");
        }
    }
</script>

        
    </body>
</html>


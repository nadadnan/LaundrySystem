
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
        <title>Customer profile</title>

        <!-- Include stylesheets and fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
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
                margin: 0 auto; /* Centers horizontally */
                background-color: #d0e7fd;
                padding: 20px;
                border-radius: 5px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 50px; /* Adjusted margin for top spacing */
                margin-bottom: 3%;
                position: relative;
                flex: 1;
                display: block; /* Ensures it behaves like a block-level element */
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
                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="row justify-content-center">
                            <section class="col-md-6 connectedSortable">
                                <div class="container">
                                    <h1>Customer Profile</h1>
                                    <% String custName = (String) session.getAttribute("custName"); %>
                                    <% String custEmail = (String) session.getAttribute("custEmail"); %>
                                    <% String custPhone = (String) session.getAttribute("custPhone"); %>
                                    <% String custPassword = (String) session.getAttribute("custPassword");%>
                                    <% String custAddress = (String) session.getAttribute("custAddress");%>

                                    <h3><strong>Welcome, <%= custName%>!</strong></h3><br>
                                    <p><strong>Email:</strong> <%= custEmail%></p></br>
                                    <p><strong>Phone:</strong> <%= custPhone%></p> </br>
                                    <p><strong>Address:</strong> <%= custAddress%></p> </br>

                                    <button class="btn-small" onclick="toggleEditForm()">Edit Profile</button>
                                    <form id="editForm" class="hidden-form" action="EditProfileCustServlet" method="post">
                                        <label for="name">Name</label>
                                        <input type="text" id="custName" name="custName" value="<%= custName%>">

                                        <label for="phone">Phone</label>
                                        <input type="tel" id="custPhone" name="custPhone" value="<%= custPhone%>">

                                        <!-- Password Field in Edit Profile Form with toggle visibility -->
                                        <label for="password">Password</label>
                                        <div class="password-toggle">
                                            <input type="password" id="custPassword" name="custPassword" value="<%=custPassword%>">
                                            <i id="togglePassword" class="fas fa-eye-slash toggle-password" onclick="togglePassword()"></i>
                                        </div>

                                        <label for="address">Address</label>
                                        <input type="text" id="custAddress" name="custAddress" value="<%= custAddress%>">

                                        <button class="btn-small btn-green" type="submit">Update Profile</button>
                                    </form>               
                                </div> 
                            </section>
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
            // Function to toggle password visibility
            function togglePassword() {
                const passwordField = document.getElementById('custPassword');
                const toggleIcon = document.getElementById('togglePassword');

                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    toggleIcon.classList.remove('fa-eye-slash');
                    toggleIcon.classList.add('fa-eye');
                } else {
                    passwordField.type = 'password';
                    toggleIcon.classList.remove('fa-eye');
                    toggleIcon.classList.add('fa-eye-slash');
                }
            }
        </script>

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

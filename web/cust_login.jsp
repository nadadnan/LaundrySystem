<%-- 
    Document   : cust_login LMS
    Created on : 24 Nov 2024, 3:43:32 pm
    Author     : NUR NADIYATUL HUSNA BINTI ADNAN (S65470)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Login</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                background: rgb(238,174,202);
                background: radial-gradient(circle, rgba(238,174,202,1) 0%, rgba(148,187,233,1) 100%);
                /*background-color: #f5f5f5;            
                background-image: url('dist/img/background/bg5.jpg');
                background-size: cover; /* Ensures the image covers the entire background */
                /*background-repeat: no-repeat;  Prevents */

            }

            header {
                background-color: rgba(115, 114, 114, 0.7);
                padding: 1rem;
                position: fixed;
                top: 0;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            header nav {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
            }

            header h1 {
                color: black;
                font-size: 1.5rem;
                margin-left: 1rem;
            }

            header nav a {
                text-decoration: none;
            }

            .login-container {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                width: 100%;
            }

            .login-form {
                background-color: white;
                padding: 2rem;
                width: 300px;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .login-form h2 {
                margin-bottom: 1rem;
                color: #333;
            }

            .login-form label {
                display: block;
                font-size: 0.9rem;
                color: #555;
                margin-bottom: 0.5rem;
                text-align: left;
            }

            .login-form input[type="email"],
            .login-form input[type="password"],
            .login-form input[type="text"]{
                width: 100%;
                padding: 0.5rem;
                margin-bottom: 1rem;
                border: 1px solid #ccc;
                border-radius: 4px;
                outline: none;
            }

            .login-form button {
                width: 100%;
                padding: 0.5rem;
                background-color: #333;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
            }

            .login-form button:hover {
                background-color: #555;
            }

            .forgot-password {
                display: block;
                margin-top: 1rem;
                font-size: 0.8rem;
                color: #555;
                text-decoration: none;
            }

            .forgot-password:hover {
                text-decoration: underline;
            }

            /* Modal styles */
            .modal {
                display: none; /* Hidden by default */
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal-content {
                background-color: white;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%;
                border-radius: 8px;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <header>
            <nav>
                <a href="index.jsp"><h1>Coin Laundry</h1></a>
            </nav>
        </header>

        <div class="login-container">
            <form class="login-form" action="LoginCustServlet" method="post">
                <h2>Login</h2>       

                <label for="email">Email</label>
                <input type="email" id="custEmail" name="custEmail" placeholder="" required>


                <label for="password">Password</label>
                <div style="position:relative;">
                    <input type="password" id="custPassword" name="custPassword" required="">
                    <i class="fas fa-eye-slash" style="position:absolute;right:10px;top:40%;transform:translateY(-50%);cursor:pointer;" onclick="togglePasswordVisibility('custPassword')"></i>
                </div>

                <script>
                    function togglePasswordVisibility(fieldId) {
                        var passwordField = document.getElementById(fieldId);
                        var icon = passwordField.nextElementSibling;
                        if (passwordField.type === "password") {
                            passwordField.type = "text";
                            icon.classList.remove("fa-eye-slash");
                            icon.classList.add("fa-eye");
                        } else {
                            passwordField.type = "password";
                            icon.classList.remove("fa-eye");
                            icon.classList.add("fa-eye-slash");
                        }
                    }
                </script>


                <button type="submit">Log In</button>
                <a href="forgotPassword.jsp" class="forgot-password">Forgot password?</a>
                <a href="cust_register.jsp" class="forgot-password">Register Now</a>
            </form>
        </div>

        <%-- Display success modal if registration is successful --%>
        <% String status = (String) request.getAttribute("status");
            if ("success".equals(status)) { %>
        <div id="successModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <p>Registration successful! Please log in to continue.</p>
            </div>
        </div>

        <script>
            // Show modal on page load
            window.onload = function () {
                document.getElementById("successModal").style.display = "block";
            };

            // Close modal function
            function closeModal() {
                document.getElementById("successModal").style.display = "none";
            }
        </script>
        <% }%>
        
        <%-- Display error modal if login failed --%>
<% String error = (String) request.getAttribute("error");
   if (error != null) { %>
<div id="errorModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeErrorModal()">&times;</span>
        <p><%= error %></p>
    </div>
</div>

<script>
    // Show error modal on page load
    window.onload = function () {
        document.getElementById("errorModal").style.display = "block";
    };

    // Close modal function
    function closeErrorModal() {
        document.getElementById("errorModal").style.display = "none";
    }
</script>
<% } %>


    </body>
</html>

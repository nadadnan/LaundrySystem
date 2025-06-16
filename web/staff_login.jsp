<%-- 
    Document   : staff_login
    Created on : 1 Dec 2024, 7:03:26 pm
    Author     : M S I
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Login Staff Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
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
                
                
                /*background-color: #f5f5f5;*/
                background: rgb(2,0,36);
background: radial-gradient(circle, rgba(2,0,36,1) 0%, rgba(56,9,121,1) 37%, rgba(0,212,255,1) 100%);
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


            .container {
    width: 90%;
    max-width: 400px;
    margin: 80px auto 20px auto; /* allow for header height */
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}


            h1 {
                text-align: center;
                margin-bottom: 10px;
            }

            label {
                font-weight: bold;
                display: block;
            }

            input[type="text"],
            select,
            input[type="tel"],
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 100%;
                background-color: black;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color:#333333;
            }

            p {
                text-align: center;
            }

            a {
                color: #007bff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            .select-group {
                /*display: flex;
                align-items: center;*/
                margin-bottom: 20px;
            }

        </style>
    </head>
    <body>
        <header>
            <nav>
                <a href="index.jsp"><h1>Coin Laundry</h1></a>
            </nav>
        </header>


        <div class="container">
            <h1>EMPLOYEE LOGIN</h1>
            <form action="LoginStaffServlet" method="post">

                <label for="staffEmail">Email</label>
                <input type="email" id="staffEmail" name="staffEmail" required>

                <label for="staffPassword">Password</label>
                <div style="position:relative;">
                <input type="password" id="staffPassword" name="staffPassword" required="">
                <i class="fas fa-eye-slash" style="position:absolute;right:10px;top:40%;transform:translateY(-50%);cursor:pointer;" onclick="togglePasswordVisibility('staffPassword')"></i>
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


                <label for="role">Role</label><br>
                <div class="select-group">
                    <select id="role" name="role">
                        <option value="">-- Select Role --</option>
                        <option value="staff">Operational Staff</option>
                        <option value="delPerson">Delivery Personnel</option>
                        <option value="manager">Manager</option>
                    </select>
                </div>

                <input type="submit" value="Login">

            </form>
            
            <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Invalid Email or Password or Role. Please try again.</p>
            <% }%>
            
        </div>
    </body>
</html>

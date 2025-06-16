<%-- 
    Document   : cust_register
    Created on : 24 Nov 2024, 3:57:49 pm
    Author     : NUR NADIYATUL HUSNA BINTI ADNAN (S65470)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <title>Customer Registration</title>
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
    min-height: 100vh;
    background: linear-gradient(to bottom right, #dfe9f3, #ffffff);
    padding: 1rem;
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
    width: 100%;
    padding-top: 4rem;
}

.login-form {
    background-color: white;
    padding: 2rem;
    width: 100%;
    max-width: 500px;
    border-radius: 8px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
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

.login-form input,
.login-form textarea {
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
    font-size: 0.9rem;
    color: #555;
    text-decoration: none;
}

.forgot-password:hover {
    text-decoration: underline;
}

/* Show/hide password icon */
.password-toggle {
    position: relative;
}

.password-toggle i {
    position: absolute;
    right: 10px;
    top: 40%;
    transform: translateY(-50%);
    cursor: pointer;
}

/* Modal styles */
.modal {
    display: none;
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
    width: 90%;
    max-width: 400px;
    border-radius: 8px;
    text-align: center;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    color: red;
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
}

/* Responsive adjustments */
@media (max-width: 600px) {
    header h1 {
        font-size: 1.2rem;
    }

    .login-form {
        padding: 1rem;
    }

    .login-form h2 {
        font-size: 1.3rem;
    }

    .nav-links {
        gap: 1rem;
        font-size: 0.9rem;
    }
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
            <form class="login-form" action="SaveCustServlet" method="post">
                <h2>Customer Registration</h2>
                <label for="custName">Name</label>
                <input type="text" id="custName" name="custName" placeholder="" required>

                <label for="custPhone">Phone number:</label>
                <input type="tel" id="custPhone" name="custPhone" placeholder="" pattern="[0-9]{10}" required>


                <label for="custAddress">Address</label>
                <textarea id="custAddress" name="custAddress" placeholder="Enter your full address here" rows="4" cols="50" required></textarea>

                <label for="postalCode">Postal Code</label>
                <input type="text" id="postalCode" name="postalCode" required>

                <label for="custEmail">Email</label>
                <input type="email" id="custEmail" name="custEmail" placeholder="" required>

                <label for="custPassword">Password:</label>
                <div class="password-toggle">
    <input type="password" id="custPassword" name="custPassword" 
        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}" 
        title="Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one number, and one special character." 
        required>
    <i class="fas fa-eye-slash" onclick="togglePasswordVisibility('custPassword')"></i>
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


                <button type="submit">Register</button>
                <a href="cust_login.jsp" class="forgot-password">Already have an account? Login</a>
            </form>
        </div>

            <!-- Modal for displaying messages -->
            <div id="messageModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <p id="modalMessage"></p>
                </div>
            </div>

            <script>
                // Function to show the modal with a message
                function showModal(message) {
                    document.getElementById("modalMessage").innerText = message;
                    document.getElementById("messageModal").style.display = "block";
                }

                // Function to close the modal
                function closeModal() {
                    document.getElementById("messageModal").style.display = "none";
                }

                // Show the modal if a status is set
                window.onload = function () {
                    const status = "${status}";
                    if (status === "invalidPostalCode") {
                        showModal("Sorry, we do not serve your area. The current area based on these postal code: 20680,21020,21030,21060,21080,21100,21300");
                    } else if (status === "failed") {
                        showModal("Registration failed. Please try again.");
                    }
                };
            </script>

            <%-- Display success modal if registration is successful --%>
            <% String status = (String) request.getAttribute("status");
                if ("failed".equals(status)) { %>
            <div id="successModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <p>Email already registered. Please use a different email.</p>
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


    </body>
</html>


<%@ page import="com.Model.CartItem" %>
<%@ page import="java.util.*, com.Model.Cart, com.Model.laundryPackage" %>
<%@ page session="true" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart Test 2</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .cart-item-image {
                width: 50px;
                height: 50px;
            }
            .remove-btn {
                color: red;
                font-weight: bold;
            }
            .total-price {
                font-size: 1.5em;
                font-weight: bold;
            }
            #savedAddressDisplay {
                padding: 10px;
                background-color: #f8f9fa;
                border: 1px solid #ced4da;
                border-radius: 5px;
                margin-bottom: 10px;
            }
        </style>

        <script>
            function toggleNewAddress(selectElement) {
                const newAddressFields = document.getElementById("newAddressFields");
                if (selectElement.value === "new") {
                    newAddressFields.style.display = "block";
                } else {
                    newAddressFields.style.display = "none";
                }
            }

            function validatePostalCode(postalCode) {
                if (!postalCode)
                    return;

                fetch("ValidatePostalCodeServlet", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: `postalCode=${postalCode}`
                })
                        .then(response => response.json())
                        .then(data => {
                            if (!data.isValid) {
                                alert("Invalid postal code. Please enter a valid one.");
                                document.getElementById("newPostalCode").value = ""; // Clear invalid postal code
                            }
                        })
                        .catch(error => console.error("Error validating postal code:", error));
            }
        </script>

        <script>
            window.onload = function () {
                var today = new Date();
                var hours = today.getHours();
                var minutes = today.getMinutes();

                if (hours >= 16) {
                    today.setDate(today.getDate() + 1);
                }

                var day = today.getDate();
                var month = today.getMonth() + 1;
                var year = today.getFullYear();
                var formattedDate = year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);

                var pickupDateInput = document.getElementById("pickupDate");
                pickupDateInput.setAttribute("min", formattedDate);

                var pickupTimeSelect = document.getElementById("pickupTime");

                function updatePickupTimeOptions() {
                    var selectedDate = new Date(pickupDateInput.value);
                    var isToday = selectedDate.toDateString() === new Date().toDateString();

                    Array.from(pickupTimeSelect.options).forEach(option => {
                        var [optionHours, optionMinutes] = option.value.split(":").map(Number);
                        if (isToday && (optionHours < hours || (optionHours === hours && optionMinutes <= minutes))) {
                            option.disabled = true;
                        } else {
                            option.disabled = false;
                        }
                    });
                }

                pickupDateInput.addEventListener("input", function () {
                    var selectedDate = new Date(pickupDateInput.value);
                    if (selectedDate.getDay() === 1) {
                        alert("We are closed on Mondays. Please select another date.");
                        pickupDateInput.value = '';
                    } else {
                        updatePickupTimeOptions();
                    }
                });
            };
        </script>
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Cart Summary</h1>

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">
                Your cart is empty. Add some items to your cart!
            </div>
            <%
            } else {
                Map<String, CartItem> items = cart.getItems();
                String custAddress = (String) session.getAttribute("custAddress");
            %>

            <!-- Address Section -->
            <div id="savedAddressDisplay">
                <strong>Saved Address:</strong> <%= custAddress != null ? custAddress : "No saved address available"%>
            </div>

            <!-- Pickup Date and Time Selection -->
            <div class="form-group mt-3">
                <label for="pickupDate">Choose Pickup Date:</label>
                <input type="date" name="pickupDate" id="pickupDate" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="pickupTime">Choose Pickup Time:</label>
                <select name="pickupTime" id="pickupTime" class="form-control" required>
                    <option value="08:00:00">8:00 AM</option>
                    <option value="09:00:00">9:00 AM</option>
                    <option value="10:00:00">10:00 AM</option>
                    <option value="11:00:00">11:00 AM</option>
                    <option value="12:00:00">12:00 PM</option>
                    <option value="13:00:00">1:00 PM</option>
                    <option value="14:00:00">2:00 PM</option>
                    <option value="15:00:00">3:00 PM</option>
                    <option value="16:00:00">4:00 PM</option>
                </select>
            </div>

            <form action="UpdateCartServlet" method="post">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th>Package Name</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (CartItem item : items.values()) {
                                    double itemTotalPrice = item.getLaundryPackage().getPackagePrice() * item.getQuantity();
                            %>
                            <tr>
                                <td><%= item.getLaundryPackage().getPackageName() %></td>
                                <td>
                                    <input type="number" name="quantity_<%= item.getLaundryPackage().getPackageID() %>" 
                                           value="<%= item.getQuantity() %>" min="1" class="form-control w-50"
                                           onchange="updateCartQuantity('<%= item.getLaundryPackage().getPackageID() %>', this.value)">
                                </td>
                                <td>RM <%= itemTotalPrice %></td>
                                <td><img src="packageImages/<%= item.getLaundryPackage().getPackageImage() %>" class="cart-item-image"></td>
                                <td>
                                    <a href="RemoveFromCartServlet?packageID=<%= item.getLaundryPackage().getPackageID() %>" class="remove-btn">Remove</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <h3 class="total-price">Delivery Fee (2-ways): RM10</h3>
                <div class="d-flex justify-content-between mt-3">
                    <h3 class="total-price">Grand Total: RM <%= cart.getTotalPrice() + 10 %></h3>
                </div>
            </form>

            <form action="SaveOrderServlet" method="post" class="mt-3">
                <input type="hidden" name="custID" value="${sessionScope.customer.custID}" />
                <input type="hidden" name="pickupDate" id="hiddenPickupDate">
                <input type="hidden" name="pickupTime" id="hiddenPickupTime">
                <input type="hidden" name="address" id="hiddenAddress">
                <input type="hidden" name="totalPrice" value="<%= cart.getTotalPrice() + 10 %>">

                <button type="submit" class="btn btn-success btn-block">Place Order</button>
            </form>

            <script>
                document.querySelector('form[action="SaveOrderServlet"]').addEventListener('submit', function (e) {
                    const pickupDate = document.getElementById('pickupDate').value;
                    const pickupTime = document.getElementById('pickupTime').value;
                    const addressSelect = document.getElementById('addressSelect') ? document.getElementById('addressSelect').value : 'saved';

                    if (!pickupDate) {
                        alert('Please select a pickup date.');
                        e.preventDefault();
                        return;
                    }

                    if (!pickupTime) {
                        alert('Please select a pickup time.');
                        e.preventDefault();
                        return;
                    }

                    const address = addressSelect === 'saved'
                            ? '<%= custAddress %>'
                            : document.getElementById('newAddress') ? document.getElementById('newAddress').value : '';

                    if (addressSelect === 'new' && !document.getElementById('newAddress').value.trim()) {
                        alert('Please enter a valid address.');
                        e.preventDefault();
                        return;
                    }

                    document.getElementById('hiddenAddress').value = address;
                    document.getElementById('hiddenPickupDate').value = pickupDate;
                    document.getElementById('hiddenPickupTime').value = pickupTime;
                });
            </script>

            <%
                }
            %>

            <div class="mt-4 text-center">
                <a href="ViewPackageServlet" class="btn btn-info">Continue Shopping</a>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

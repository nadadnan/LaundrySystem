<%-- 
    Document   : assignedOrders
    Created on : 25 Mar 2025, 3:11:39 pm
    Author     : M S I
--%>

<%@page import="com.Model.Orders"%>
<%@page import="java.util.List"%>
<%@page import="com.DAO.ordersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="col-12">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">My Assigned Orders</h3>
        </div>            

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Address</th>
                    <th>Pickup Date</th>
                    <th>Total Price (RM)</th>
                    <th>Update Status</th>
                </tr>

                <%
                    ordersDAO orderDAO = new ordersDAO();
                    int staffID = (int) session.getAttribute("staffID"); // Assuming staff logs in and session holds their ID
                    List<Orders> assignedOrders = orderDAO.getOrdersByStaffID(staffID);

                    for (Orders order : assignedOrders) {
                %>
                <tr>
                    <td><%= order.getOrderID() %></td>
                    <td><%= order.getCustID() %></td>
                    <td><%= order.getCustAddress() %></td>
                    <td><%= order.getPickupDate() %></td>
                    <td><%= order.getTotalPrice() %></td>
                    <td>
                        <form action="UpdateOrderStatusServlet" method="POST">
                            <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                            <select name="orderStatus">
                                <option value="Pending">Pending</option>
                                <option value="In Progress">In Progress</option>
                                <option value="Completed">Completed</option>
                            </select>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>
</div>

    </body>
</html>

<%-- 
    Document   : paymentPage
    Created on : 2 Mar 2025, 8:05:37 am
    Author     : M S I

tik61egn-wpv2-dhn1-zmdx-1r2mwcd0dl0n || u3am06r5-uivg-t3y5-frnh-1gwbedos0j4i
e6g9ugwz || 329ioiwj
--%>
<%@page import="com.DAO.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.net.*, java.io.*, com.DAO.ordersDAO"%>

<%
    // Ensure session exists and retrieve customer ID
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("cust_login.jsp"); // Redirect if not logged in
        return;
    }

    // Get customer details from session
    String custID = (String) session.getAttribute("custID");
    String custName = (String) session.getAttribute("custName");
    String custEmail = (String) session.getAttribute("custEmail");
    String custPhone = (String) session.getAttribute("custPhone");

    // Fetch the latest order details from the database
    double totalAmount = 0.0;
    int orderID = 0;

    try {
        Connection con = DBUtil.getConnection();
        String query = "SELECT orderID, totalPrice FROM orders WHERE custID = ? ORDER BY orderID DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, custID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            orderID = rs.getInt("orderID");
            totalAmount = rs.getDouble("totalPrice");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Convert total amount to cents for ToyyibPay
    int billAmount = (int) (totalAmount * 100);

    // ToyyibPay API Credentials
    String userSecretKey = "u3am06r5-uivg-t3y5-frnh-1gwbedos0j4i";
    String categoryCode = "329ioiwj";
    
    // API Response Handling
    String responseJson = "";
    String billCode = "";

    try {
        // Prepare API request data
        String apiUrl = "https://dev.toyyibpay.com/index.php/api/createBill";
        String postData = "userSecretKey=" + URLEncoder.encode(userSecretKey, "UTF-8") +
                          "&categoryCode=" + URLEncoder.encode(categoryCode, "UTF-8") +
                          "&billName=" + URLEncoder.encode("Laundry Payment", "UTF-8") +
                          "&billDescription=" + URLEncoder.encode("Payment for Laundry Service (Order #" + orderID + ")", "UTF-8") +
                          "&billPriceSetting=1" +
                          "&billPayorInfo=1" +
                          "&billAmount=" + billAmount +
                          "&billReturnUrl=" + URLEncoder.encode("http://localhost:8080/Laundry/paymentSuccess.jsp", "UTF-8") +
                          "&billCallbackUrl=" + URLEncoder.encode("http://localhost:8080/Laundry/PaymentCallbackServlet", "UTF-8") +
                          "&billExternalReferenceNo=" + URLEncoder.encode("ORDER" + orderID, "UTF-8") +
                          "&billTo=" + URLEncoder.encode(custName, "UTF-8") +
                          "&billEmail=" + URLEncoder.encode(custEmail, "UTF-8") +
                          "&billPhone=" + URLEncoder.encode(custPhone, "UTF-8") +
                          "&billPaymentChannel=0" +
                          "&billExpiryDays=3";

        // Open connection
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        // Send request
        OutputStream os = conn.getOutputStream();
        os.write(postData.getBytes("UTF-8"));
        os.flush();
        os.close();

        // Read API response
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String output;
        while ((output = br.readLine()) != null) {
            responseJson += output;
        }
        br.close();
        
        // Extract billCode from JSON response
        if (responseJson.contains("BillCode")) {
            billCode = responseJson.split("\"BillCode\":\"")[1].split("\"")[0];
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
</head>
<body>

<h2>Proceed with Payment</h2>

<form action="https://dev.toyyibpay.com/index.php/api/createBill" method="POST">
    <input type="hidden" name="userSecretKey" value="<%= userSecretKey %>">
    <input type="hidden" name="categoryCode" value="<%= categoryCode %>">

    <label>Bill Name:</label>
    <input type="text" name="billName" value="Laundry Payment" readonly><br>

    <label>Bill Description:</label>
    <input type="text" name="billDescription" value="Payment for Laundry Service (Order #<%= orderID %>)" readonly><br>

    <label>Bill Price Setting:</label>
    <input type="text" name="billPriceSetting" value="1" readonly><br>

    <label>Require Payor Info:</label>
    <input type="text" name="billPayorInfo" value="1" readonly><br>

    <label>Bill Amount (in cents):</label>
    <input type="number" name="billAmount" value="<%= billAmount %>" readonly><br>

    <label>Return URL:</label>
    <input type="text" name="billReturnUrl" value="http://localhost:8080/Laundry/paymentSuccess.jsp" readonly><br>

    <label>Callback URL:</label>
    <input type="text" name="billCallbackUrl" value="http://localhost:8080/Laundry/PaymentCallbackServlet" readonly><br>

    <label>External Reference No:</label>
    <input type="text" name="billExternalReferenceNo" value="ORDER<%= orderID %>" readonly><br>

    <label>Customer Name:</label>
    <input type="text" name="billTo" value="<%= custName %>" readonly><br>

    <label>Customer Email:</label>
    <input type="email" name="billEmail" value="<%= custEmail %>" readonly><br>

    <label>Customer Phone:</label>
    <input type="text" name="billPhone" value="<%= custPhone %>" readonly><br>

    <label>Payment Channel:</label>
    <select name="billPaymentChannel">
        <option value="0">FPX</option>
        <option value="1">Credit Card</option>
        <option value="2">Both FPX & Credit Card</option>
    </select><br>

    <label>Additional Email Content:</label>
    <textarea name="billContentEmail">Thank you for choosing our laundry service!</textarea><br>

    <label>Bill Expiry Days:</label>
    <input type="number" name="billExpiryDays" value="3" readonly><br>

    <button type="submit">Proceed to Payment</button>
</form>

<%
    // Redirect to the payment page if billCode is received
    if (billCode != null && !billCode.isEmpty()) {
%>
    <script>
        window.location.href = "https://dev.toyyibpay.com/<%= billCode %>";
    </script>
<%
    }
%>

</body>
</html>

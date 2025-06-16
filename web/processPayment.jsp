<%-- 
    Document   : processPayment
    Created on : 27 Feb 2025, 11:40:25 am
    Author     : M S I
    secret key : tik61egn-wpv2-dhn1-zmdx-1r2mwcd0dl0n || DEV : u3am06r5-uivg-t3y5-frnh-1gwbedos0j4i
    categ code : e6g9ugwz || DEV : r6rh0vjb
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject, org.json.JSONArray" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Processing Payment</title>
    </head>
    <body>
        <h2>Processing Payment...</h2>
<%! String uniqueOrderID = "Order" + System.currentTimeMillis(); %>
<%
    try {
        // Get total amount from request
        String totalAmountStr = request.getParameter("totalAmount");
        double totalAmount = (totalAmountStr != null && !totalAmountStr.isEmpty()) ? Double.parseDouble(totalAmountStr) : 0.0;

        // Convert to cents
        int amountCents = (int) (totalAmount * 100);

        // 1️⃣ Create a HashMap to store API parameters
        Map<String, String> params = new HashMap<>();
        params.put("userSecretKey", "u3am06r5-uivg-t3y5-frnh-1gwbedos0j4i");  
        params.put("categoryCode", "r6rh0vjb");
        params.put("billName", "Laundry Service");
        params.put("billDescription", "Payment for laundry order");
        params.put("billAmount", String.valueOf(amountCents));
        params.put("billExternalReferenceNo", uniqueOrderID); // ✅ Now using predeclared variable
        params.put("billReturnUrl", "paymentSuccess.jsp"); 
        params.put("billCallbackUrl", "paymentCallback.jsp");

        // 2️⃣ Send HTTP Request to ToyyibPay API
        URL url = new URL("https://toyyibpay.com/index.php/api/createBill");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setDoOutput(true);

        // 3️⃣ Convert params to URL-encoded form data
        StringBuilder postData = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (postData.length() != 0) postData.append('&');
            postData.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
            postData.append('=');
            postData.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
        }

        // 4️⃣ Send the request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = postData.toString().getBytes("UTF-8");
            os.write(input, 0, input.length);
        }

        // 5️⃣ Read API Response
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder apiResponse = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            apiResponse.append(inputLine);
        }
        in.close();

        // 6️⃣ Print API Response for Debugging
        out.println("ToyyibPay Response: " + apiResponse.toString());

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>

    </body>
</html>

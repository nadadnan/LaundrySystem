<%-- 
    Document   : paymentCallback
    Created on : 4 Mar 2025, 8:52:08 am
    Author     : M S I
--%>

<%@page import="com.DAO.DBUtil"%>
<%@page import="java.net.*, java.io.*, java.sql.*, org.json.JSONArray, org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--%
    System.out.println("paymentCallback.jsp CALLED");

    String billCode = request.getParameter("billcode");
    String transactionID = request.getParameter("transaction_id");
    String orderID = request.getParameter("order_id");

    System.out.println("Received Params - billCode: " + billCode + ", transactionID: " + transactionID + ", orderID: " + orderID);

    if (billCode == null || transactionID == null || orderID == null) {
        out.println("Invalid request.");
        return;
    }

    String apiUrl = "https://dev.toyyibpay.com/index.php/api/getTransaction?billCode=" + billCode;
    String responseJson = "";

    try {
        // Call ToyyibPay API
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            responseJson += inputLine;
        }
        in.close();

        JSONArray jsonArray = new JSONArray(responseJson);
        JSONObject transaction = jsonArray.getJSONObject(0);

        System.out.println("Transaction JSON: " + transaction.toString());

        String paymentStatus = transaction.getString("status");
        System.out.println("Payment Status: " + paymentStatus);

        if ("1".equals(paymentStatus)) {
    Connection con = DBUtil.getConnection();

    // Convert "ORDER001" to 1
    int parsedOrderID = Integer.parseInt(orderID.replace("ORDER", ""));

    // Check if orderID exists
    PreparedStatement checkOrder = con.prepareStatement("SELECT * FROM orders WHERE orderID = ?");
    checkOrder.setInt(1, parsedOrderID);

            //checkOrder.setInt(1, Integer.parseInt(orderID));
            checkOrder.setInt(1, parsedOrderID);

            ResultSet rs = checkOrder.executeQuery();
            if (!rs.next()) {
                out.println("Error: orderID " + orderID + " does not exist in orders table.");
                System.out.println("Error: orderID not found.");
                return;
            }
            rs.close();
            checkOrder.close();

            // Insert into payment table
            String insertPayment = "INSERT INTO payment (orderID, transactionID, paymentStatus, paymentDate, paymentMethod) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps1 = con.prepareStatement(insertPayment, Statement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, Integer.parseInt(orderID));
            ps1.setString(2, transactionID);
            ps1.setString(3, "Completed");
            ps1.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
            ps1.setString(5, "ToyyibPay");

            System.out.println("Executing insertPayment...");
            int rowsInserted = ps1.executeUpdate();
            System.out.println("Rows Inserted: " + rowsInserted);

            int paymentID = 0;
            ResultSet generatedKeys = ps1.getGeneratedKeys();
            if (generatedKeys.next()) {
                paymentID = generatedKeys.getInt(1);
                System.out.println("Generated paymentID: " + paymentID);
            } else {
                System.out.println("No generated keys returned!");
            }
            ps1.close();

            // Update orders table
            PreparedStatement ps2 = con.prepareStatement("UPDATE orders SET paymentID = ?, paymentStatus = 'Paid' WHERE orderID = ?");
            ps2.setInt(1, paymentID);
            ps2.setInt(2, Integer.parseInt(orderID));
            ps2.executeUpdate();
            ps2.close();

            con.close();

            response.sendRedirect("paymentSuccess.jsp?order_id=" + orderID + "&transaction_id=" + transactionID);
        } else {
            System.out.println("Payment failed for order: " + orderID);
            response.sendRedirect("paymentFailed.jsp?order_id=" + orderID + "&transaction_id=" + transactionID);
        }

    } catch (Exception e) {
        e.printStackTrace();
        //e.printStackTrace(); // Also output to browser for debugging
        response.sendRedirect("paymentFailed.jsp?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
    }
%>

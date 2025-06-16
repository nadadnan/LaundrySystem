<%-- 
    Document   : errorPage
    Created on : 10 Jan 2025, 10:28:08 am
    Author     : M S I
--%>

<%@ page isErrorPage="true" %>
<%@ page import="java.lang.Exception" %>
<html>
    <body>
        <h1>An error occurred</h1>
    <p>${error}</p>
    <a href="cart2.jsp">Go back to cart</a>
    </body>
</html>




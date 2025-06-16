<%-- 
    Document   : editCoverageArea
    Created on : 21 Jan 2025, 2:19:59 am
    Author     : M S I
--%>

<%@ page import="com.Model.CoverageArea" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Coverage Area</title>
</head>
<body>
    <h3>Edit Coverage Area</h3>
    <form action="EditCoverageAreaServlet" method="post">
    <input type="hidden" name="id" value="${coverageArea.id}" />
    <label for="postal_code">Postal Code:</label>
    <input type="text" name="postal_code" value="${coverageArea.postal_code}" required/>
    
    <label for="area_name">Area Name:</label>
    <input type="text" name="area_name" value="${coverageArea.area_name}" required/><br>
    
    <input type="submit" value="Edit & Save"/>
</form>

</body>
</html>


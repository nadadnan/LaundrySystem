/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.Model.Cart;
import com.Model.CartItem;
import com.Model.laundryPackage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to cart.jsp to display the cart
        //request.getRequestDispatcher("cart1.jsp").forward(request, response);
    }
        
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        // Get the laundry package ID from the request (sent by the form)
        String packageID = request.getParameter("packageID");
        String packageName = request.getParameter("packageName");
        double packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
        String packageDesc = request.getParameter("packageDesc");
        String packageImage = request.getParameter("packageImage");
        //int quantity = Integer.parseInt(request.getParameter("orderQty"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Create a new laundry package object
    laundryPackage newPackage = new laundryPackage();
    newPackage.setPackageID(packageID);
    newPackage.setPackageName(packageName);
    newPackage.setPackagePrice(packagePrice);
    newPackage.setPackageDesc(packageDesc);
    newPackage.setPackageImage(packageImage);

    // Get the session and check if the cart already exists
    HttpSession session = request.getSession();
    Cart cart = (Cart) session.getAttribute("cart");

    // If no cart exists, create a new one
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }

    // Add the laundry package to the cart with the specified quantity
    cart.addItem(newPackage, quantity);
    
    // Add success message to the session
    //session.setAttribute("successMessage", "Package '" + packageName + "' was successfully added to the cart!");
    session.setAttribute("successMessage", "Item added to cart successfully!");

    // Redirect back to the menu page or any other page you want after adding to the cart
    response.sendRedirect("ViewPackageServlet"); 
    
    
    }

    @Override
    public String getServletInfo() {
        return "Handles adding items to the cart.";
    }
}

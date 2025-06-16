/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.laundryPackageDAO;
import com.Model.laundryPackage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * SavePackageServlet handles saving package details including file uploads.
 */
@WebServlet(name = "SavePackageServlet", urlPatterns = {"/SavePackageServlet"})
@MultipartConfig // Enables file upload handling
public class SavePackageServlet extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(SavePackageServlet.class.getCanonicalName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LOGGER.log(Level.INFO, "SavePackageServlet invoked.");
        
        try (PrintWriter out = response.getWriter()) {
            // Fetch form data
            String packageName = request.getParameter("packageName");
            String packageDesc = request.getParameter("packageDesc");

            // Parse and validate package price
            String priceParam = request.getParameter("packagePrice");
            double packagePrice;
            try {
                if (priceParam == null || priceParam.isEmpty()) {
                    throw new IllegalArgumentException("Package price is required.");
                }
                packagePrice = Double.parseDouble(priceParam);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "Invalid package price format: " + priceParam, e);
                out.println("<script>alert('Invalid package price. Please enter a valid number.'); window.history.back();</script>");
                return;
            }

            // Handle file upload
            Part part = request.getPart("packageImage");
            if (part == null || part.getSubmittedFileName().isEmpty()) {
                LOGGER.log(Level.WARNING, "No file uploaded.");
                out.println("<script>alert('Please upload a valid image.'); window.history.back();</script>");
                return;
            }

            String fileName = part.getSubmittedFileName();
            String savePath = getServletContext().getRealPath("/packageImages");
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs(); // Create directory if it doesn't exist
            }

            String filePath = savePath + File.separator + fileName;
            try (InputStream inputStream = part.getInputStream();
                 FileOutputStream outputStream = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                LOGGER.log(Level.INFO, "File uploaded successfully to: {0}", filePath);
            } catch (IOException e) {
                LOGGER.log(Level.SEVERE, "File upload failed: " + e.getMessage(), e);
                out.println("<script>alert('Failed to upload the image. Please try again.'); window.history.back();</script>");
                return;
            }

            // Save package data to the database
            laundryPackage e = new laundryPackage();
            e.setPackageName(packageName);
            e.setPackageDesc(packageDesc);
            e.setPackagePrice(packagePrice);
            e.setPackageImage(fileName);

            int status = 0;
            try {
                status = laundryPackageDAO.save(e);
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, "Database save failed: " + ex.getMessage(), ex);
                out.println("<script>alert('Failed to save record in the database.'); window.history.back();</script>");
                return;
            }

            if (status > 0) {
                LOGGER.log(Level.INFO, "Record saved successfully.");
                out.println("<script>alert('Record saved successfully!'); window.location.href = 'managePackage.jsp';</script>");
            } else {
                LOGGER.log(Level.WARNING, "Failed to save record.");
                out.println("<script>alert('Sorry! Unable to save the record.'); window.history.back();</script>");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error: " + e.getMessage(), e);
            response.getWriter().println("<script>alert('An unexpected error occurred. Please try again later.'); window.history.back();</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "SavePackageServlet for saving laundry package details";
    }
}

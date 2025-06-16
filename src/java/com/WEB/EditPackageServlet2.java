/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.WEB;

import com.DAO.laundryPackageDAO;
import com.Model.laundryPackage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author M S I
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class EditPackageServlet2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("Before TRY");
        try {
            // Use packageID as a String since it is now a VARCHAR in the database
            String packageID = request.getParameter("packageID");
            System.out.println("PRODUCT ID : =" + packageID);
            String packageName = request.getParameter("packageName");
            String packageDesc = request.getParameter("packageDesc");
            Double packagePrice = Double.valueOf(request.getParameter("packagePrice"));
            
            // Handle the image file upload
            Part part = request.getPart("packageImage");
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String packageImage = null;

            if (fileName != null && !fileName.isEmpty()) {
                String savePath = "C:\\CSF4984 FINAL YEAR PROJECT I\\code\\test-admin-Lte\\web\\packageImages";
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }
                part.write(savePath + File.separator + fileName);
                packageImage = fileName; // Set new image file name
            } else {
                // Fetch the existing image if no new image is uploaded
                laundryPackage existingMenu = laundryPackageDAO.getPackageById(packageID);
                packageImage = existingMenu.getPackageImage();
            }

            laundryPackage pack = new laundryPackage();
            pack.setPackageID(packageID); // Set packageID as String
            pack.setPackageName(packageName);
            pack.setPackageDesc(packageDesc);
            pack.setPackagePrice(packagePrice);
            pack.setPackageImage(packageImage);

            int status = laundryPackageDAO.update(pack);
            if (status > 0) {
                out.print("<script>alert('Record updated successfully!');</script>");
                request.getRequestDispatcher("managePackage.jsp").include(request, response);
            } else {
                out.print("<script>alert('Sorry! Unable to update record.');</script>");
                request.getRequestDispatcher("managePackage.jsp").include(request, response);
            }
        } catch (Exception e) {
            out.print("<script>alert('Error: " + e.getMessage() + "');</script>");
            request.getRequestDispatcher("managePackage.jsp").include(request, response);
        } finally {
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

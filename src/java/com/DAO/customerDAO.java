/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * Author: NUR NADIYATUL HUSNA BINTI ADNAN (S65470)
 */
package com.DAO;

import com.Model.CoverageArea;
import com.Model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

//import de.mkammerer.argon2.Argon2;
//import de.mkammerer.argon2.Argon2Factory;

public class customerDAO {

    // Checks if the given email already exists in the database
    public static boolean isEmailExist(String email) {
        boolean emailExists = false;
        try (Connection con = DBUtil.getConnection()) {
            String query = "SELECT COUNT(*) FROM customer WHERE custEmail = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                emailExists = rs.getInt(1) > 0;  // If count is greater than 0, email exists
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emailExists;
    }

    // Inserts a new customer record into the database
    public static int save(Customer e) {
        int status = 0;
        try {
            // Avoid duplicate emails
            if (isEmailExist(e.getCustEmail())) {
                System.out.println("Email already exists. Cannot register.");
                return status;
            }

            Connection con = DBUtil.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO customer(custName, custPhone, custEmail, custPassword, custAddress) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, e.getCustName());
                ps.setString(2, e.getCustPhone());
                ps.setString(3, e.getCustEmail());
                ps.setString(4, e.getCustPassword());
                ps.setString(5, e.getCustAddress());

                status = ps.executeUpdate(); // Execute insert query
                System.out.println("Record inserted successfully, status: " + status);

                con.close();
            } else {
                System.out.println("Connection to database failed.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Error saving customer: " + ex.getMessage());
        }
        return status;
    }

    // Updates existing customer data
    public static int update(Customer e) {
        int status = 0;
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE customer set custName=?,custPhone=?,custEmail=?,custPassword=?,custAddress=? where custID=?");
            ps.setString(1, e.getCustName());
            ps.setString(2, e.getCustPhone());
            ps.setString(3, e.getCustEmail());
            ps.setString(4, e.getCustPassword());
            ps.setString(5, e.getCustAddress());
            ps.setString(6, e.getCustID());

            status = ps.executeUpdate();
            ps.close();    
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    // Deletes a customer by ID
    public static int delete(String custID) {
        int status = 0;
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM customer WHERE custID = ?");
            ps.setString(1, custID);

            status = ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Fetches a single customer by their ID
    public static Customer getCustomerById(String custID) {
        Customer customer = null;

        try {
            Connection con = DBUtil.getConnection();
            String query = "SELECT * FROM customer WHERE custID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, custID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Populate the Customer object with data from the database
                customer = new Customer();
                customer.setCustID(rs.getString("custID"));
                customer.setCustName(rs.getString("custName"));
                customer.setCustPhone(rs.getString("custPhone"));
                customer.setCustEmail(rs.getString("custEmail"));
                customer.setCustPassword(rs.getString("custPassword"));
                customer.setCustAddress(rs.getString("custAddress"));
                customer.setPostalCode(rs.getString("postalCode"));
            }
            rs.close(); // Close ResultSet
            ps.close(); // Close PreparedStatement
            con.close(); // Close connection
        } catch (Exception ex) {
            ex.printStackTrace(); // Handle exceptions
        }
        return customer;
    }

    // Returns a list of all customers
    public static List<Customer> getAllUsers() {
        List<Customer> list = new ArrayList<Customer>();

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM customer");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer e = new Customer();
                e.setCustID(rs.getString(1));
                e.setCustName(rs.getString(2));
                e.setCustPhone(rs.getString(3));
                e.setCustEmail(rs.getString(4));
                e.setCustPassword(rs.getString(5));
                e.setCustAddress(rs.getString(6));
                list.add(e);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Updates a customer's address
    public static void updateCustomerAddress(String custID, String newAddress) throws Exception {
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE customer SET custAddress = ? WHERE custID = ?");
            ps.setString(1, newAddress);
            ps.setString(2, custID);
            ps.executeUpdate();
        }
    }

    // Retrieves a customer's address using their ID
    public static String getCustomerAddress(String custID) throws Exception {
        String address = null;
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT custAddress FROM customer WHERE custID = ?");
            ps.setString(1, custID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                address = rs.getString("custAddress");
            }
        }
        return address;
    }

    // Validates whether a postal code is in the coverage_area table
    public static boolean validatePostalCode(String postalCode, String context) {
        boolean isValid = false;
        try {
            String query = "SELECT * FROM coverage_area WHERE postal_code = ?";
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, postalCode);

            System.out.println("Executing query: " + pstmt.toString());

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                isValid = true;
            } else {
                System.out.println("Postal code not found in the database.");
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
    
    // Retrieves all valid postal codes from delivery_areas table
    public static List<String> getValidPostalCodes() {
        List<String> postalCodes = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT postal_code FROM delivery_areas")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                postalCodes.add(rs.getString("postal_code"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postalCodes;
    }

    // Validate postal code
    public boolean isValidPostalCode(String postalCode) {
        boolean isValid = false;
        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement("SELECT 1 FROM coverage_area WHERE postal_code = ?")) {
            ps.setString(1, postalCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isValid = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    // Inserts a new coverage area record
    public static int saveCoverageArea(CoverageArea e) {
        int status = 0;
        try {
            Connection con = DBUtil.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO coverage_area(postal_code, area_name) VALUES (?, ?)");
                ps.setString(1, e.getPostal_code());
                ps.setString(2, e.getArea_name());

                status = ps.executeUpdate();
                //newline
                System.out.println("Record inserted successfully, status: " + status);

                con.close();
            } else {
                System.out.println("Connection to database failed.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Error saving customer: " + ex.getMessage());
        }
        return status;

    }

    // Returns all coverage area records
    public static List<CoverageArea> getAllCoverageArea() {
        List<CoverageArea> list = new ArrayList<CoverageArea>();

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM coverage_area");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CoverageArea e = new CoverageArea();
                e.setId(rs.getInt(1));
                e.setPostal_code(rs.getString(2));
                e.setArea_name(rs.getString(3));
                list.add(e);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Deletes a coverage area record by ID
    public static int deleteCoverageArea(int Id) {
        int status = 0;
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM coverage_area WHERE Id = ?");
            ps.setInt(1, Id);
            status = ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Fetch CoverageArea by ID
    public static CoverageArea getCoverageAreaById(int id) {
        CoverageArea area = new CoverageArea();
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM coverage_area WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                area.setId(rs.getInt("id"));
                area.setPostal_code(rs.getString("postal_code"));
                area.setArea_name(rs.getString("area_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return area;
    }

    public static int update(CoverageArea area) {
        int status = 0;
        try {
            Connection con = DBUtil.getConnection();
            String updateSQL = "UPDATE coverage_area SET postal_code = ?, area_name = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateSQL);

            ps.setString(1, area.getPostal_code());
            ps.setString(2, area.getArea_name());
            ps.setInt(3, area.getId());

            System.out.println("Executing update: " + updateSQL); // Log SQL query
            status = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

}

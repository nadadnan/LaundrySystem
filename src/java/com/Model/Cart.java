/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.util.HashMap;
import java.util.Map;

/**
 * Cart class holds the shopping cart information.
 * It uses a Map to store CartItems with packageID as the key.
 */
public class Cart {
   
    private Map<String, CartItem> items = new HashMap<>();

    public Map<String, CartItem> getItems() {
        return items;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getLaundryPackage().getPackagePrice() * item.getQuantity();
        }
        return total;
    }

    // Constructor to initialize the Map of items
    public Cart() {
        items = new HashMap<>();
    }

    // Method to add a laundry package to the cart
    public void addItem(laundryPackage pkg, int quantity) {
        String packageID = pkg.getPackageID();
        if (items.containsKey(packageID)) {
            // Update the quantity if the item is already in the cart
            CartItem existingItem = items.get(packageID);
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            // Add a new item to the cart
            items.put(packageID, new CartItem(pkg, quantity));
        }
    }

    // Method to remove a laundry package from the cart
    public void removeItem(String packageID) {
        items.remove(packageID);
    }

    // Method to clear the cart
    public void clearCart() {
        items.clear();
    }
}

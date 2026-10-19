
package com.tap.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private int restaurantId;
    private LinkedHashMap<Integer, CartItem> items;

    public Cart() {
        items = new LinkedHashMap<>();
    }

    public Cart(int restaurantId) {
        this.restaurantId = restaurantId;
        items = new LinkedHashMap<>();
    }

    public void addItem(Menu menu) {

        if (menu == null) {
            return;
        }

        int menuId = menu.getMenuId();

        if (items.containsKey(menuId)) {

            CartItem cartItem = items.get(menuId);
            cartItem.setQuantity(cartItem.getQuantity() + 1);

        } else {

            CartItem cartItem = new CartItem(menu, 1);
            items.put(menuId, cartItem);
        }
    }

    public void updateQuantity(int menuId, int quantity) {

        CartItem cartItem = items.get(menuId);

        if (cartItem == null) {
            return;
        }

        if (quantity <= 0) {
            items.remove(menuId);
        } else {
            cartItem.setQuantity(quantity);
        }
    }

    public void removeItem(int menuId) {
        items.remove(menuId);
    }

    public void clear() {
        items.clear();
        restaurantId = 0;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public double getTotalAmount() {

        double total = 0;

        for (CartItem cartItem : items.values()) {
            total += cartItem.getTotalAmount();
        }

        return total;
    }

    public boolean isEmpty() {
        return items == null || items.isEmpty();
    }

    @Override
    public String toString() {
        return "Cart [restaurantId=" + restaurantId
                + ", items=" + items
                + ", totalAmount=" + getTotalAmount() + "]";
    }
}

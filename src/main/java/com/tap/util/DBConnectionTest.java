package com.tap.util;

import java.sql.Connection;

public class DBConnectionTest {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("JDBC is working correctly.");
        } else {
            System.out.println("JDBC connection failed.");
        }
    }
}
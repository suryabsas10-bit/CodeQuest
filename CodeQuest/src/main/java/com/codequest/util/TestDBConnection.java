
package com.codequest.util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDBConnection {

    public static void main(String[] args) {

        try {

            Connection con = DBConnection.getConnection();

            System.out.println("================================");

            System.out.println("CODEQUEST DATABASE CONNECTED!");

            System.out.println("MySQL Connection Successful!");

            System.out.println("Database: codequest_db");

            System.out.println("================================");

            con.close();

        } catch (SQLException e) {

            System.out.println("DATABASE CONNECTION FAILED!");

            e.printStackTrace();
        }
    }
}

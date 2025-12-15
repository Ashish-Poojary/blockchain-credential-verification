package dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.ConfigReader;

public class Dbconnection {

    private static String getDbUrl() {
        return String.format("jdbc:mysql://%s:%d/%s?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                ConfigReader.getDbHost(),
                ConfigReader.getDbPort(),
                ConfigReader.getDbName());
    }

    public static Connection getConnection() throws SQLException {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            con = DriverManager.getConnection(
                    getDbUrl(), 
                    ConfigReader.getDbUsername(), 
                    ConfigReader.getDbPassword());
            System.out.println("Database connection established successfully!");
        } catch (ClassNotFoundException ex) {
            System.err.println("MySQL JDBC Driver not found!");
            throw new SQLException("MySQL JDBC Driver not found", ex);
        } catch (SQLException ex) {
            System.err.println("Database connection failed!");
            System.err.println("Error: " + ex.getMessage());
            System.err.println("Please ensure:");
            System.err.println("1. MySQL server is running");
            System.err.println("2. Database exists");
            System.err.println("3. Username and password in config.properties are correct");
            throw ex;
        }
        return con;
    }
}

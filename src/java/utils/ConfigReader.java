package utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Configuration Reader Utility
 * Reads configuration from config.properties file
 */
public class ConfigReader {
    private static Properties properties;
    private static final String CONFIG_FILE = "config.properties";
    
    static {
        properties = new Properties();
        loadConfig();
    }
    
    private static void loadConfig() {
        try {
            // Try to load from classpath first (for deployed applications)
            InputStream inputStream = ConfigReader.class.getClassLoader()
                    .getResourceAsStream(CONFIG_FILE);
            
            // If not found in classpath, try from project root
            if (inputStream == null) {
                inputStream = new FileInputStream(CONFIG_FILE);
            }
            
            properties.load(inputStream);
            inputStream.close();
            System.out.println("Configuration loaded successfully from " + CONFIG_FILE);
        } catch (IOException e) {
            System.err.println("Warning: Could not load " + CONFIG_FILE + 
                    ". Using default values. Please create config.properties file.");
            // Set default values
            setDefaults();
        }
    }
    
    private static void setDefaults() {
        // Database defaults
        properties.setProperty("db.host", "localhost");
        properties.setProperty("db.port", "3306");
        properties.setProperty("db.name", "studentcertificate");
        properties.setProperty("db.username", "root");
        properties.setProperty("db.password", "root");
        
        // Email defaults
        properties.setProperty("email.smtp.host", "smtp.gmail.com");
        properties.setProperty("email.smtp.port", "465");
        properties.setProperty("email.smtp.username", "");
        properties.setProperty("email.smtp.password", "");
        properties.setProperty("email.from.address", "");
        
        // Admin email
        properties.setProperty("admin.email", "admin@example.com");
        
        // Storage paths
        properties.setProperty("storage.certificates.path", "C:/certificates");
        properties.setProperty("storage.images.path", "C:/studentcertificate");
        properties.setProperty("storage.download.path", "C:/download/certificates");
        
        // Blockchain server
        properties.setProperty("blockchain.server.host", "localhost");
        properties.setProperty("blockchain.server.port", "3000");
        
        // FTP
        properties.setProperty("ftp.enabled", "false");
    }
    
    public static String getProperty(String key) {
        return properties.getProperty(key, "");
    }
    
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    // Database configuration getters
    public static String getDbHost() {
        return getProperty("db.host", "localhost");
    }
    
    public static int getDbPort() {
        return Integer.parseInt(getProperty("db.port", "3306"));
    }
    
    public static String getDbName() {
        return getProperty("db.name", "studentcertificate");
    }
    
    public static String getDbUsername() {
        return getProperty("db.username", "root");
    }
    
    public static String getDbPassword() {
        return getProperty("db.password", "root");
    }
    
    // Email configuration getters
    public static String getSmtpHost() {
        return getProperty("email.smtp.host", "smtp.gmail.com");
    }
    
    public static String getSmtpPort() {
        return getProperty("email.smtp.port", "465");
    }
    
    public static String getSmtpUsername() {
        return getProperty("email.smtp.username");
    }
    
    public static String getSmtpPassword() {
        return getProperty("email.smtp.password");
    }
    
    public static String getFromEmail() {
        return getProperty("email.from.address");
    }
    
    // Admin email
    public static String getAdminEmail() {
        return getProperty("admin.email", "admin@example.com");
    }
    
    // Storage paths
    public static String getCertificatesPath() {
        return getProperty("storage.certificates.path", "C:/certificates");
    }
    
    public static String getImagesPath() {
        return getProperty("storage.images.path", "C:/studentcertificate");
    }
    
    public static String getDownloadPath() {
        return getProperty("storage.download.path", "C:/download/certificates");
    }
    
    // Blockchain server
    public static String getBlockchainHost() {
        return getProperty("blockchain.server.host", "localhost");
    }
    
    public static int getBlockchainPort() {
        return Integer.parseInt(getProperty("blockchain.server.port", "3000"));
    }
}


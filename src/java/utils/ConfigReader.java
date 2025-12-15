package utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigReader {
    private static Properties properties;
    private static final String CONFIG_FILE = "config.properties";
    
    static {
        properties = new Properties();
        loadConfig();
    }
    
    private static void loadConfig() {
        try {
            InputStream inputStream = ConfigReader.class.getClassLoader()
                    .getResourceAsStream(CONFIG_FILE);
            
            if (inputStream == null) {
                inputStream = new FileInputStream(CONFIG_FILE);
            }
            
            properties.load(inputStream);
            inputStream.close();
        } catch (IOException e) {
            System.err.println("Warning: Could not load " + CONFIG_FILE + ". Using default values.");
            setDefaults();
        }
    }
    
    private static void setDefaults() {
        properties.setProperty("email.smtp.host", "smtp.gmail.com");
        properties.setProperty("email.smtp.port", "465");
        properties.setProperty("email.smtp.username", "");
        properties.setProperty("email.smtp.password", "");
        properties.setProperty("email.from.address", "");
        properties.setProperty("admin.email", "admin@example.com");
    }
    
    public static String getSmtpHost() {
        return properties.getProperty("email.smtp.host", "smtp.gmail.com");
    }
    
    public static String getSmtpPort() {
        return properties.getProperty("email.smtp.port", "465");
    }
    
    public static String getSmtpUsername() {
        return properties.getProperty("email.smtp.username", "");
    }
    
    public static String getSmtpPassword() {
        return properties.getProperty("email.smtp.password", "");
    }
    
    public static String getFromEmail() {
        return properties.getProperty("email.from.address", "");
    }
    
    public static String getAdminEmail() {
        return properties.getProperty("admin.email", "admin@example.com");
    }
}


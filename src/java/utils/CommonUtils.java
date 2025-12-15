package utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * Common Utility Class
 * Provides shared utility methods used across the application
 */
public class CommonUtils {
    
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern USN_PATTERN = Pattern.compile("^[0-9]{1}[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{3}$");
    
    /**
     * Generate a unique identifier
     * @return UUID string
     */
    public static String generateUniqueId() {
        return UUID.randomUUID().toString();
    }
    
    /**
     * Get current timestamp as formatted string
     * @return Current timestamp in yyyy-MM-dd HH:mm:ss format
     */
    public static String getCurrentTimestamp() {
        return DATE_FORMAT.format(new Date());
    }
    
    /**
     * Validate email format
     * @param email Email to validate
     * @return true if valid email format
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }
    
    /**
     * Validate USN (University Serial Number) format
     * @param usn USN to validate
     * @return true if valid USN format
     */
    public static boolean isValidUSN(String usn) {
        if (usn == null || usn.trim().isEmpty()) {
            return false;
        }
        return USN_PATTERN.matcher(usn.trim().toUpperCase()).matches();
    }
    
    /**
     * Sanitize input string to prevent XSS
     * @param input Input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        
        return input.replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("&", "&amp;");
    }
    
    /**
     * Truncate string to specified length
     * @param input Input string
     * @param maxLength Maximum length
     * @return Truncated string
     */
    public static String truncateString(String input, int maxLength) {
        if (input == null) {
            return "";
        }
        
        if (input.length() <= maxLength) {
            return input;
        }
        
        return input.substring(0, maxLength) + "...";
    }
    
    /**
     * Check if string is null or empty
     * @param str String to check
     * @return true if null or empty
     */
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Convert string to title case
     * @param input Input string
     * @return Title case string
     */
    public static String toTitleCase(String input) {
        if (isNullOrEmpty(input)) {
            return input;
        }
        
        StringBuilder result = new StringBuilder();
        boolean nextTitleCase = true;
        
        for (char c : input.toCharArray()) {
            if (Character.isSpaceChar(c)) {
                nextTitleCase = true;
            } else if (nextTitleCase) {
                c = Character.toTitleCase(c);
                nextTitleCase = false;
            } else {
                c = Character.toLowerCase(c);
            }
            result.append(c);
        }
        
        return result.toString();
    }
    
    /**
     * Format file size in human readable format
     * @param bytes File size in bytes
     * @return Formatted file size string
     */
    public static String formatFileSize(long bytes) {
        if (bytes < 1024) return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(1024));
        String pre = "KMGTPE".charAt(exp-1) + "";
        return String.format("%.1f %sB", bytes / Math.pow(1024, exp), pre);
    }
}










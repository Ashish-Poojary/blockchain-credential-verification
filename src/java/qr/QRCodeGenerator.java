package qr;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * QR Code Generator Utility Class
 * Provides methods to generate QR codes for hash keys
 */
public class QRCodeGenerator {
    
    /**
     * Generate QR code as Base64 encoded string
     * @param hashKey The hash key to encode in QR code
     * @return Base64 encoded QR code image
     */
    public static String generateQRCodeAsBase64(String hashKey) {
        try {
            // For now, we'll use a simple approach
            // In a production environment, you might want to use a library like ZXing
            return generateSimpleQRCode(hashKey);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Generate QR code data for JavaScript
     * @param hashKey The hash key to encode
     * @return Map containing QR code data
     */
    public static Map<String, Object> generateQRCodeData(String hashKey) {
        Map<String, Object> qrData = new HashMap<>();
        qrData.put("hashKey", hashKey);
        qrData.put("qrCodeUrl", "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" + 
                   java.net.URLEncoder.encode(hashKey));
        qrData.put("timestamp", System.currentTimeMillis());
        return qrData;
    }
    
    /**
     * Simple QR code generation (placeholder)
     * In production, use a proper QR code library
     */
    private static String generateSimpleQRCode(String hashKey) {
        // This is a placeholder method
        // In a real implementation, you would use a QR code library like ZXing
        return "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==";
    }
    
    /**
     * Validate hash key format
     * @param hashKey The hash key to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidHashKey(String hashKey) {
        if (hashKey == null || hashKey.trim().isEmpty()) {
            return false;
        }
        
        // Basic validation - hash should be alphanumeric and at least 32 characters
        String trimmedHash = hashKey.trim();
        return trimmedHash.matches("^[a-fA-F0-9]{32,}$");
    }
    
    /**
     * Get QR code size options
     * @return Array of available sizes
     */
    public static int[] getAvailableSizes() {
        return new int[]{100, 150, 200, 250, 300};
    }
}

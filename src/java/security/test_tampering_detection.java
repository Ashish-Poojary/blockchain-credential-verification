import java.io.*;
import java.security.MessageDigest;

/**
 * Test script to demonstrate tampering detection
 * This shows how the hash changes when a file is modified
 */
public class test_tampering_detection {
    
    public static void main(String[] args) {
        String usn = "TEST123";
        String filePath = "C:/Users/ashis/Documents/certificates/" + usn + ".jpg";
        
        System.out.println("=== TAMPERING DETECTION TEST ===");
        System.out.println("File: " + filePath);
        
        // Calculate original hash
        String originalHash = calculateFileHash(filePath);
        System.out.println("\n1. Original Hash: " + originalHash);
        
        // Simulate tampering by modifying the file
        System.out.println("\n2. Simulating file tampering...");
        simulateTampering(filePath);
        
        // Calculate hash after tampering
        String tamperedHash = calculateFileHash(filePath);
        System.out.println("3. Hash after tampering: " + tamperedHash);
        
        // Compare hashes
        System.out.println("\n4. Hash Comparison:");
        System.out.println("   Original:  " + originalHash);
        System.out.println("   Tampered:  " + tamperedHash);
        System.out.println("   Match:     " + (originalHash.equals(tamperedHash) ? "YES (No tampering)" : "NO (Tampering detected!)"));
        
        if (!originalHash.equals(tamperedHash)) {
            System.out.println("\n✅ TAMPERING DETECTED! The file has been modified.");
        } else {
            System.out.println("\n❌ No tampering detected. Files are identical.");
        }
    }
    
    private static String calculateFileHash(String filePath) {
        try {
            File file = new File(filePath);
            if (!file.exists()) {
                return "FILE_NOT_FOUND";
            }
            
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            try (FileInputStream fis = new FileInputStream(file)) {
                byte[] byteArray = new byte[1024];
                int bytesCount;
                while ((bytesCount = fis.read(byteArray)) != -1) {
                    digest.update(byteArray, 0, bytesCount);
                }
            }
            
            byte[] bytes = digest.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
            
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }
    
    private static void simulateTampering(String filePath) {
        try {
            File file = new File(filePath);
            if (!file.exists()) {
                System.out.println("   Warning: File does not exist. Creating test file...");
                // Create a simple test file
                try (FileOutputStream fos = new FileOutputStream(file)) {
                    fos.write("Original certificate content".getBytes());
                }
            }
            
            // Simulate tampering by appending a small change
            try (FileOutputStream fos = new FileOutputStream(file, true)) {
                fos.write(" - TAMPERED".getBytes());
            }
            System.out.println("   ✓ File modified successfully");
            
        } catch (Exception e) {
            System.out.println("   ✗ Error modifying file: " + e.getMessage());
        }
    }
}

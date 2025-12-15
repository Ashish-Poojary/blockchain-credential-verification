package security;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Tampering Detection Utility Class
 * Provides methods to detect file tampering using hash verification
 */
public class TamperingDetector {
    
    private static final Logger LOGGER = Logger.getLogger(TamperingDetector.class.getName());
    private static final String HASH_ALGORITHM = "SHA-256";
    
    /**
     * Calculate SHA-256 hash of a file
     * @param filePath Path to the file
     * @return SHA-256 hash as hexadecimal string
     */
    public static String calculateFileHash(String filePath) {
        try {
            File file = new File(filePath);
            if (!file.exists()) {
                LOGGER.warning("File not found: " + filePath);
                return "FILE_NOT_FOUND";
            }
            
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
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
            
        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "Hash algorithm not available: " + HASH_ALGORITHM, e);
            return "ALGORITHM_ERROR";
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading file: " + filePath, e);
            return "IO_ERROR";
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error calculating hash for: " + filePath, e);
            return "ERROR";
        }
    }
    
    /**
     * Compare two hash values to detect tampering
     * @param originalHash Original hash value
     * @param currentHash Current hash value
     * @return true if hashes match (no tampering), false if different (tampering detected)
     */
    public static boolean compareHashes(String originalHash, String currentHash) {
        if (originalHash == null || currentHash == null) {
            LOGGER.warning("Hash comparison failed: null hash values");
            return false;
        }
        
        boolean match = originalHash.equals(currentHash);
        if (!match) {
            LOGGER.warning("Tampering detected! Hash mismatch: " + originalHash + " vs " + currentHash);
        }
        return match;
    }
    
    /**
     * Detect tampering in a file by comparing with stored hash
     * @param filePath Path to the file to check
     * @param storedHash Previously stored hash value
     * @return TamperingDetectionResult containing the result
     */
    public static TamperingDetectionResult detectTampering(String filePath, String storedHash) {
        String currentHash = calculateFileHash(filePath);
        
        if ("FILE_NOT_FOUND".equals(currentHash)) {
            return new TamperingDetectionResult(false, "File not found", currentHash, storedHash);
        }
        
        if (currentHash.startsWith("ERROR")) {
            return new TamperingDetectionResult(false, "Error calculating hash", currentHash, storedHash);
        }
        
        boolean isTampered = !compareHashes(storedHash, currentHash);
        String message = isTampered ? "Tampering detected!" : "No tampering detected";
        
        return new TamperingDetectionResult(!isTampered, message, currentHash, storedHash);
    }
    
    /**
     * Validate hash format
     * @param hash Hash string to validate
     * @return true if valid SHA-256 hash format
     */
    public static boolean isValidHash(String hash) {
        if (hash == null || hash.trim().isEmpty()) {
            return false;
        }
        
        // SHA-256 hash should be 64 characters long and contain only hex digits
        return hash.trim().matches("^[a-fA-F0-9]{64}$");
    }
    
    /**
     * Result class for tampering detection
     */
    public static class TamperingDetectionResult {
        private final boolean isValid;
        private final String message;
        private final String currentHash;
        private final String storedHash;
        
        public TamperingDetectionResult(boolean isValid, String message, String currentHash, String storedHash) {
            this.isValid = isValid;
            this.message = message;
            this.currentHash = currentHash;
            this.storedHash = storedHash;
        }
        
        public boolean isValid() { return isValid; }
        public String getMessage() { return message; }
        public String getCurrentHash() { return currentHash; }
        public String getStoredHash() { return storedHash; }
        
        @Override
        public String toString() {
            return String.format("TamperingDetectionResult{isValid=%s, message='%s', currentHash='%s', storedHash='%s'}", 
                               isValid, message, currentHash, storedHash);
        }
    }
}










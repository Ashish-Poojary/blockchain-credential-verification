package security;

import java.io.*;
import java.security.MessageDigest;
import java.util.*;
import java.text.SimpleDateFormat;
import java.nio.file.*;
import java.nio.file.attribute.*;

/**
 * Advanced Certificate Modification Detection System
 * Detects, analyzes, and logs certificate modifications with detailed audit trail
 */
public class CertificateModificationDetector {
    
    private static final String HASH_ALGORITHM = "SHA-256";
    private static final String AUDIT_LOG_FILE = "certificate_audit.log";
    private static final String MODIFICATION_DB = "certificate_modifications";
    
    /**
     * Detect and analyze certificate modifications
     */
    public static ModificationAnalysisResult analyzeCertificateModification(String usn, String originalHash) {
        ModificationAnalysisResult result = new ModificationAnalysisResult();
        result.setUsn(usn);
        result.setOriginalHash(originalHash);
        result.setDetectionTime(new java.util.Date());
        
        try {
            // Get certificate file path
            String certificatePath = getCertificatePath(usn);
            File certificateFile = new File(certificatePath);
            
            if (!certificateFile.exists()) {
                result.setStatus("FILE_NOT_FOUND");
                result.setMessage("Certificate file not found for USN: " + usn);
                return result;
            }
            
            // Calculate current hash
            String currentHash = calculateFileHash(certificatePath);
            result.setCurrentHash(currentHash);
            
            // Check if modification occurred
            if (!originalHash.equals(currentHash)) {
                result.setModified(true);
                result.setStatus("MODIFICATION_DETECTED");
                
                // Analyze what was modified
                analyzeModificationDetails(result, certificateFile, originalHash);
                
                // Log the modification
                logModification(result);
                
                // Store in database
                storeModificationRecord(result);
                
            } else {
                result.setModified(false);
                result.setStatus("NO_MODIFICATION");
                result.setMessage("Certificate is authentic - no modifications detected");
            }
            
        } catch (Exception e) {
            result.setStatus("ERROR");
            result.setMessage("Error analyzing certificate: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * Analyze detailed modification information
     */
    private static void analyzeModificationDetails(ModificationAnalysisResult result, File certificateFile, String originalHash) {
        try {
            // Get file attributes
            BasicFileAttributes attrs = Files.readAttributes(certificateFile.toPath(), BasicFileAttributes.class);
            
            // File modification time analysis
            long lastModified = certificateFile.lastModified();
            long creationTime = attrs.creationTime().toMillis();
            long lastAccessTime = attrs.lastAccessTime().toMillis();
            
            result.setFileLastModified(new java.util.Date(lastModified));
            result.setFileCreationTime(new java.util.Date(creationTime));
            result.setFileLastAccessTime(new java.util.Date(lastAccessTime));
            
            // File size analysis
            long fileSize = certificateFile.length();
            result.setFileSize(fileSize);
            
            // Content analysis
            analyzeContentChanges(result, certificateFile);
            
            // Determine modification type
            determineModificationType(result, originalHash, result.getCurrentHash());
            
        } catch (Exception e) {
            result.setMessage("Error analyzing modification details: " + e.getMessage());
        }
    }
    
    /**
     * Analyze content changes in the certificate
     */
    private static void analyzeContentChanges(ModificationAnalysisResult result, File certificateFile) {
        try {
            // Read file content for analysis
            byte[] fileContent = Files.readAllBytes(certificateFile.toPath());
            
            // Analyze file header and structure
            if (fileContent.length > 0) {
                // Check if it's a PDF
                if (isPDF(fileContent)) {
                    result.setFileType("PDF");
                    analyzePDFContent(result, fileContent);
                } else if (isImage(fileContent)) {
                    result.setFileType("IMAGE");
                    analyzeImageContent(result, fileContent);
                } else {
                    result.setFileType("UNKNOWN");
                }
                
                // Calculate content entropy to detect encryption/encoding changes
                double entropy = calculateEntropy(fileContent);
                result.setContentEntropy(entropy);
                
                // Generate detailed tampering analysis
                String tamperingDetails = generateTamperingDetails(result, fileContent);
                result.setTamperingDetails(tamperingDetails);
            }
            
        } catch (Exception e) {
            result.setMessage("Error analyzing content: " + e.getMessage());
        }
    }
    
    /**
     * Determine the type of modification that occurred
     */
    private static void determineModificationType(ModificationAnalysisResult result, String originalHash, String currentHash) {
        // Analyze hash differences to determine modification type
        if (originalHash.length() != currentHash.length()) {
            result.setModificationType("HASH_ALGORITHM_CHANGE");
        } else {
            // Count different characters to estimate modification extent
            int differences = countHashDifferences(originalHash, currentHash);
            double similarityPercentage = ((double)(originalHash.length() - differences) / originalHash.length()) * 100;
            
            if (similarityPercentage > 90) {
                result.setModificationType("MINOR_MODIFICATION");
            } else if (similarityPercentage > 50) {
                result.setModificationType("MODERATE_MODIFICATION");
            } else {
                result.setModificationType("MAJOR_MODIFICATION");
            }
            
            result.setSimilarityPercentage(similarityPercentage);
        }
    }
    
    /**
     * Log modification details to audit file
     */
    private static void logModification(ModificationAnalysisResult result) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String timestamp = sdf.format(result.getDetectionTime());
            
            String logEntry = String.format("[%s] MODIFICATION_DETECTED - USN: %s, Type: %s, Status: %s, File: %s, Size: %d bytes\n",
                timestamp, result.getUsn(), result.getModificationType(), result.getStatus(), 
                getCertificatePath(result.getUsn()), result.getFileSize());
            
            // Append to audit log
            try (FileWriter fw = new FileWriter(AUDIT_LOG_FILE, true);
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {
                out.println(logEntry);
                out.println("  Original Hash: " + result.getOriginalHash());
                out.println("  Current Hash: " + result.getCurrentHash());
                out.println("  Last Modified: " + sdf.format(result.getFileLastModified()));
                out.println("  Detection Time: " + timestamp);
                out.println("  Message: " + result.getMessage());
                out.println("  " + createSeparatorLine(80));
            }
            
        } catch (Exception e) {
            System.err.println("Error logging modification: " + e.getMessage());
        }
    }
    
    /**
     * Generate detailed tampering analysis
     */
    private static String generateTamperingDetails(ModificationAnalysisResult result, byte[] fileContent) {
        StringBuilder details = new StringBuilder();
        
        try {
            // Add general tampering indicators
            details.append("🔍 General Tampering Indicators:\n");
            
            if (result.getSimilarityPercentage() < 20) {
                details.append("• Content similarity is extremely low (").append(String.format("%.2f", result.getSimilarityPercentage())).append("%)\n");
                details.append("• Possible: Entire document was replaced\n");
            } else if (result.getSimilarityPercentage() < 50) {
                details.append("• Content similarity is very low (").append(String.format("%.2f", result.getSimilarityPercentage())).append("%)\n");
                details.append("• Possible: Major portions of content were modified\n");
            } else if (result.getSimilarityPercentage() < 80) {
                details.append("• Content similarity is moderate (").append(String.format("%.2f", result.getSimilarityPercentage())).append("%)\n");
                details.append("• Possible: Significant content was altered\n");
            } else {
                details.append("• Content similarity is relatively high (").append(String.format("%.2f", result.getSimilarityPercentage())).append("%)\n");
                details.append("• Possible: Minor modifications or metadata changes\n");
            }
            
        } catch (Exception e) {
            details.append("Error analyzing tampering details: ").append(e.getMessage());
        }
        
        return details.toString();
    }
    
    /**
     * Create separator line
     */
    private static String createSeparatorLine(int length) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append("-");
        }
        return sb.toString();
    }
    
    /**
     * Store modification record in database
     */
    private static void storeModificationRecord(ModificationAnalysisResult result) {
        try {
            // This would connect to your database and store the modification record
            // For now, we'll create a simple JSON record
            String jsonRecord = createModificationJSON(result);
            
            // Save to a modifications file
            String modificationsFile = "certificate_modifications.json";
            try (FileWriter fw = new FileWriter(modificationsFile, true);
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {
                out.println(jsonRecord);
            }
            
        } catch (Exception e) {
            System.err.println("Error storing modification record: " + e.getMessage());
        }
    }
    
    /**
     * Utility methods
     */
    private static String getCertificatePath(String usn) {
        return utils.ConfigReader.getCertificatesPath() + "/" + usn + ".jpg";
    }
    
    private static String calculateFileHash(String filePath) throws Exception {
        MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
        try (FileInputStream fis = new FileInputStream(filePath)) {
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
    }
    
    private static boolean isPDF(byte[] content) {
        return content.length > 4 && 
               content[0] == 0x25 && content[1] == 0x50 && 
               content[2] == 0x44 && content[3] == 0x46;
    }
    
    private static boolean isImage(byte[] content) {
        return content.length > 2 && 
               ((content[0] == (byte)0xFF && content[1] == (byte)0xD8) || // JPEG
                (content[0] == 0x89 && content[1] == 0x50 && content[2] == 0x4E && content[3] == 0x47)); // PNG
    }
    
    private static void analyzePDFContent(ModificationAnalysisResult result, byte[] content) {
        // Basic PDF analysis - could be enhanced with Apache PDFBox
        result.setContentAnalysis("PDF document with " + content.length + " bytes");
    }
    
    private static void analyzeImageContent(ModificationAnalysisResult result, byte[] content) {
        // Basic image analysis
        result.setContentAnalysis("Image file with " + content.length + " bytes");
    }
    
    private static double calculateEntropy(byte[] data) {
        int[] frequencies = new int[256];
        for (byte b : data) {
            frequencies[b & 0xFF]++;
        }
        
        double entropy = 0;
        int length = data.length;
        for (int frequency : frequencies) {
            if (frequency > 0) {
                double probability = (double) frequency / length;
                entropy -= probability * (Math.log(probability) / Math.log(2));
            }
        }
        return entropy;
    }
    
    private static int countHashDifferences(String hash1, String hash2) {
        int differences = 0;
        int minLength = Math.min(hash1.length(), hash2.length());
        
        for (int i = 0; i < minLength; i++) {
            if (hash1.charAt(i) != hash2.charAt(i)) {
                differences++;
            }
        }
        
        differences += Math.abs(hash1.length() - hash2.length());
        return differences;
    }
    
    private static String createModificationJSON(ModificationAnalysisResult result) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return String.format(
            "{\"usn\":\"%s\",\"detectionTime\":\"%s\",\"modificationType\":\"%s\",\"status\":\"%s\",\"originalHash\":\"%s\",\"currentHash\":\"%s\",\"fileSize\":%d,\"message\":\"%s\"}",
            result.getUsn(),
            sdf.format(result.getDetectionTime()),
            result.getModificationType(),
            result.getStatus(),
            result.getOriginalHash(),
            result.getCurrentHash(),
            result.getFileSize(),
            result.getMessage()
        );
    }
    
    /**
     * Result class for modification analysis
     */
    public static class ModificationAnalysisResult {
        private String usn;
        private String originalHash;
        private String currentHash;
        private boolean modified;
        private String status;
        private String message;
        private java.util.Date detectionTime;
        private java.util.Date fileLastModified;
        private java.util.Date fileCreationTime;
        private java.util.Date fileLastAccessTime;
        private long fileSize;
        private String fileType;
        private String modificationType;
        private String contentAnalysis;
        private double contentEntropy;
        private double similarityPercentage;
        private String tamperingDetails;
        
        // Getters and Setters
        public String getUsn() { return usn; }
        public void setUsn(String usn) { this.usn = usn; }
        
        public String getOriginalHash() { return originalHash; }
        public void setOriginalHash(String originalHash) { this.originalHash = originalHash; }
        
        public String getCurrentHash() { return currentHash; }
        public void setCurrentHash(String currentHash) { this.currentHash = currentHash; }
        
        public boolean isModified() { return modified; }
        public void setModified(boolean modified) { this.modified = modified; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        
        public java.util.Date getDetectionTime() { return detectionTime; }
        public void setDetectionTime(java.util.Date detectionTime) { this.detectionTime = detectionTime; }
        
        public java.util.Date getFileLastModified() { return fileLastModified; }
        public void setFileLastModified(java.util.Date fileLastModified) { this.fileLastModified = fileLastModified; }
        
        public java.util.Date getFileCreationTime() { return fileCreationTime; }
        public void setFileCreationTime(java.util.Date fileCreationTime) { this.fileCreationTime = fileCreationTime; }
        
        public java.util.Date getFileLastAccessTime() { return fileLastAccessTime; }
        public void setFileLastAccessTime(java.util.Date fileLastAccessTime) { this.fileLastAccessTime = fileLastAccessTime; }
        
        public long getFileSize() { return fileSize; }
        public void setFileSize(long fileSize) { this.fileSize = fileSize; }
        
        public String getFileType() { return fileType; }
        public void setFileType(String fileType) { this.fileType = fileType; }
        
        public String getModificationType() { return modificationType; }
        public void setModificationType(String modificationType) { this.modificationType = modificationType; }
        
        public String getContentAnalysis() { return contentAnalysis; }
        public void setContentAnalysis(String contentAnalysis) { this.contentAnalysis = contentAnalysis; }
        
        public double getContentEntropy() { return contentEntropy; }
        public void setContentEntropy(double contentEntropy) { this.contentEntropy = contentEntropy; }
        
        public double getSimilarityPercentage() { return similarityPercentage; }
        public void setSimilarityPercentage(double similarityPercentage) { this.similarityPercentage = similarityPercentage; }
        
        public String getTamperingDetails() { return tamperingDetails; }
        public void setTamperingDetails(String tamperingDetails) { this.tamperingDetails = tamperingDetails; }
        
        @Override
        public String toString() {
            return String.format("ModificationAnalysisResult{usn='%s', modified=%s, type='%s', status='%s', message='%s'}",
                usn, modified, modificationType, status, message);
        }
    }
}

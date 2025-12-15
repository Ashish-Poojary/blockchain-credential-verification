package security;

/**
 * Test class for Certificate Modification Detection System
 * Demonstrates how to use the modification detector
 */
public class TestModificationDetection {
    
    public static void main(String[] args) {
        System.out.println("=== Certificate Modification Detection Test ===\n");
        
        // Test with a sample USN and hash
        String testUsn = "1BI23MC098";
        String originalHash = "b425b36b57ec36a26f607b89941f68a41a41e6c92b371ba15759280976cc255d";
        
        System.out.println("Testing modification detection for USN: " + testUsn);
        System.out.println("Original Hash: " + originalHash);
        System.out.println();
        
        try {
            // Analyze the certificate
            CertificateModificationDetector.ModificationAnalysisResult result = 
                CertificateModificationDetector.analyzeCertificateModification(testUsn, originalHash);
            
            // Display results
            System.out.println("=== Analysis Results ===");
            System.out.println("USN: " + result.getUsn());
            System.out.println("Modified: " + result.isModified());
            System.out.println("Status: " + result.getStatus());
            System.out.println("Message: " + result.getMessage());
            System.out.println("Detection Time: " + result.getDetectionTime());
            
            if (result.isModified()) {
                System.out.println("Modification Type: " + result.getModificationType());
                System.out.println("File Size: " + result.getFileSize() + " bytes");
                System.out.println("File Type: " + result.getFileType());
                System.out.println("Similarity Percentage: " + result.getSimilarityPercentage() + "%");
                
                if (result.getFileLastModified() != null) {
                    System.out.println("File Last Modified: " + result.getFileLastModified());
                }
                if (result.getContentAnalysis() != null) {
                    System.out.println("Content Analysis: " + result.getContentAnalysis());
                }
                if (result.getContentEntropy() > 0) {
                    System.out.println("Content Entropy: " + result.getContentEntropy());
                }
            }
            
            System.out.println("\n=== Test Complete ===");
            
        } catch (Exception e) {
            System.err.println("Error during testing: " + e.getMessage());
            e.printStackTrace();
        }
    }
}








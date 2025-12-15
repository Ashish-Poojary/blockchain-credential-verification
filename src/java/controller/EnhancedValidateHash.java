package controller;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import security.CertificateModificationDetector;
import security.CertificateModificationDetector.ModificationAnalysisResult;

/**
 * Enhanced Certificate Validation Servlet
 * Provides detailed modification analysis and tampering detection
 */
@WebServlet(name = "EnhancedValidateHash", urlPatterns = {"/enhancedvalidatehash"})
public class EnhancedValidateHash extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            String usn = request.getParameter("usn");
            String userEnteredHash = request.getParameter("hash");
            
            if (usn == null || userEnteredHash == null || usn.trim().isEmpty() || userEnteredHash.trim().isEmpty()) {
                response.sendRedirect("downloadcertificate.jsp?msg=INVALID_INPUT");
                return;
            }
            
            // Validate the user-entered hash format
            if (!isValidHashFormat(userEnteredHash)) {
                response.sendRedirect("downloadcertificate.jsp?msg=INVALID_HASH_FORMAT");
                return;
            }
            
            // First, get the stored hash from blockchain
            String storedHash = getStoredHashFromBlockchain(usn);
            
            if (storedHash.equals("NOTFOUND")) {
                response.sendRedirect("downloadcertificate.jsp?msg=STUDENTNOTFOUND");
                return;
            }
            
            // First, validate that user entered the correct hash
            if (!userEnteredHash.equals(storedHash)) {
                // User entered wrong hash - show error
                System.out.println("Student Validation - User entered WRONG HASH");
                response.sendRedirect("downloadcertificate.jsp?msg=INVALID_HASH");
                return;
            }
            
            // User entered correct hash, now check if file has been tampered
            System.out.println("Student Validation - USN: " + usn);
            System.out.println("Student Validation - User Entered Hash: " + userEnteredHash);
            System.out.println("Student Validation - Stored Hash: " + storedHash);
            System.out.println("Student Validation - Hash Validation: PASSED");
            
            // Calculate current hash of the file to check for tampering
            String currentFileHash = calculateCurrentFileHash(usn);
            
            if (currentFileHash.equals("FILENOTFOUND")) {
                response.sendRedirect("downloadcertificate.jsp?msg=FILENOTFOUND");
                return;
            }
            
            System.out.println("Student Validation - Current File Hash: " + currentFileHash);
            System.out.println("Student Validation - File Tampered: " + !currentFileHash.equals(storedHash));
            
            // Use the enhanced modification detector
            ModificationAnalysisResult analysis = CertificateModificationDetector.analyzeCertificateModification(usn, storedHash);
            
            // Store analysis results in session for display
            HttpSession session = request.getSession();
            session.setAttribute("modificationAnalysis", analysis);
            
            // Redirect to results page based on file tampering check
            if (currentFileHash.equals(storedHash)) {
                response.sendRedirect("certificateresults.jsp?status=authentic&usn=" + usn);
            } else {
                response.sendRedirect("certificateresults.jsp?status=tampered&usn=" + usn);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("downloadcertificate.jsp?msg=ERROR");
        }
    }
    
    private String getStoredHashFromBlockchain(String usn) {
        try {
            Socket soc = new Socket("localhost", 3000);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());
            
            oos.writeObject("GETMYHASH");
            oos.writeObject(usn);
            
            String reply = (String) oin.readObject();
            
            oos.close();
            oin.close();
            soc.close();
            
            // Parse the reply to get just the hash (remove timestamp)
            if (reply.contains("$")) {
                return reply.split("\\$")[0];
            }
            return reply;
            
        } catch (Exception e) {
            e.printStackTrace();
            return "NOTFOUND";
        }
    }
    
    private boolean isValidHashFormat(String hash) {
        if (hash == null || hash.trim().isEmpty()) {
            return false;
        }
        
        // SHA-256 hash should be 64 characters long and contain only hex digits
        String trimmedHash = hash.trim();
        return trimmedHash.matches("^[a-fA-F0-9]{64}$");
    }
    
    private String calculateCurrentFileHash(String usn) {
        try {
            String filePath = utils.ConfigReader.getCertificatesPath() + "/" + usn + ".jpg";
            File file = new File(filePath);
            
            if (!file.exists()) {
                return "FILENOTFOUND";
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Enhanced Certificate Validation with Modification Analysis";
    }
}

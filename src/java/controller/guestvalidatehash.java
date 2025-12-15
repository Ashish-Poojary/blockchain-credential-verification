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

@WebServlet(name = "guestvalidatehash", urlPatterns = {"/guestvalidatehash"})
public class guestvalidatehash extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String usn = request.getParameter("usn");
            String userEnteredHash = request.getParameter("hash");
            HttpSession session = request.getSession();

            // Validate input
            if (usn == null || userEnteredHash == null || usn.trim().isEmpty() || userEnteredHash.trim().isEmpty()) {
                response.sendRedirect("guestresults.jsp?status=error");
                return;
            }

            // First, get the stored hash from blockchain
            String storedHash = getStoredHashFromBlockchain(usn);
            
            if (storedHash.equals("NOTFOUND")) {
                response.sendRedirect("guestresults.jsp?status=notfound&usn=" + usn);
                return;
            }
            
            // Validate the user-entered hash format
            if (!isValidHashFormat(userEnteredHash)) {
                response.sendRedirect("guestresults.jsp?status=error");
                return;
            }
            
            // First, validate that user entered the correct hash
            if (!userEnteredHash.equals(storedHash)) {
                // User entered wrong hash - show error
                System.out.println("Guest Validation - User entered WRONG HASH");
                response.sendRedirect("guestresults.jsp?status=error&usn=" + usn);
                return;
            }
            
            // User entered correct hash, now check if file has been tampered
            System.out.println("Guest Validation - USN: " + usn);
            System.out.println("Guest Validation - User Entered Hash: " + userEnteredHash);
            System.out.println("Guest Validation - Stored Hash: " + storedHash);
            System.out.println("Guest Validation - Hash Validation: PASSED");
            
            // Calculate current hash of the file to check for tampering
            String currentFileHash = calculateCurrentFileHash(usn);
            
            if (currentFileHash.equals("FILENOTFOUND")) {
                response.sendRedirect("guestresults.jsp?status=filenotfound&usn=" + usn);
                return;
            }
            
            System.out.println("Guest Validation - Current File Hash: " + currentFileHash);
            System.out.println("Guest Validation - File Tampered: " + !currentFileHash.equals(storedHash));
            
            if (currentFileHash.equals(storedHash)) {
                // File hash matches stored hash - certificate is authentic
                System.out.println("Guest Validation - Certificate is AUTHENTIC");
                response.sendRedirect("guestresults.jsp?status=authentic&usn=" + usn);
            } else {
                // File hash doesn't match stored hash - certificate has been tampered
                System.out.println("Guest Validation - Certificate is TAMPERED");
                ModificationAnalysisResult analysisResult = CertificateModificationDetector.analyzeCertificateModification(usn, storedHash);
                session.setAttribute("modificationAnalysis", analysisResult);
                response.sendRedirect("guestresults.jsp?status=tampered&usn=" + usn);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("guestresults.jsp?status=error");
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
            
            // Parse the reply to extract just the hash (before the $ symbol)
            if (reply != null && !reply.equals("NOTFOUND") && reply.contains("$")) {
                String[] parts = reply.split("\\$");
                if (parts.length > 0) {
                    return parts[0]; // Return only the hash part
                }
            }
            
            return reply; // Return as is if no $ found or other cases
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
}

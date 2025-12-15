/*
 * Hash Validation Servlet
 * Handles certificate hash validation and tampering detection
 */
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

/**
 *
 * @author user
 */
@WebServlet(name = "validatehash", urlPatterns = {"/validatehash"})
public class validatehash extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Process hash validation
           
            HttpSession s=request.getSession();
            String usn=request.getParameter("usn");
            String hash=request.getParameter("hash");
            
            // First, get the stored hash from blockchain
            String storedHash = getStoredHashFromBlockchain(usn);
            
            if (storedHash.equals("NOTFOUND")) {
                response.sendRedirect("downloadcertificate.jsp?msg=STUDENTNOTFOUND");
                return;
            }
            
            // Calculate current hash of the file
            String currentHash = calculateCurrentFileHash(usn);
            
            if (currentHash.equals("FILENOTFOUND")) {
                response.sendRedirect("downloadcertificate.jsp?msg=FILENOTFOUND");
                return;
            }
            
            // Compare current hash with stored hash
            if (currentHash.equals(storedHash)) {
                response.sendRedirect("downloadcertificate.jsp?msg=HASHVALIDATED");
            } else {
                response.sendRedirect("downloadcertificate.jsp?msg=TAMPERED");
            }
            
        }
        catch(Exception e)
        {
            System.out.println(e);
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
            
            return reply;
        } catch (Exception e) {
            e.printStackTrace();
            return "NOTFOUND";
        }
    }
    
    private String calculateCurrentFileHash(String usn) {
        try {
            String filePath = "C:/Users/ashis/Documents/certificates/" + usn + ".jpg";
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

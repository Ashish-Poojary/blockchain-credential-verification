package controller;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.security.MessageDigest;

@WebServlet(name = "uploadcertificate", urlPatterns = {"/uploadcertificate"})
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class uploadcertificate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            String usn = request.getParameter("usn");
            Part filePart = request.getPart("t3");
            HttpSession session = request.getSession();

            if (filePart == null || filePart.getSubmittedFileName() == null || !filePart.getSubmittedFileName().endsWith(".pdf")) {
                response.sendRedirect("uploadcertificate.jsp?msg=INVALID_FORMAT");
                return;
            }

            String filename = filePart.getSubmittedFileName();
            String filenameWithoutExt = filename.substring(0, filename.lastIndexOf('.'));

            if (!filenameWithoutExt.equalsIgnoreCase(usn)) {
                response.sendRedirect("uploadcertificate.jsp?msg=FILENAME_MISMATCH");
                return;
            }

            // Save PDF locally
            File dir = new File(utils.ConfigReader.getCertificatesPath());
            if (!dir.exists()) dir.mkdirs();

            String pdfPath = dir.getPath() + "/" + usn + ".pdf";
            InputStream inputStream = filePart.getInputStream();
            File pdfFile = new File(pdfPath);
            try (FileOutputStream fos = new FileOutputStream(pdfFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // Convert PDF to JPG
            PDDocument document = PDDocument.load(pdfFile);
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            BufferedImage bim = pdfRenderer.renderImageWithDPI(0, 300);
            document.close();

            String imagePath = dir.getPath() + "/" + usn + ".jpg";
            File imageFile = new File(imagePath);
            ImageIO.write(bim, "jpg", imageFile);

            // ===== FTP Upload DISABLED =====
            /*
            MyFTPClient1 ftp = new MyFTPClient1();
            if (!ftp.status) {
                response.sendRedirect("uploadcertificate.jsp?msg=CLOUDLOGINERROR");
                return;
            }
            ftp.ftpChangeDirectory("/My Documents");
            ftp.ftpUpload(imageFile.getPath(), imageFile.getName(), ".");
            ftp.ftpDisconnect();
            */

            // SHA-256 Hash
            MessageDigest mdigest = MessageDigest.getInstance("SHA-256");
            String checksum = generateChecksum(mdigest, imageFile);

            // Store in session
            session.setAttribute("usn", usn);
            session.setAttribute("fpath", imageFile.getPath());
            session.setAttribute("hash", checksum);

            // Redirect to final success page to show hash
            response.sendRedirect("uploadsuccess.jsp?msg=SUCCESS");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("uploadcertificate.jsp?msg=ERROR");
        }
    }

    private static String generateChecksum(MessageDigest digest, File file) throws IOException {
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
        return "Certificate Upload Servlet with Validation, PDF-to-JPG Conversion, and Hashing (No Cloud Upload)";
    }
}

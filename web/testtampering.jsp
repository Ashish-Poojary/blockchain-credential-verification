<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.Socket"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="utils.ConfigReader"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Tampering Detection Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-result { padding: 10px; margin: 10px 0; border-radius: 5px; }
        .success { background-color: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .error { background-color: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .info { background-color: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }
        .warning { background-color: #fff3cd; border: 1px solid #ffeaa7; color: #856404; }
    </style>
</head>
<body>
    <h1>🔍 Tampering Detection Test</h1>
    
    <form method="post">
        <label for="usn">Enter USN to test:</label>
        <input type="text" id="usn" name="usn" placeholder="e.g., 1MS20CS001" required />
        <input type="submit" value="Test Tampering Detection" />
    </form>
    
    <%
    String usn = request.getParameter("usn");
    if (usn != null && !usn.trim().isEmpty()) {
        try {
            // Get stored hash from blockchain
            Socket soc = new Socket("localhost", 3000);
            soc.setSoTimeout(5000);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());
            
            oos.writeObject("GETMYHASH");
            oos.writeObject(usn);
            String hashReply = (String) oin.readObject();
            
            oos.close();
            oin.close();
            soc.close();
            
            if (hashReply.equals("NOTFOUND")) {
    %>
                <div class="test-result error">
                    <h3>❌ Student Not Found</h3>
                    <p>The USN "<%= usn %>" was not found in the blockchain.</p>
                </div>
    <%
            } else {
                // Parse stored hash
                String storedHash = hashReply;
                if (hashReply.contains("$")) {
                    storedHash = hashReply.split("\\$")[0];
                }
                
                // Calculate current file hash
                String currentHash = "FILENOTFOUND";
                String filePath = ConfigReader.getCertificatesPath() + "/" + usn + ".jpg";
                File file = new File(filePath);
                
                if (file.exists()) {
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
                    currentHash = sb.toString();
                }
    %>
                <div class="test-result info">
                    <h3>Test Results for USN: <%= usn %></h3>
                    <p><strong>Stored Hash (Blockchain):</strong> <%= storedHash %></p>
                    <p><strong>Current File Hash:</strong> <%= currentHash %></p>
                    <p><strong>File Exists:</strong> <%= file.exists() ? "Yes" : "No" %></p>
                </div>
                
                <%
                if (currentHash.equals("FILENOTFOUND")) {
                %>
                    <div class="test-result error">
                        <h3>❌ File Not Found</h3>
                        <p>Certificate file not found at: <%= filePath %></p>
                    </div>
                <%
                } else if (currentHash.equals(storedHash)) {
                %>
                    <div class="test-result success">
                        <h3>✅ Certificate Authentic</h3>
                        <p>The certificate file has not been tampered with.</p>
                        <p><strong>Status:</strong> File hash matches stored hash</p>
                    </div>
                <%
                } else {
                %>
                    <div class="test-result warning">
                        <h3>⚠️ Certificate Tampered</h3>
                        <p>The certificate file has been modified since it was uploaded to the blockchain.</p>
                        <p><strong>Status:</strong> File hash does NOT match stored hash</p>
                        <p><strong>Difference:</strong> <%= Math.abs(currentHash.length() - storedHash.length()) %> characters different</p>
                    </div>
                <%
                }
                %>
    <%
            }
        } catch (java.net.ConnectException e) {
    %>
            <div class="test-result error">
                <h3>❌ Connection Error</h3>
                <p>Cannot connect to blockchain server on localhost:3000</p>
                <p>Make sure the blockchain server is running.</p>
            </div>
    <%
        } catch (Exception e) {
    %>
            <div class="test-result error">
                <h3>❌ Error</h3>
                <p>Error: <%= e.getMessage() %></p>
            </div>
    <%
        }
    }
    %>
    
    <div class="test-result info">
        <h3>📋 How Tampering Detection Works</h3>
        <p>1. <strong>Stored Hash:</strong> Retrieved from blockchain (original upload)</p>
        <p>2. <strong>Current Hash:</strong> Calculated from current file on disk</p>
        <p>3. <strong>Comparison:</strong> If hashes match = authentic, if different = tampered</p>
        <p>4. <strong>User Hash Validation:</strong> User must enter correct hash to proceed</p>
    </div>
</body>
</html>

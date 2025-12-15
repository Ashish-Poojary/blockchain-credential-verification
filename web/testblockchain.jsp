<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>Blockchain Server Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .status { padding: 10px; margin: 10px 0; border-radius: 5px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <h2>Blockchain Server Connection Test</h2>
    
    <%
    try {
        java.net.Socket soc = new java.net.Socket("localhost", 3000);
        java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(soc.getOutputStream());
        java.io.ObjectInputStream oin = new java.io.ObjectInputStream(soc.getInputStream());
        
        // Test basic connection
        out.println("<div class='status success'>✅ Blockchain server is running on port 3000</div>");
        
        // Test GETTIMESTAMP request
        oos.writeObject("GETTIMESTAMP");
        oos.writeObject("TEST123");
        
        String reply = (String) oin.readObject();
        out.println("<div class='status success'>✅ GETTIMESTAMP handler is working. Reply: " + reply + "</div>");
        
        oos.close();
        oin.close();
        soc.close();
        
    } catch (java.net.ConnectException e) {
        out.println("<div class='status error'>❌ Blockchain server is NOT running on port 3000</div>");
        out.println("<div class='status error'>Please start the blockchain server application</div>");
    } catch (Exception e) {
        out.println("<div class='status error'>❌ Error: " + e.getMessage() + "</div>");
    }
    %>
    
    <h3>Instructions:</h3>
    <ol>
        <li>Make sure the blockchain server application is running</li>
        <li>The server should be listening on port 3000</li>
        <li>Check that the server has the GETTIMESTAMP handler</li>
        <li>Try the certificate verification again</li>
    </ol>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Timestamp Fix</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .success { background-color: #d4edda; border-color: #c3e6cb; }
        .error { background-color: #f8d7da; border-color: #f5c6cb; }
        .info { background-color: #d1ecf1; border-color: #bee5eb; }
    </style>
</head>
<body>
    <h1>🔧 Test Timestamp Fix</h1>
    
    <div class="test-section info">
        <h3>Testing Blockchain Server Connection</h3>
        <p>This page tests the timestamp fixes for the blockchain system.</p>
    </div>
    
    <%
    try {
        // Test 1: Connect to blockchain server
        java.net.Socket soc = new java.net.Socket("localhost", 3000);
        soc.setSoTimeout(5000);
        java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(soc.getOutputStream());
        java.io.ObjectInputStream oin = new java.io.ObjectInputStream(soc.getInputStream());
        
        // Test 2: Get all hashes to see timestamps
        oos.writeObject("GETALLHASH");
        String reply = (String) oin.readObject();
        
        if ("SUCCESS".equals(reply)) {
            java.util.Vector v = (java.util.Vector) oin.readObject();
    %>
            <div class="test-section success">
                <h3>✅ Blockchain Server Connection Successful</h3>
                <p>Found <%= v.size() %> blocks in the blockchain.</p>
                
                <h4>Block Details:</h4>
                <table border="1" style="border-collapse: collapse; width: 100%;">
                    <tr style="background-color: #f8f9fa;">
                        <th style="padding: 8px;">USN</th>
                        <th style="padding: 8px;">Hash</th>
                        <th style="padding: 8px;">Upload Date</th>
                    </tr>
                    <%
                    for (int i = 0; i < v.size(); i++) {
                        String data = (String) v.get(i);
                        String[] parts = data.split("\\$");
                        if (parts.length >= 3) {
                            String usn = parts[0];
                            String hash = parts[1];
                            String uploadDate = parts[2];
                    %>
                        <tr>
                            <td style="padding: 8px;"><%= usn %></td>
                            <td style="padding: 8px; font-family: monospace; font-size: 12px;"><%= hash.substring(0, 16) %>...</td>
                            <td style="padding: 8px;"><%= uploadDate %></td>
                        </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
            
            <div class="test-section info">
                <h3>📝 Test Results Analysis</h3>
                <%
                boolean hasValidTimestamps = true;
                for (int i = 0; i < v.size(); i++) {
                    String data = (String) v.get(i);
                    String[] parts = data.split("\\$");
                    if (parts.length >= 3) {
                        String uploadDate = parts[2];
                        if (uploadDate.contains("1970-01-01") || uploadDate.contains("05:30:00")) {
                            hasValidTimestamps = false;
                            break;
                        }
                    }
                }
                
                if (hasValidTimestamps) {
                %>
                    <p style="color: green;">✅ All timestamps appear to be valid (not showing 1970-01-01)</p>
                <% } else { %>
                    <p style="color: orange;">⚠️ Some timestamps may still be showing 1970-01-01 (old blocks)</p>
                    <p>This is expected for existing blocks. New blocks will have correct timestamps.</p>
                <% } %>
            </div>
    <%
        } else {
    %>
            <div class="test-section error">
                <h3>❌ Blockchain Server Error</h3>
                <p>Server replied: <%= reply %></p>
            </div>
    <%
        }
        
        oos.close();
        oin.close();
        soc.close();
        
    } catch (java.net.ConnectException e) {
    %>
        <div class="test-section error">
            <h3>❌ Connection Failed</h3>
            <p>Could not connect to blockchain server on port 3000.</p>
            <p>Make sure the blockchain server is running.</p>
        </div>
    <% } catch (Exception e) { %>
        <div class="test-section error">
            <h3>❌ Error Occurred</h3>
            <p>Error: <%= e.getMessage() %></p>
            <p>Stack trace: <%= e.toString() %></p>
        </div>
    <% } %>
    
    <div class="test-section info">
        <h3>🔧 What Was Fixed</h3>
        <ol>
            <li><strong>Content Tampering Analysis:</strong> Removed the detailed analysis section that showed file size, entropy, etc.</li>
            <li><strong>Timestamp Loading:</strong> Fixed the readJSON.java to properly load timestamps from userlogs.json</li>
            <li><strong>Block Class:</strong> Added setTimestamp() method for better timestamp management</li>
        </ol>
        
        <h4>Expected Results:</h4>
        <ul>
            <li>New blocks will have correct timestamps when created</li>
            <li>Existing blocks loaded from JSON will use current time as fallback</li>
            <li>Content tampering analysis will only show "General Tampering Indicators"</li>
        </ul>
    </div>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="index.jsp" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">🏠 Back to Home</a>
    </div>
</body>
</html>

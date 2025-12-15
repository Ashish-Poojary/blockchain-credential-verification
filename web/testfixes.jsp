<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Fixes</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .success { background-color: #d4edda; border-color: #c3e6cb; }
        .error { background-color: #f8d7da; border-color: #f5c6cb; }
        .info { background-color: #d1ecf1; border-color: #bee5eb; }
    </style>
</head>
<body>
    <h1>Test Fixes Applied</h1>
    
    <div class="test-section info">
        <h3>Testing Applied Fixes</h3>
        <p>This page tests the two fixes that were applied:</p>
        <ol>
            <li><strong>Removed "What Content Got Tampered" section</strong></li>
            <li><strong>Fixed upload time to show actual upload time instead of server start time</strong></li>
        </ol>
    </div>
    
    <%
    try {
        // Test blockchain server connection
        java.net.Socket soc = new java.net.Socket("localhost", 3000);
        soc.setSoTimeout(5000);
        java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(soc.getOutputStream());
        java.io.ObjectInputStream oin = new java.io.ObjectInputStream(soc.getInputStream());
        
        // Test GETALLHASH to see timestamps
        oos.writeObject("GETALLHASH");
        String reply = (String) oin.readObject();
        
        if ("SUCCESS".equals(reply)) {
            java.util.Vector v = (java.util.Vector) oin.readObject();
    %>
            <div class="test-section success">
                <h3>Blockchain Server Connection Successful</h3>
                <p>Found <%= v.size() %> blocks in the blockchain.</p>
                
                <h4>Block Details:</h4>
                <table border="1" style="border-collapse: collapse; width: 100%;">
                    <tr style="background-color: #f8f9fa;">
                        <th style="padding: 8px;">USN</th>
                        <th style="padding: 8px;">Hash</th>
                        <th style="padding: 8px;">Upload Date</th>
                        <th style="padding: 8px;">Status</th>
                    </tr>
                    <%
                    for (int i = 0; i < v.size(); i++) {
                        String data = (String) v.get(i);
                        String[] parts = data.split("\\$");
                        if (parts.length >= 3) {
                            String usn = parts[0];
                            String hash = parts[1];
                            String uploadDate = parts[2];
                            String status = "";
                            
                            if (uploadDate.contains("Timestamp not available")) {
                                status = "Old block (pre-timestamp feature)";
                            } else if (uploadDate.contains("1970-01-01")) {
                                status = "Still showing 1970-01-01 (needs restart)";
                            } else {
                                status = "Valid timestamp";
                            }
                    %>
                        <tr>
                            <td style="padding: 8px;"><%= usn %></td>
                            <td style="padding: 8px; font-family: monospace; font-size: 12px;"><%= hash.substring(0, 16) %>...</td>
                            <td style="padding: 8px;"><%= uploadDate %></td>
                            <td style="padding: 8px;"><%= status %></td>
                        </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
            
            <div class="test-section info">
                <h3>📝 Fix Status Analysis</h3>
                <%
                int oldBlocks = 0;
                int validBlocks = 0;
                int invalidBlocks = 0;
                
                for (int i = 0; i < v.size(); i++) {
                    String data = (String) v.get(i);
                    String[] parts = data.split("\\$");
                    if (parts.length >= 3) {
                        String uploadDate = parts[2];
                        if (uploadDate.contains("Timestamp not available")) {
                            oldBlocks++;
                        } else if (uploadDate.contains("1970-01-01")) {
                            invalidBlocks++;
                        } else {
                            validBlocks++;
                        }
                    }
                }
                %>
                
                <h4>Block Status Summary:</h4>
                <ul>
                    <li><strong>Valid Timestamps:</strong> <%= validBlocks %> blocks</li>
                    <li><strong>Old Blocks (pre-timestamp):</strong> <%= oldBlocks %> blocks</li>
                    <li><strong>Invalid Timestamps (1970-01-01):</strong> <%= invalidBlocks %> blocks</li>
                </ul>
                
                <% if (invalidBlocks > 0) { %>
                    <div style="background-color: #fff3cd; padding: 10px; border-radius: 5px; margin: 10px 0;">
                        <strong>Note:</strong> Blocks showing 1970-01-01 need the blockchain server to be restarted to load the updated code.
                    </div>
                <% } %>
                
                <% if (oldBlocks > 0) { %>
                    <div style="background-color: #d1ecf1; padding: 10px; border-radius: 5px; margin: 10px 0;">
                        <strong>Note:</strong> Old blocks will show "Upload time not available" which is correct behavior for blocks created before the timestamp feature.
                    </div>
                <% } %>
            </div>
    <%
        } else {
    %>
            <div class="test-section error">
                <h3>Blockchain Server Error</h3>
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
            <h3>Connection Failed</h3>
            <p>Could not connect to blockchain server on port 3000.</p>
            <p>Make sure the blockchain server is running.</p>
        </div>
    <% } catch (Exception e) { %>
        <div class="test-section error">
            <h3>Error Occurred</h3>
            <p>Error: <%= e.getMessage() %></p>
        </div>
    <% } %>
    
    <div class="test-section info">
        <h3>What Was Fixed</h3>
        
        <h4>Fix 1: Removed "What Content Got Tampered" Section</h4>
        <ul>
            <li>Removed the detailed content tampering analysis from JSP files</li>
            <li>No more file size, entropy, or detailed technical indicators</li>
            <li>Cleaner, more focused tampering detection results</li>
        </ul>
        
        <h4>Fix 2: Fixed Upload Time Display</h4>
        <ul>
            <li>Modified `readJSON.java` to not set current time for old blocks</li>
            <li>Updated `Block.java` to show "Timestamp not available" for old blocks</li>
            <li>Updated all JSP files to handle timestamp display properly</li>
            <li>New blocks will show actual upload time</li>
            <li>Old blocks will show "Upload time not available (pre-timestamp feature)"</li>
        </ul>
        
        <h4>Expected Results:</h4>
        <ul>
            <li><strong>New certificates:</strong> Will show actual upload time</li>
            <li><strong>Old certificates:</strong> Will show "Upload time not available" instead of 1970-01-01</li>
            <li><strong>Tampering analysis:</strong> Will be cleaner without detailed content analysis</li>
        </ul>
    </div>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="index.jsp" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">Back to Home</a>
    </div>
</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.Socket"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Timestamp Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-result { padding: 10px; margin: 10px 0; border-radius: 5px; }
        .success { background-color: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .error { background-color: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .info { background-color: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }
    </style>
</head>
<body>
    <h1>🔧 Blockchain Timestamp Test</h1>
    
    <form method="post">
        <label for="usn">Enter USN to test:</label>
        <input type="text" id="usn" name="usn" placeholder="e.g., 1MS20CS001" required />
        <input type="submit" value="Test Timestamp" />
    </form>
    
    <%
    String usn = request.getParameter("usn");
    if (usn != null && !usn.trim().isEmpty()) {
        try {
            Socket soc = new Socket("localhost", 3000);
            soc.setSoTimeout(5000);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());
            
            // Test GETMYHASH to get hash with timestamp
            oos.writeObject("GETMYHASH");
            oos.writeObject(usn);
            String hashReply = (String) oin.readObject();
            
            // Test GETTIMESTAMP to get just the timestamp
            oos.writeObject("GETTIMESTAMP");
            oos.writeObject(usn);
            String timestampReply = (String) oin.readObject();
            
            oos.close();
            oin.close();
            soc.close();
    %>
            <div class="test-result info">
                <h3>Test Results for USN: <%= usn %></h3>
                <p><strong>GETMYHASH Response:</strong> <%= hashReply %></p>
                <p><strong>GETTIMESTAMP Response:</strong> <%= timestampReply %></p>
            </div>
            
            <%
            if (hashReply.equals("NOTFOUND")) {
            %>
                <div class="test-result error">
                    <h3>❌ Student Not Found</h3>
                    <p>The USN "<%= usn %>" was not found in the blockchain.</p>
                </div>
            <%
            } else if (timestampReply.equals("NOTFOUND")) {
            %>
                <div class="test-result error">
                    <h3>❌ Timestamp Not Found</h3>
                    <p>Hash found but timestamp is missing for USN "<%= usn %>".</p>
                </div>
            <%
            } else if (timestampReply.contains("1970-01-01")) {
            %>
                <div class="test-result error">
                    <h3>❌ Timestamp Issue Detected</h3>
                    <p>The timestamp shows epoch time (1970-01-01), indicating the timestamp field is 0.</p>
                    <p><strong>Timestamp:</strong> <%= timestampReply %></p>
                </div>
            <%
            } else {
            %>
                <div class="test-result success">
                    <h3>✅ Timestamp Working Correctly</h3>
                    <p>The timestamp is properly set and formatted.</p>
                    <p><strong>Upload Time:</strong> <%= timestampReply %></p>
                </div>
            <%
            }
            %>
    <%
        } catch (java.net.ConnectException e) {
    %>
            <div class="test-result error">
                <h3>❌ Connection Error</h3>
                <p>Cannot connect to blockchain server on localhost:3000</p>
                <p>Make sure the blockchain server is running.</p>
            </div>
    <%
        } catch (java.net.SocketTimeoutException e) {
    %>
            <div class="test-result error">
                <h3>❌ Timeout Error</h3>
                <p>Blockchain server connection timed out.</p>
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
        <h3>📋 Instructions</h3>
        <p>1. Make sure the blockchain server is running</p>
        <p>2. Enter a valid USN that exists in the blockchain</p>
        <p>3. Click "Test Timestamp" to check if timestamps are working correctly</p>
        <p>4. If you see "1970-01-01", there's a timestamp issue</p>
        <p>5. If you see a proper date/time, timestamps are working</p>
    </div>
</body>
</html>










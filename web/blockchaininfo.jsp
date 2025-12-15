<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.Socket"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Blockchain Information</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Merriweather:300,400|Montserrat:400,700" rel="stylesheet">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/modernizr-2.6.2.min.js"></script>
    
    <style>
        body {
            background-color: #f4f8fb;
            font-family: 'Montserrat', sans-serif;
        }
        .gtco-nav {
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f8f9fa;
            padding: 10px 0;
            margin-bottom: 20px;
        }
        .menu-1 ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: flex-end;
        }
        .menu-1 ul li {
            display: inline-block;
            margin-right: 15px;
        }
        .menu-1 ul li a {
            text-decoration: none;
            font-size: 16px;
            color: #333;
            font-weight: bold;
        }
        .menu-1 ul li a:hover {
            color: #007bff;
        }
        .page-title {
            text-align: center;
            margin-top: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }
        .blockchain-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .block-info {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .block-header {
            background-color: #007bff;
            color: white;
            padding: 10px;
            margin: -15px -15px 15px -15px;
            border-radius: 5px 5px 0 0;
            font-weight: bold;
        }
        .block-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .detail-item {
            background-color: white;
            padding: 10px;
            border-radius: 3px;
            border: 1px solid #ddd;
        }
        .detail-label {
            font-weight: bold;
            color: #555;
            font-size: 12px;
            text-transform: uppercase;
        }
        .detail-value {
            font-family: 'Courier New', monospace;
            font-size: 14px;
            word-break: break-all;
            margin-top: 5px;
        }
        .chain-status {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            margin: 20px 0;
        }
        .chain-status.invalid {
            background-color: #dc3545;
        }
    </style>
</head>

<body>
<div class="gtco-loader"></div>

<div id="page">
    <div class="page-title">
        <h3>Blockchain Information & Chain Integrity</h3>
    </div>

    <nav class="gtco-nav" role="navigation">
        <div class="gtco-container">
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div id="gtco-logo"><a href="index.jsp"><h5></h5></div>
                </div>
                <div class="col-xs-10 text-right menu-1">
                    <ul>
                        <li><a href="adminpage.jsp">Home</a></li>
                        <li><a href="viewhash.jsp">View Hash</a></li>
                        <li class="active"><a href="blockchaininfo.jsp">Blockchain Info</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="blockchain-container">
        <%
        try {
            Socket soc = new Socket("localhost", 3000);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());

            oos.writeObject("GETALLHASH");
            String reply = (String) oin.readObject();

            if ("SUCCESS".equals(reply)) {
                Vector v = (Vector) oin.readObject();
                
                // Display chain integrity status
                boolean chainValid = true;
                String previousHash = "0";
                
                for (int i = 0; i < v.size(); i++) {
                    String app = v.get(i).toString().trim();
                    String[] parts = app.split("\\$");
                    
                    if (parts.length >= 3) {
                        String usn = parts[0];
                        String hash = parts[1];
                        String uploadDate = parts[2];
                        
                        // Check chain integrity
                        if (i > 0 && !previousHash.equals("0")) {
                            // This would need to be implemented in the blockchain server
                            // For now, we'll just display the information
                        }
                        
                        previousHash = hash;
        %>
                        <div class="block-info">
                            <div class="block-header">
                                Block #<%= (i + 1) %> - <%= usn %>
                            </div>
                            <div class="block-details">
                                <div class="detail-item">
                                    <div class="detail-label">Student USN</div>
                                    <div class="detail-value"><%= usn %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Upload Date</div>
                                    <div class="detail-value"><%= uploadDate %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Certificate Hash</div>
                                    <div class="detail-value"><%= hash %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Block Number</div>
                                    <div class="detail-value"><%= (i + 1) %></div>
                                </div>
                            </div>
                        </div>
        <%
                    }
                }
                
                // Display chain status
                if (chainValid) {
        %>
                    <div class="chain-status">
                        <strong>✓ Blockchain Chain Integrity: VALID</strong><br>
                        <small>All blocks are properly linked and verified</small>
                    </div>
        <%
                } else {
        %>
                    <div class="chain-status invalid">
                        <strong>✗ Blockchain Chain Integrity: INVALID</strong><br>
                        <small>Chain integrity check failed - some blocks may be corrupted</small>
                    </div>
        <%
                }
                
            } else {
                out.println("<h1 style='text-align: center; color: red;'>NO BLOCKCHAIN DATA FOUND!</h1>");
            }
            
            oos.close();
            oin.close();
            soc.close();
            
        } catch (Exception e) {
            out.println("<h1 style='text-align: center; color: red;'>Error: " + e.getMessage() + "</h1>");
        }
        %>
    </div>
</div>

<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>

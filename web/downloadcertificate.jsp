<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dbconnection.Dbconnection"%>
<%@page import ="java.sql.*"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import="ftp.MyFTPClient1"%>
<%@page import="utils.ConfigReader"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Student Portal</title>
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
            background-color: #f0f2f5; /* Light gray background */
            font-family: 'Montserrat', sans-serif;
            color: #555;
        }
        .navbar {
            border-bottom: 2px solid #fff;
        }
        .gtco-nav {
            border: 1px solid #e0e0e0; /* Subtle border */
            border-radius: 5px;
            background-color: #ffffff; /* White background for nav */
            padding: 10px 0;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .menu-1 {
            display: flex;
            justify-content: flex-end;
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
            transition: color 0.3s;
        }
        .menu-1 ul li a:hover {
            color: #007bff; /* Primary accent blue */
        }
        .page-title {
            text-align: center;
            margin-top: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }
        .form-container {
            background-color: #f9f9f9; /* Light gray card background */
            margin: 40px auto;
            padding: 30px;
            width: 50%;
            max-width: 600px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="email"]:focus, textarea:focus {
            outline: none;
            border-color: #007bff;
        }
        
        .analysis-details {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            margin: 15px 0;
            border: 1px solid #ddd;
        }
        
        .analysis-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .detail-box {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #e9ecef;
        }
        
        .detail-label {
            font-weight: bold;
            color: #495057;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        
        .detail-value {
            font-family: 'Courier New', monospace;
            font-size: 14px;
            color: #333;
            word-break: break-all;
        }
        
        .when-tampered {
            background-color: #fff3cd;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
            border: 1px solid #ffeaa7;
        }
        
        .content-similarity {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }
        
        .similarity-bar {
            background-color: #dee2e6;
            border-radius: 10px;
            height: 20px;
            margin: 10px 0;
            overflow: hidden;
        }
        
        .similarity-fill {
            height: 100%;
            background: linear-gradient(90deg, #dc3545, #ffc107, #28a745);
            transition: width 0.3s ease;
        }
        
        .what-means {
            background-color: #d1ecf1;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
            border: 1px solid #bee5eb;
        }
        
        .action-buttons {
            text-align: center;
            margin-top: 20px;
        }
        
        .btn-print {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            margin: 0 10px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .btn-analyze {
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 5px;
            margin: 0 10px;
            display: inline-block;
            font-weight: bold;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .download-link {
            display: inline-block;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            margin-top: 15px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .download-link:hover {
            background-color: #218838;
            color: white;
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="gtco-loader"></div>
<div id="page">
    <div class="page-title">
        <h3>BlockChain Based Academic Credential Verification System</h3>
    </div>

    <nav class="gtco-nav" role="navigation">
        <div class="gtco-container">
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div id="gtco-logo"><a href="index.html"><h5></h5></div>
                </div>
                <div class="col-xs-10 text-right menu-1">
                    <ul>
                        <li><a href="studentpage.jsp">Home</a></li>
                        <li class="active"><a href="downloadcertificate.jsp">Download Certificate</a></li>
                        <li><a href="studentviewhash.jsp">View Hash</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <%
    String studentUsn = (String) session.getAttribute("usn");
    if (studentUsn != null) {
        out.println("<p style='text-align: center; color: #007bff; font-weight: bold; margin-top: 20px;'>Welcome Student " + studentUsn + "</p>");
    } else {
        out.println("<p style='text-align: center; color: #dc3545; font-weight: bold; margin-top: 20px;'>Session expired. Please log in again.</p>");
    }

    try {
        if (studentUsn != null) {
            Connection con = Dbconnection.getConnection();  
            PreparedStatement pst = con.prepareStatement("select * from student where usn=?");
            pst.setString(1, studentUsn);
            ResultSet rs = pst.executeQuery();
            rs.next();
            // Data retrieved but not used in this specific view.
        }
    %>

    <div class="form-container">
        <div class="form-title">Check Certificate Authenticity</div>
        <p style="text-align: center; color: #666; margin-bottom: 20px;">
            Enter the hash value to verify if your certificate is authentic or has been modified.
        </p>
        <form name="checkcertificate" action="enhancedvalidatehash" method="post">
            <input type="hidden" name="usn" value="<%= (studentUsn != null ? studentUsn : "") %>" />
            <div class="form-group">
                <label>Enter Hash Value:</label>
                <input type="text" name="hash" required placeholder="Enter the certificate hash to verify" />
            </div>
            <div class="form-group">
                <input type="submit" value="🔍 Check Certificate Authenticity" style="background-color: #007bff; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; font-weight: bold;" />
            </div>
        </form>
    </div>

    <!-- Report Issue: Invalid Certificate Form -->
    <div class="form-container">
        <div class="form-title">Report Issue: Invalid Certificate</div>
        <p style="text-align: center; color: #666; margin-bottom: 20px;">
            If you believe your certificate has been tampered with or there's an issue, please report it.
        </p>
        <form name="reportissue" action="sendIssueMail" method="post">
            <input type="hidden" name="usn" value="<%= (studentUsn != null ? studentUsn : "") %>" />
            <div class="form-group">
                <label>Your Email:</label>
                <input type="email" name="email" required placeholder="Enter your email address" />
            </div>
            <div class="form-group">
                <label>Subject:</label>
                <input type="text" name="subject" required placeholder="Enter subject for the issue" />
            </div>
            <div class="form-group">
                <label>Message:</label>
                <textarea name="message" rows="5" required placeholder="Describe the issue with your certificate..."></textarea>
            </div>
            <div class="form-group">
                <input type="submit" value="📧 Send Issue Report" style="background-color: #dc3545; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; font-weight: bold;" />
            </div>
        </form>
    </div>

    <%
        if (request.getParameter("msg") != null) {
            String message = request.getParameter("msg");
            if ("HASHVALIDATED".equals(message)) {
                out.println("<script>alert('Hash validated Successfully!');</script>");
                String file = studentUsn + ".jpg";
                String fpath1 = ConfigReader.getCertificatesPath().replace("/", "\\") + "\\" + file;
    %>
        <div class="form-container" style="text-align: center;">
            <div class="form-title">Certificate Preview</div>
            <img src="view.jsp?id=<%=fpath1%>" alt="Certificate Preview" style="width: 200px; height: 200px; margin-top:20px;"/>
            <br><br>
            <a href="view.jsp?id=<%=fpath1%>" download class="download-link">Click to Download Certificate</a>
        </div>
    <%
            } else {
                String alertMessage;
                if ("TAMPERED".equals(message)) {
                    alertMessage = "Certificate has been tampered! The file has been modified since it was uploaded.";
                } else if ("INVALID_HASH".equals(message)) {
                    alertMessage = "Invalid hash entered! The hash value does not match the stored hash. Please check and try again.";
                } else if ("STUDENTNOTFOUND".equals(message)) {
                    alertMessage = "Student not found in blockchain!";
                } else if ("FILENOTFOUND".equals(message)) {
                    alertMessage = "Certificate file not found!";
                } else {
                    alertMessage = "An error occurred during validation!";
                }
                out.println("<script>alert('" + alertMessage + "');</script>");
            }
        }
    } catch(Exception e) {
        out.println("<div class='form-container'><div style='color: red; text-align: center;'>An error occurred: " + e.getMessage() + "</div></div>");
        e.printStackTrace();
    }
    %>

    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="security.CertificateModificationDetector.ModificationAnalysisResult"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Certificate Modification Analysis</title>
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
        .modification-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .analysis-section {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 20px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .section-title {
            background-color: #dc3545;
            color: white;
            padding: 10px;
            margin: -20px -20px 20px -20px;
            border-radius: 5px 5px 0 0;
            font-weight: bold;
            font-size: 18px;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .detail-item {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .detail-label {
            font-weight: bold;
            color: #555;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        .detail-value {
            font-family: 'Courier New', monospace;
            font-size: 14px;
            word-break: break-all;
            color: #333;
        }
        .hash-comparison {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .hash-item {
            margin: 10px 0;
            padding: 10px;
            background-color: white;
            border-radius: 3px;
        }
        .similarity-bar {
            background-color: #e9ecef;
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
        .action-buttons {
            text-align: center;
            margin: 30px 0;
        }
        .btn {
            padding: 12px 24px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
    </style>
</head>

<body>
<div class="gtco-loader"></div>

<div id="page">
    <div class="page-title">
        <h3>Certificate Modification Analysis Report</h3>
    </div>

    <nav class="gtco-nav" role="navigation">
        <div class="gtco-container">
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div id="gtco-logo"><a href="index.jsp"><h5></h5></div>
                </div>
                <div class="col-xs-10 text-right menu-1">
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="downloadcertificate.jsp">Validate Certificate</a></li>
                        <li class="active"><a href="modificationdetails.jsp">Modification Details</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="modification-container">
        <%
        ModificationAnalysisResult analysis = (ModificationAnalysisResult) session.getAttribute("modificationAnalysis");
        if (analysis != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        %>
            <!-- Alert Section -->
            <div class="alert-danger">
                <strong>⚠️ MODIFICATION DETECTED!</strong><br>
                Certificate for USN: <strong><%= analysis.getUsn() %></strong> has been modified.
                This certificate is no longer authentic and should not be trusted.
            </div>

            <!-- Basic Information -->
            <div class="analysis-section">
                <div class="section-title">📋 Basic Information</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">Student USN</div>
                        <div class="detail-value"><%= analysis.getUsn() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Detection Time</div>
                        <div class="detail-value"><%= sdf.format(analysis.getDetectionTime()) %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Modification Type</div>
                        <div class="detail-value"><%= analysis.getModificationType() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">File Type</div>
                        <div class="detail-value"><%= analysis.getFileType() != null ? analysis.getFileType() : "Unknown" %></div>
                    </div>
                </div>
            </div>

            <!-- Hash Comparison -->
            <div class="analysis-section">
                <div class="section-title">🔍 Hash Analysis</div>
                <div class="hash-comparison">
                    <div class="hash-item">
                        <div class="detail-label">Original Hash (Blockchain)</div>
                        <div class="detail-value"><%= analysis.getOriginalHash() %></div>
                    </div>
                    <div class="hash-item">
                        <div class="detail-label">Current Hash (File)</div>
                        <div class="detail-value"><%= analysis.getCurrentHash() %></div>
                    </div>
                    <% if (analysis.getSimilarityPercentage() > 0) { %>
                    <div class="hash-item">
                        <div class="detail-label">Similarity Percentage</div>
                        <div class="detail-value">
                            <%= String.format("%.2f", analysis.getSimilarityPercentage()) %>%
                            <div class="similarity-bar">
                                <div class="similarity-fill" style="width: <%= analysis.getSimilarityPercentage() %>%"></div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- File Analysis -->
            <div class="analysis-section">
                <div class="section-title">📁 File Analysis</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">File Size</div>
                        <div class="detail-value"><%= analysis.getFileSize() %> bytes</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">File Last Modified</div>
                        <div class="detail-value"><%= sdf.format(analysis.getFileLastModified()) %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">File Creation Time</div>
                        <div class="detail-value"><%= sdf.format(analysis.getFileCreationTime()) %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">File Last Access</div>
                        <div class="detail-value"><%= sdf.format(analysis.getFileLastAccessTime()) %></div>
                    </div>
                </div>
            </div>

            <!-- Content Analysis -->
            <% if (analysis.getContentAnalysis() != null || analysis.getContentEntropy() > 0) { %>
            <div class="analysis-section">
                <div class="section-title">🔬 Content Analysis</div>
                <div class="detail-grid">
                    <% if (analysis.getContentAnalysis() != null) { %>
                    <div class="detail-item">
                        <div class="detail-label">Content Analysis</div>
                        <div class="detail-value"><%= analysis.getContentAnalysis() %></div>
                    </div>
                    <% } %>
                    <% if (analysis.getContentEntropy() > 0) { %>
                    <div class="detail-item">
                        <div class="detail-label">Content Entropy</div>
                        <div class="detail-value"><%= String.format("%.2f", analysis.getContentEntropy()) %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <!-- Status and Message -->
            <div class="analysis-section">
                <div class="section-title">📊 Analysis Results</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">Status</div>
                        <div class="detail-value"><%= analysis.getStatus() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Message</div>
                        <div class="detail-value"><%= analysis.getMessage() %></div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="downloadcertificate.jsp" class="btn btn-primary">Validate Another Certificate</a>
                <a href="index.jsp" class="btn btn-warning">Back to Home</a>
                <a href="#" onclick="window.print()" class="btn btn-danger">Print Report</a>
            </div>

        <% } else { %>
            <div class="alert-danger">
                <strong>❌ No Analysis Data Available</strong><br>
                Please validate a certificate first to see modification analysis.
            </div>
            <div class="action-buttons">
                <a href="downloadcertificate.jsp" class="btn btn-primary">Validate Certificate</a>
                <a href="index.jsp" class="btn btn-warning">Back to Home</a>
            </div>
        <% } %>
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

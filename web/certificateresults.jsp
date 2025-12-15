<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="security.CertificateModificationDetector.ModificationAnalysisResult"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Certificate Verification Results</title>
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
        .results-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        /* Authentic Certificate Styles */
        .authentic-alert {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }
        .authentic-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #155724;
        }
        .certificate-preview {
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
            border: 2px solid #28a745;
        }
        .preview-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #28a745;
        }
        .certificate-image {
            max-width: 300px;
            max-height: 300px;
            border: 3px solid #28a745;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .download-link {
            display: inline-block;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 5px;
            margin-top: 20px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .download-link:hover {
            background-color: #218838;
            color: white;
            text-decoration: none;
        }
        
        /* Tampering Alert Styles */
        .tampering-alert {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .tampering-title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
            color: #721c24;
        }
        .tampering-message {
            text-align: center;
            font-weight: bold;
            margin: 20px 0;
            font-size: 18px;
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
        .btn-back {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 5px;
            margin: 0 10px;
            display: inline-block;
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
    </style>
</head>

<body>
<div class="gtco-loader"></div>

<div id="page">
    <div class="page-title">
        <h3>Certificate Verification Results</h3>
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
                        <li><a href="downloadcertificate.jsp">Check Certificate</a></li>
                        <li class="active"><a href="certificateresults.jsp">Results</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="results-container">
        <%
        String status = request.getParameter("status");
        String usn = request.getParameter("usn");
        
        if ("authentic".equals(status)) {
            // Show authentic certificate
        %>
            <div class="authentic-alert">
                <div class="authentic-title">CERTIFICATE AUTHENTIC</div>
                <p style="font-size: 18px; margin: 0;">
                    Your certificate is genuine and has not been modified since upload.
                </p>
            </div>
            
            <div class="certificate-preview">
                <div class="preview-title">Certificate Preview</div>
                <%
                if (usn != null) {
                    String file = usn + ".jpg";
                    String fpath1 = "C:\\Users\\ashis\\Documents\\certificates\\" + file;
                %>
                    <img src="view.jsp?id=<%=fpath1%>" alt="Certificate Preview" class="certificate-image"/>
                    <br><br>
                    <a href="view.jsp?id=<%=fpath1%>" download class="download-link">
                        Download Certificate
                    </a>
                <%
                }
                %>
            </div>
            
            <div class="action-buttons">
                <a href="downloadcertificate.jsp" class="btn-analyze">Check Another Certificate</a>
                <a href="index.jsp" class="btn-back">Back to Home</a>
            </div>
            
        <% } else if ("tampered".equals(status)) {
            // Show tampering analysis
            Object analysisObj = session.getAttribute("modificationAnalysis");
            if (analysisObj != null) {
                try {
                    // Use reflection to access the analysis object
                    java.lang.reflect.Method getModifiedMethod = analysisObj.getClass().getMethod("isModified");
                    java.lang.reflect.Method getUsnMethod = analysisObj.getClass().getMethod("getUsn");
                    java.lang.reflect.Method getStatusMethod = analysisObj.getClass().getMethod("getStatus");
                    java.lang.reflect.Method getMessageMethod = analysisObj.getClass().getMethod("getMessage");
                    java.lang.reflect.Method getFileLastModifiedMethod = analysisObj.getClass().getMethod("getFileLastModified");
                    java.lang.reflect.Method getSimilarityPercentageMethod = analysisObj.getClass().getMethod("getSimilarityPercentage");
                    java.lang.reflect.Method getTamperingDetailsMethod = analysisObj.getClass().getMethod("getTamperingDetails");
                    
                    boolean isModified = (Boolean) getModifiedMethod.invoke(analysisObj);
                    String analysisUsn = (String) getUsnMethod.invoke(analysisObj);
                    String analysisStatus = (String) getStatusMethod.invoke(analysisObj);
                    String msg = (String) getMessageMethod.invoke(analysisObj);
                    
                    if (isModified) {
                        java.util.Date fileLastModified = (java.util.Date) getFileLastModifiedMethod.invoke(analysisObj);
                        Double similarityPercentage = (Double) getSimilarityPercentageMethod.invoke(analysisObj);
                        String tamperingDetails = (String) getTamperingDetailsMethod.invoke(analysisObj);
                        
                        // Get upload time from blockchain
                        String uploadTime = "Unknown";
                        try {
                            java.net.Socket soc = new java.net.Socket("localhost", 3000);
                            soc.setSoTimeout(5000); // 5 second timeout
                            java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(soc.getOutputStream());
                            java.io.ObjectInputStream oin = new java.io.ObjectInputStream(soc.getInputStream());
                            
                            oos.writeObject("GETTIMESTAMP");
                            oos.writeObject(analysisUsn);
                            
                            String reply = (String) oin.readObject();
                            if (!"NOTFOUND".equals(reply)) {
                                if (reply.contains("Timestamp not available")) {
                                    uploadTime = "Upload time not available (certificate uploaded before timestamp feature)";
                                } else {
                                    uploadTime = reply;
                                }
                            } else {
                                uploadTime = "Upload time not found in blockchain";
                            }
                            
                            oos.close();
                            oin.close();
                            soc.close();
                        } catch (java.net.ConnectException e) {
                            uploadTime = "Blockchain server not running (Port 3000)";
                        } catch (java.net.SocketTimeoutException e) {
                            uploadTime = "Blockchain server timeout";
                        } catch (Exception e) {
                            uploadTime = "Error: " + e.getMessage();
                        }
                        
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        %>
                        <div class="tampering-alert">
                            <div class="tampering-title">CERTIFICATE TAMPERING DETECTED</div>
                            <p class="tampering-message">
                                Certificate has been tampered! The file has been modified since it was uploaded.
                            </p>
                            
                            <div class="analysis-details">
                                <h4 style="color: #dc3545; margin-bottom: 15px;">Tampering Analysis Details</h4>
                                
                                <div class="analysis-grid">
                                    <div class="detail-box">
                                        <div class="detail-label">Student USN</div>
                                        <div class="detail-value"><%= analysisUsn %></div>
                                    </div>
                                    <div class="detail-box">
                                        <div class="detail-label">Upload Time</div>
                                        <div class="detail-value"><%= uploadTime %></div>
                                    </div>
                                </div>
                                
                                                                <% if (fileLastModified != null) { %>
                                <div class="when-tampered">
                                    <strong>When It Was Tampered:</strong><br>
                                    <span style="font-family: monospace; color: #856404;">
                                        File was last modified on: <%= sdf.format(fileLastModified) %>
                                    </span>
                                </div>
                                <% } %>
                                
                                
                                
                                <div class="what-means">
                                    <strong>What This Means:</strong><br>
                                    <span style="color: #0c5460;">
                                        This certificate has been altered after it was originally uploaded to the blockchain. 
                                        The current file hash does not match the stored hash, indicating tampering or modification.
                                        This certificate should not be trusted for official purposes.
                                    </span>
                                </div>
                            </div>
                            
                            <div class="action-buttons">
                                <button onclick="window.print()" class="btn-print">
                                    Print Report
                                </button>
                                <a href="downloadcertificate.jsp" class="btn-analyze">
                                    Check Another Certificate
                                </a>
                                <a href="index.jsp" class="btn-back">
                                    Back to Home
                                </a>
                            </div>
                        </div>
        <%
                    }
                } catch (Exception e) {
        %>
                    <div class="tampering-alert">
                        <div class="tampering-title">Error in Analysis</div>
                        <p>An error occurred while analyzing the certificate: <%= e.getMessage() %></p>
                        <div class="action-buttons">
                            <a href="downloadcertificate.jsp" class="btn-analyze">Try Again</a>
                            <a href="index.jsp" class="btn-back">Back to Home</a>
                        </div>
                    </div>
        <%
                }
            }
        } else {
            // No status parameter
        %>
            <div class="tampering-alert">
                <div class="tampering-title">No Results Available</div>
                <p>Please check a certificate first to see the verification results.</p>
                <div class="action-buttons">
                    <a href="downloadcertificate.jsp" class="btn-analyze">Check Certificate</a>
                    <a href="index.jsp" class="btn-back">Back to Home</a>
                </div>
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

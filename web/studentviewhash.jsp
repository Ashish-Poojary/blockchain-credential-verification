<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Certificate Issue</title>
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
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<style>
		body {
			background-color: #f4f8fb;
			font-family: 'Montserrat', sans-serif;
		}
		.navbar {
			border-bottom: 2px solid #fff;
		}
		.gtco-nav {
			border: 1px solid #ccc;
			border-radius: 5px;
			background-color: #f8f9fa;
			padding: 10px 0;
			margin-bottom: 20px;
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
		
		.hash-container {
			max-width: 900px;
			margin: 20px auto;
			padding: 20px;
			background-color: #ffffff;
			border: 1px solid #ddd;
			border-radius: 5px;
		}
		
		.hash-display {
			background-color: #f8f9fa;
			border: 1px solid #ddd;
			padding: 15px;
			margin: 15px 0;
			font-family: 'Courier New', monospace;
			font-size: 14px;
			word-break: break-all;
			overflow-x: auto;
			white-space: nowrap;
		}
		
		.qr-section {
			margin: 20px 0;
			padding: 15px;
			background-color: #f8f9fa;
			border: 1px solid #ddd;
			border-radius: 5px;
		}
		
		.qr-code-container {
			display: block;
			padding: 10px;
			background-color: white;
			border: 1px solid #ddd;
			margin: 10px auto;
			text-align: center;
			width: fit-content;
		}
		
		#qrcode {
			display: inline-block;
			text-align: center;
		}
		
		#qrcode canvas {
			display: block;
			margin: 0 auto;
		}
		
		.download-btn {
			background-color: #007bff;
			color: white;
			border: none;
			padding: 8px 16px;
			border-radius: 4px;
			font-size: 14px;
			cursor: pointer;
			margin: 5px;
		}
		
		.download-btn:hover {
			background-color: #0056b3;
		}
		
		.loading {
			display: none;
			color: #007bff;
			font-style: italic;
		}
	</style>
</head>

<%@page import="java.sql.*"%>
<%@page import="dbconnection.Dbconnection,java.net.*,java.io.*,java.util.*"%>

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
					<div id="gtco-logo"><a href="index.html"><h5></h5></a></div>
				</div>
				<div class="col-xs-10 text-right menu-1">
					<ul>
						<li><a href="studentpage.jsp">Home</a></li>
						<li><a href="downloadcertificate.jsp">Download Certificate</a></li>
						<li class="active"><a href="studentviewhash.jsp">View Hash</a></li>
						<li><a href="logout.jsp">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>

	<div class="hash-container">
		<h2 style="text-align: center; margin-bottom: 20px;">VIEW HASH</h2>
		
		<%
		String hashValue = "";
		String uploadDate = "";
		try {
			Socket soc = new Socket("localhost", 3000);
			System.out.println("socket connected");
			ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
			ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());
			System.out.println("streams created");

			oos.writeObject("GETMYHASH");
			oos.writeObject(session.getAttribute("usn"));

			String reply = (String) oin.readObject();
			
			if (reply.equals("NOTFOUND")) {
				out.println("<h1 style='text-align: center; color: red;'>NO DETAILS FOUND IN BLOCKCHAIN!</h1>");
			} else {
				// Parse the reply to separate hash and date
				String[] parts = reply.split("\\$");
				if (parts.length >= 2) {
					hashValue = parts[0];
					uploadDate = parts[1];
					
					// Handle timestamp display
					if (uploadDate.contains("Timestamp not available")) {
						uploadDate = "Upload time not available (pre-timestamp feature)";
					}
				} else {
					hashValue = reply; // Fallback for old format
				}
				
				out.println("<div class='hash-display'>");
				out.println("<strong>Your Hash:</strong> " + hashValue);
				out.println("<br><br><strong>Upload Date:</strong> " + uploadDate);
				out.println("<span id='hashValue' style='display: none;'>" + hashValue + "</span>");
				out.println("</div>");
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		%>
		
		<% if (!hashValue.equals("NOTFOUND") && !hashValue.isEmpty()) { %>
		<div class="qr-section">
			<h3 style="text-align: center; margin-bottom: 15px;">QR Code</h3>
			
			<div class="qr-code-container">
				<div id="qrcode"></div>
			</div>
			
			<div style="text-align: center; margin-top: 15px;">
				<button class="download-btn" onclick="downloadQRCode()">
					Download QR Code
				</button>
			</div>
			
			<div class="loading" id="loading">Generating QR Code...</div>
		</div>
		<% } %>
	</div>
</div>

<div class="gototop js-top">
	<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>

<!-- QR Code Library -->
<script src="https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js"></script>
<!-- Fallback QR Code Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

<script src="js/jquery.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

<script>
// Generate QR Code when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded, checking for hash value...');
    const hashValue = document.getElementById('hashValue');
    if (hashValue) {
        const hash = hashValue.textContent.trim();
        console.log('Hash found:', hash);
        if (hash && hash !== 'NOTFOUND') {
            // Wait a bit for QRCode library to load
            setTimeout(function() {
                generateQRCode(hash);
            }, 500);
        }
    } else {
        console.log('Hash value element not found');
    }
});

function generateQRCode(hash) {
    console.log('Generating QR code for hash:', hash);
    const qrcodeDiv = document.getElementById('qrcode');
    const loadingDiv = document.getElementById('loading');
    
    if (!qrcodeDiv) {
        console.error('QR code div not found');
        return;
    }
    
    if (loadingDiv) loadingDiv.style.display = 'block';
    
    // Clear previous QR code
    qrcodeDiv.innerHTML = '';
    
    // Try multiple QR code generation methods
    tryMethod1(hash, qrcodeDiv, loadingDiv);
}

function tryMethod1(hash, qrcodeDiv, loadingDiv) {
    // Method 1: Using QRCode.toCanvas
    if (typeof QRCode !== 'undefined' && QRCode.toCanvas) {
        console.log('Trying QRCode.toCanvas method...');
        QRCode.toCanvas(qrcodeDiv, hash, {
            width: 200,
            height: 200,
            margin: 2,
            color: {
                dark: '#000000',
                light: '#FFFFFF'
            }
        }, function(error) {
            if (error) {
                console.error('Method 1 failed:', error);
                tryMethod2(hash, qrcodeDiv, loadingDiv);
            } else {
                console.log('QR code generated successfully with method 1');
                if (loadingDiv) loadingDiv.style.display = 'none';
            }
        });
    } else {
        console.log('QRCode.toCanvas not available, trying method 2');
        tryMethod2(hash, qrcodeDiv, loadingDiv);
    }
}

function tryMethod2(hash, qrcodeDiv, loadingDiv) {
    // Method 2: Using QRCode constructor
    if (typeof QRCode !== 'undefined') {
        console.log('Trying QRCode constructor method...');
        try {
            const qr = new QRCode(qrcodeDiv, {
                text: hash,
                width: 200,
                height: 200,
                colorDark: '#000000',
                colorLight: '#FFFFFF',
                correctLevel: QRCode.CorrectLevel.H
            });
            console.log('QR code generated successfully with method 2');
            if (loadingDiv) loadingDiv.style.display = 'none';
        } catch (error) {
            console.error('Method 2 failed:', error);
            tryMethod3(hash, qrcodeDiv, loadingDiv);
        }
    } else {
        console.log('QRCode constructor not available, trying method 3');
        tryMethod3(hash, qrcodeDiv, loadingDiv);
    }
}

function tryMethod3(hash, qrcodeDiv, loadingDiv) {
    // Method 3: Using external QR code service
    console.log('Trying external QR code service...');
    const qrUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=' + encodeURIComponent(hash);
    qrcodeDiv.innerHTML = '<img src="' + qrUrl + '" alt="QR Code" style="border: 1px solid #ccc;">';
    console.log('QR code generated successfully with external service');
    if (loadingDiv) loadingDiv.style.display = 'none';
}

function downloadQRCode() {
    const canvas = document.querySelector('#qrcode canvas');
    if (canvas) {
        const link = document.createElement('a');
        link.download = 'certificate-hash-qr.png';
        link.href = canvas.toDataURL();
        link.click();
    }
}
</script>

</body>
</html>

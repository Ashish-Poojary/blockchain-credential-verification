<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<title>Academic Credential Verification</title>
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
		.validation-form {
			background-color: #ffffff; /* White form background */
			border: 1px solid #e0e0e0;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			border-radius: 8px;
			padding: 30px; /* Increased padding */
			width: 60%;
			max-width: 600px;
			margin: 20px auto;
			display: flex;
			flex-direction: column;
			gap: 20px;
		}
		.validation-form h1 {
			font-size: 22px;
			color: #333;
			text-align: center;
			margin-bottom: 10px;
		}
		.form-group {
			display: flex;
			flex-direction: column;
			gap: 5px;
		}
		.form-group label {
			font-size: 14px;
			font-weight: bold;
			color: #555;
		}
		.form-group input[type="text"],
		textarea {
			width: 100%;
			padding: 12px; /* Increased padding */
			border: 1px solid #ccc;
			border-radius: 6px; /* Slightly more rounded */
			font-size: 14px;
			transition: border-color 0.3s;
		}
		.form-group input[type="text"]:focus,
		textarea:focus {
			outline: none;
			border-color: #007bff;
		}
		.form-group input[type="submit"] {
			width: 100%;
			padding: 12px;
			background-color: #007bff; /* Primary accent blue */
			color: #ffffff;
			font-weight: bold;
			border: none;
			border-radius: 6px;
			font-size: 16px;
			cursor: pointer;
			transition: background-color 0.3s;
		}
		.form-group input[type="submit"]:hover {
			background-color: #0056b3; /* Darker blue on hover */
		}
		.certificate-display {
			text-align: center;
			margin-top: 20px;
		}
		.certificate-display img {
			max-width: 100%;
			height: auto;
			border: 1px solid #ddd;
			border-radius: 6px;
			margin-bottom: 15px;
		}
		.download-link {
			display: inline-block;
			padding: 12px 24px;
			background-color: #28a745; /* Green for download button */
			color: #fff;
			text-decoration: none;
			border-radius: 6px;
			font-weight: bold;
			transition: background-color 0.3s;
		}
		.download-link:hover {
			background-color: #218838;
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
						<div id="gtco-logo"><a href="index.html"><h5></h5></a></div>
					</div>
					<div class="col-xs-10 text-right menu-1">
						<ul>
							<li class="active"><a href="index.jsp">Home</a></li>
							<li><a href="about.jsp">About</a></li>
							<li class="has-dropdown">
								<a href="#">Login</a>
								<ul class="dropdown">
									<li><a href="adminlogin.jsp">Admin</a></li>
									<li><a href="studentlogin.jsp">Student</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</nav>

		<p style="text-align: center; color: #007bff; font-weight: bold; margin-top: 20px;">Welcome Guest</p>

		<div class="validation-form">
			<h1>Check Certificate Authenticity</h1>
			<p style="text-align: center; color: #666; margin-bottom: 20px;">
				Enter the USN and hash value to verify if a certificate is authentic or has been modified.
			</p>
			<form name="downloadcertificate" action="guestvalidatehash" method="post">
				<div class="form-group">
					<label for="usn">Enter USN</label>
					<input type="text" id="usn" name="usn" required placeholder="Enter the student's USN" />
				</div>
				<div class="form-group">
					<label for="hash">Enter Hash Value</label>
					<div style="display: flex; align-items: center; gap: 10px;">
						<input type="text" id="hash" name="hash" required placeholder="Enter the certificate hash to verify" style="flex: 1;" />
						<label for="fileInput" style="background: #007bff; color: white; border: none; padding: 12px 16px; border-radius: 4px; cursor: pointer; transition: background-color 0.3s; display: flex; align-items: center; justify-content: center; min-width: 50px; font-size: 13px;" title="Upload QR Code Image">
							Upload
						</label>
						<input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="processFile(this.files[0])" />
					</div>
					<small style="color: #666; margin-top: 8px; display: block;">Upload a QR code image to automatically extract the hash value</small>
				</div>
				<div class="form-group">
					<input type="submit" name="button" value="Check Certificate Authenticity" />
				</div>
			</form>
		</div>

		<div class="validation-form">
			<h1>Send Certificate Mismatch Notification</h1>
			<form name="sendEmailForm" action="verifierSendEmail.jsp" method="post">
				<div class="form-group">
					<label for="usn">Enter USN</label>
					<input type="text" id="usn" name="usn" required />
				</div>
				<div class="form-group">
					<label for="verifierMessage">Verifier's Message</label>
					<textarea id="verifierMessage" name="verifierMessage" rows="4" required></textarea>
				</div>
				<div class="form-group">
					<input type="submit" name="button" value="Send Notification" />
				</div>
			</form>
		</div>

	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/main.js"></script>
	<!-- Add jsQR library for actual QR code decoding -->
	<script src="https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.min.js"></script>
	
	<script>
		function processFile(file) {
			if (file) {
				// Validate file type
				if (!file.type.startsWith('image/')) {
					alert('Please select an image file (JPG, PNG, GIF, etc.)');
					return;
				}
				
				// Show processing message
				alert('Processing QR code image... Please wait.');
				
				// Create canvas to process the image
				const canvas = document.createElement('canvas');
				const ctx = canvas.getContext('2d');
				const img = new Image();
				
				img.onload = function() {
					try {
						// Set canvas dimensions
						canvas.width = img.width;
						canvas.height = img.height;
						
						// Draw image to canvas
						ctx.drawImage(img, 0, 0);
						
						// Get image data for QR processing
						const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
						
						// Use jsQR to decode the QR code
						const code = jsQR(imageData.data, imageData.width, imageData.height);
						
						if (code) {
							// QR code found!
							const decodedData = code.data;
							console.log('QR Code decoded successfully:', decodedData);
							
							// Check if the decoded data looks like a hash
							if (isValidHashFormat(decodedData)) {
								document.getElementById('hash').value = decodedData;
								alert('✅ QR Code decoded successfully!\n\nHash extracted: ' + decodedData.substring(0, 16) + '...\n\nFull hash has been filled in the input field.');
							} else {
								alert('⚠️ QR code decoded but contains invalid hash format.\n\nDecoded content: ' + decodedData + '\n\nPlease check if this is the correct QR code or enter the hash manually.');
							}
						} else {
							alert('❌ No QR code found in the uploaded image.\n\nPossible reasons:\n• Image doesn\'t contain a QR code\n• Image quality is too low\n• QR code is damaged or unclear\n\nPlease try a different image or enter the hash manually.');
						}
					} catch (error) {
						console.error('Error processing image:', error);
						alert('❌ Error processing image: ' + error.message + '\n\nPlease try a different image or enter the hash manually.');
					}
				};
				
				img.onerror = function() {
					alert('❌ Error loading image file.\n\nPlease ensure the file is a valid image and try again.');
				};
				
				// Load the image
				const reader = new FileReader();
				reader.onload = function(e) {
					img.src = e.target.result;
				};
				reader.onerror = function() {
					alert('❌ Error reading image file.\n\nPlease try a different image or enter the hash manually.');
				};
				reader.readAsDataURL(file);
			}
		}
		
		function isValidHashFormat(hash) {
			// Basic validation: 32+ characters, hexadecimal
			return hash && hash.length >= 32 && /^[a-fA-F0-9]+$/.test(hash);
		}
		
		// Check if hash parameter is passed in URL (for direct verification)
		window.onload = function() {
			const urlParams = new URLSearchParams(window.location.search);
			const hashParam = urlParams.get('hash');
			if (hashParam) {
				document.getElementById('hash').value = hashParam;
			}
		};
	</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR Scanner Test - Blockchain Certificate System</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .test-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .test-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
        }
        .test-title {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        .hash-input {
            width: 100%;
            padding: 10px;
            border: 2px solid #007bff;
            border-radius: 5px;
            font-family: monospace;
            margin: 10px 0;
        }
        .btn-test {
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 16px;
            margin: 10px 5px;
        }
        .btn-test:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }
        .result-box {
            background: #e8f5e8;
            border: 1px solid #28a745;
            border-radius: 8px;
            padding: 15px;
            margin: 15px 0;
            display: none;
        }
        .error-box {
            background: #f8d7da;
            border: 1px solid #dc3545;
            border-radius: 8px;
            padding: 15px;
            margin: 15px 0;
            display: none;
        }
        .hash-display {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
            font-family: monospace;
            word-break: break-all;
            margin: 10px 0;
        }
        .info-box {
            background: #d1ecf1;
            border: 1px solid #bee5eb;
            border-radius: 8px;
            padding: 15px;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="test-container">
        <div class="test-section">
            <h2 class="test-title">QR Scanner Test Page</h2>
            <p class="text-center text-muted">Test the QR scanner functionality with sample hash keys</p>
        </div>

        <div class="info-box">
            <h5>How to Test:</h5>
            <ol>
                <li>Enter a sample hash key below (or use the provided examples)</li>
                <li>Click "Test Hash Validation" to verify the format</li>
                <li>Click "Simulate QR Scan" to test the scanning process</li>
                <li>Use "Verify Certificate" to test the full workflow</li>
            </ol>
        </div>

        <div class="test-section">
            <h4>Hash Key Input</h4>
            <input type="text" class="hash-input" id="testHash" 
                   placeholder="Enter hash key to test (e.g., a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6)">
            
            <div class="text-center">
                <button class="btn btn-test" onclick="loadSampleHash()">Load Sample Hash</button>
                <button class="btn btn-test" onclick="clearHash()">Clear</button>
            </div>
        </div>

        <div class="test-section">
            <h4>Test Actions</h4>
            <div class="text-center">
                <button class="btn btn-test" onclick="testHashValidation()">Test Hash Validation</button>
                <button class="btn btn-test" onclick="simulateQRScan()">Simulate QR Scan</button>
                <button class="btn btn-test" onclick="verifyCertificate()">Verify Certificate</button>
            </div>
        </div>

        <!-- Test Results -->
        <div class="result-box" id="testResult">
            <h5>Test Successful!</h5>
            <p id="resultMessage"></p>
            <div class="hash-display" id="resultHash"></div>
        </div>

        <div class="error-box" id="testError">
            <h5>Test Failed</h5>
            <p id="errorMessage"></p>
        </div>

        <!-- Navigation -->
        <div class="test-section">
            <div class="text-center">
                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                <a href="qrscanner.jsp" class="btn btn-primary">Go to QR Scanner</a>
                <a href="guest.jsp" class="btn btn-success">Guest Verification</a>
            </div>
        </div>
    </div>

    <script>
        // Sample hash keys for testing
        const sampleHashes = [
            "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
            "1234567890abcdef1234567890abcdef",
            "fedcba0987654321fedcba0987654321",
            "5a4b3c2d1e0f9a8b7c6d5e4f3a2b1c0d"
        ];

        function loadSampleHash() {
            const randomHash = sampleHashes[Math.floor(Math.random() * sampleHashes.length)];
            document.getElementById('testHash').value = randomHash;
        }

        function clearHash() {
            document.getElementById('testHash').value = '';
            hideAllResults();
        }

        function testHashValidation() {
            const hash = document.getElementById('testHash').value.trim();
            
            if (!hash) {
                showError('Please enter a hash key first');
                return;
            }

            // Basic hash validation (32+ characters, alphanumeric)
            const isValid = /^[a-fA-F0-9]{32,}$/.test(hash);
            
            if (isValid) {
                showResult('Hash key format is valid', hash);
            } else {
                showError('Invalid hash key format. Must be 32+ alphanumeric characters.');
            }
        }

        function simulateQRScan() {
            const hash = document.getElementById('testHash').value.trim();
            
            if (!hash) {
                showError('Please enter a hash key first');
                return;
            }

            // Simulate QR code scanning process
            showResult('QR code scanned successfully', hash);
        }

        function verifyCertificate() {
            const hash = document.getElementById('testHash').value.trim();
            
            if (!hash) {
                showError('Please enter a hash key first');
                return;
            }

            // Simulate certificate verification
            showResult('Certificate verification initiated', hash);
            
            // Add a button to actually go to verification
            const resultDiv = document.getElementById('testResult');
            const verifyBtn = document.createElement('button');
            verifyBtn.className = 'btn btn-success mt-3';
            verifyBtn.textContent = 'Go to Verification Page';
            verifyBtn.onclick = function() {
                window.location.href = `guest.jsp?hash=${encodeURIComponent(hash)}`;
            };
            resultDiv.appendChild(verifyBtn);
        }

        function showResult(message, hash) {
            document.getElementById('resultMessage').textContent = message;
            document.getElementById('resultHash').textContent = hash;
            document.getElementById('testResult').style.display = 'block';
            document.getElementById('testError').style.display = 'none';
        }

        function showError(message) {
            document.getElementById('errorMessage').textContent = message;
            document.getElementById('testError').style.display = 'block';
            document.getElementById('testResult').style.display = 'none';
        }

        function hideAllResults() {
            document.getElementById('testResult').style.display = 'none';
            document.getElementById('testError').style.display = 'none';
        }

        // Load a sample hash on page load
        window.onload = function() {
            loadSampleHash();
        };
    </script>
</body>
</html>








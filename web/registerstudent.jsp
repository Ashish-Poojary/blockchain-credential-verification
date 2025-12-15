<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Certificate Verify</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Blockchain-Based Academic Credential Verification System" />
	<meta name="keywords" content="blockchain, certificate verification, academic credentials, tampering detection, QR code" />
	<meta name="author" content="Academic Credential System" />

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link href="https://fonts.googleapis.com/css?family=Merriweather:300,400|Montserrat:400,700" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Themify Icons-->
	<link rel="stylesheet" href="css/themify-icons.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">

	<!-- Owl Carousel  -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="css/style.css">

	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
     <style>
        body {
            background: oldlace;
            font-family: 'Montserrat', sans-serif;
            color: #333;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header-title {
            text-align: center;
            font-family: 'Montserrat', sans-serif;
            font-size: 2.5em;
            font-weight: 700;
            color: burlywood;  /* Adjust color as needed */
            margin-top: 30px; /* Small margin at the top */
            margin-bottom: 10px;/* Adjust color as needed */
        }

        .gtco-nav {
            position:relative;
            border: 2px solid #ccc; /* Add border to the navbar */
            border-radius: 5px; /* Optional: Add rounded corners */
            background-color: #f8f9fa; /* Optional: Light background for the navbar */
            padding: 10px 0;
            margin-bottom: 20px; 
	}
        
        .menu-1 {
            display: flex;
            justify-content: flex-end;
            float: right;/* Aligns the menu to the right */
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
            color: black;
            font-weight: bold;
	}

	.menu-1 ul li a:hover {
            color: #007bff; /* Highlight link on hover */
	}

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 100px);
            padding-top: 80px;
        }

        .form-card {
            background-color: moccasin; /* Light background color */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            
        }

        .form-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .form-card label {
            display: inline-block;
            width: 30%; /* Adjust width to align labels to the left */
            text-align: right; /* Align labels to the right */
            margin-right: 20px; /* Add space between label and input */
            font-weight: bold;
            color: #555;
            margin-bottom: 10px;
        }

        .form-card input[type="text"],
        .form-card input[type="email"],
        .form-card input[type="file"] {
            width: 65%; /* Adjust width to fill the remaining space */
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s;
        }

        .form-card input[type="text"]:focus,
        .form-card input[type="email"]:focus,
        .form-card input[type="file"]:focus {
            border-color: #ff6347;
            outline: none;
        }

        .form-card button {
            width: 48%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: lightskyblue; /* Green color */
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-card button:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        .form-card .reset-button {
            background-color: lightskyblue; /* Red color for reset */
        }

        .form-card .reset-button:hover {
            background-color: #e53935; /* Darker red on hover */
        }
        .alert {
            text-align: center;
            margin: 20px auto;
            max-width: 500px;
            font-size: 16px;
        }
    </style>
</head>
	<body>
		
	<div class="gtco-loader"></div>
	
	<div id="page">
            <div class="header-title">
                <h3>BlockChain Based Academic Credential Verification System</h3>
           </div>

		<nav class="gtco-nav" role="navigation">
			<div class="gtco-container">
				
				<div class="row">
					

					<div class="col-xs-10 text-right menu-1">
						<ul>
							<li ><a href="adminpage.jsp">Home</a></li>
							<li class="active"><a href="registerstudent.jsp">Register Student</a></li>
                                                        <li><a href="uploadcertificate.jsp">Upload Certificate</a></li>
                                                        <li><a href="viewhash.jsp">View Hash</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
				</div>
				
			</div>
		</nav>
  
		<div class="form-container">
                    <div class="form-card">
                        <h2 class="form-heading">Register Student</h2>
                        <form action="registerstudent" method="post" name="form1" enctype="multipart/form-data">
                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                <label for="usn">USN</label>
                                <input type="text" name="usn" id="usn" required>
                            </div>

                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                <label for="t1">Full Name</label>
                                <input type="text" name="t1" id="t1" pattern="[A-Za-z ]+" title="letters only" required>
                            </div>

                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                <label for="t2">Mobile</label>
                                <input type="text" name="t2" id="t2" maxlength="10" pattern="^\d{10}$" title="only numbers, 10 digits" required>
                            </div>

                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                <label for="t3">Photo</label>
                                <input type="file" name="t3" id="t3" required>
                            </div>

                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                <label for="t4">Email ID</label>
                                <input type="email" name="t4" id="t4" required>
                            </div>

                            <div style="display: flex; justify-content: space-between;">
                                <button type="submit">Submit</button>
                                <button type="reset" class="reset-button">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>


		
		
	    <div align="center">
	    
                <%
                    if (request.getParameter("msg")!=null)
                    {
                        String msg=request.getParameter("msg");
                        
                        if (msg.equals("EXIST"))
                        {
                            out.println( "<script>alert('USN already registered!');</script>");
                        }
                        else
                        if (msg.equals("SUCCESS"))    
                        {
                            out.println( "<script>alert('Registeration Success');</script>");
                        }
                    }
                        
                
                %>				
					
        </div>
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Carousel -->
	<script src="js/owl.carousel.min.js"></script>

	<!-- Main -->
	<script src="js/main.js"></script>

	</body>
</html>


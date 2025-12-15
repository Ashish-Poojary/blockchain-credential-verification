<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<!DOCTYPE HTML>
<!--
	Blockchain-Based Academic Credential Verification System
-->
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
        /* Background color */
        body {
            background-color: #f4f8fb; /* Light blue-gray background */
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

        /* Center alignment for content */
        .center-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin: 20px auto;
        }

        /* Certificate uploaded message */
        .uploaded-message {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        /* Table styling for the content */
        .content-table {
            background-color: oldlace;
            border: 1px solid #ddd;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            width: 60%;
        }
        .content-table div {
            margin-bottom: 20px; /* Add space between details */
        }
         .content-table strong {
            color: #000; /* Black color for USN, Photo, and Hash */
            font-size: 18px;
        }

        .content-table img {
            border-radius: 8px;
        }
        input[type="text"], textarea {
            color: #000; /* Black text color */
            background-color: #fff; /* White background for input */
            border: 1px solid #ddd;
            padding: 5px;
            font-size: 16px;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box; /* Ensure consistent sizing */
        }

        /* Button styling */
        .save-button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .save-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<%@page import="java.sql.*"%>
<%@page import="dbconnection.Dbconnection"%>
	<body>
		
	<div class="gtco-loader"></div>
	
	<div id="page">
            <div class="page-title">
                <h3> BlockChain Based Academic Credential Verification System</h3>
            </div>
		<nav class="gtco-nav" role="navigation">
			<div class="gtco-container">
				
				<div class="row">
					<div class="col-sm-2 col-xs-12">
						<div id="gtco-logo"><a href="index.jsp"><h5></h5></div>
					</div>

					<div class="col-xs-10 text-right menu-1">
			
						<ul>
							<li ><a href="adminpage.jsp">Home</a></li>
							<li ><a href="registerstudent.jsp">Register Student</a></li>
                                                        <li class="active"><a href="uploadcertificate.jsp">Upload Certificate</a></li>
                                                        <li><a href="viewhash.jsp">View Hash</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
				</div>
				
			</div>
		</nav>
 
		
            <div class="center-content">
                <div class="uploaded-message">
                    Certificate Successfully Uploaded
                </div>

                <div class="content-table">
                    <div>
                        <strong>USN:</strong>
                        <span><%=session.getAttribute("usn")%></span>
                    </div>
                    <div>
                        <strong>Photo:</strong>
                        <% String path = (String) session.getAttribute("fpath"); %>
                        <img alt="User Picture" src="view.jsp?id=<%=path%>" width="120" height="120" />
                    </div>
                    <div>
                        <strong>Hash:</strong>
                        <span><%=(String)session.getAttribute("hash")%></span>
                    </div>
                </div>

                <form name="savehash" method="post" action="savehash">
                    <button type="submit" class="save-button">Save Hash in Blockchain</button>
                </form>
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
                            out.println( "<script>alert('upload Success');</script>");
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


<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<!DOCTYPE HTML>

<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Identity Management</title>
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
		/* Center title at the top */
		.center-title {
			text-align: center;
			font-family: 'Montserrat', sans-serif;
			font-size: 2.5em;
			font-weight: 700;
			color: #DEB887; /* Burlywood color */
			margin: 0;
			padding: 15px;
			background-color: #f8f9fa;
			border-bottom: 2px solid #ccc;
		}

		/* Navbar Styling */
		.gtco-nav {
			border: 2px solid #ccc;
			background-color: #333; /* Dark background for contrast */
			color: white;
			padding: 10px 0;
		}

		.menu-1 ul {
			list-style: none;
			margin: 0;
			padding: 0;
		}

		.menu-1 ul li {
			display: inline-block;
			margin-right: 15px;
		}

		.menu-1 ul li a {
			text-decoration: none;
			font-size: 16px;
			color: white;
			font-weight: bold;
		}

		.menu-1 ul li a:hover {
			color: #FFD700; /* Gold hover effect */
		}

		/* Center login form */
		.form-container {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 80vh; /* Adjust for spacing */
			background-color: #f8f9fa; /* Light background */
		}

		.form-box {
			width: 400px;
			padding: 20px;
			border: 2px solid #ccc;
			border-radius: 10px;
			background-color: #fff; /* White background */
			box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
		}

		.form-box h2 {
			text-align: center;
			margin-bottom: 20px;
			font-family: 'Montserrat', sans-serif;
		}

		.form-box input[type="text"],
		.form-box input[type="password"],
		.form-box input[type="submit"],
		.form-box input[type="reset"] {
			width: 100%;
			padding: 10px;
			margin: 10px 0;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 14px;
		}

		.form-box input[type="submit"] {
			background-color: #333;
			color: white;
			cursor: pointer;
		}

		.form-box input[type="submit"]:hover {
			background-color: #FFD700;
		}
	</style>
</head>
	<body>
		
	<div class="gtco-loader"></div>
	
	<div id="page">

		<div class="center-title">
		<h3>BlockChain Based Academic Credential Verification System</h3>
	</div>

	<!-- Navigation Bar -->
	<nav class="gtco-nav" role="navigation">
		<div class="gtco-container">
			<div class="row">
				<div class="col-xs-12 text-center menu-1">
					<ul>
						<li class="active"><a href="index.jsp">Home</a></li>
						<li><a href="about.jsp">About</a></li>
						<li class="has-dropdown">
							<a href="#">Login</a>
							<ul class="dropdown">
								<li><a href="studentlogin.jsp">Student</a></li>
								<li><a href="guest.jsp">Guest</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</nav>


		<div class="form-container">
		<div class="form-box">
			<h2>Admin Login</h2>
			<form name="form1" method="post" action="">
				<input type="text" name="textfield" id="textfield" placeholder="Email ID" required>
				<input type="password" name="textfield2" id="textfield2" placeholder="Password" required>
				<input type="submit" name="button" id="button" value="Submit">
				<input type="reset" name="button2" id="button2" value="Reset">
			</form>
		</div>
	</div>
		
		
	    <div align="center">
	      <%@page import="dbconnection.Dbconnection"%>
	        <%
		 if(request.getParameter("button")!= null)
	{
        try
    {

   
      Connection con=Dbconnection.getConnection(); 
      Statement stmt=con.createStatement();
      ResultSet rs,rs1;
     
     // String type=request.getParameter("select").trim();
   
       
      //String pid=request.getParameter("textfield2").trim();
   String u=request.getParameter("textfield").trim();
	
	  String p=request.getParameter("textfield2").trim();
	  out.println(u);
      
	  
	
	  rs=stmt.executeQuery("select * from admin where emailid="+"'"+u+"'"+" and pwd="+"'"+p+"'");
	 /// rs=stmt.executeQuery("select * from adminlogin");
  String f="",a="",m="",e="",id="",status="";
      
    if(rs.next())
 {
	 
 	
	
	session.setAttribute("email",u);

	

        response.sendRedirect("adminpage.jsp"); 
   }
  else
    {
	out.println( "<script>alert('Login Unsuccess, Please Check your login details');window.location='adminlogin.jsp';</script>");

    }
                  rs.close();
		  stmt.close();
		  con.close();
    }

 catch(Exception e)
    {
     
     out.println("Exception occured" +e);
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


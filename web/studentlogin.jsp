<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<!DOCTYPE HTML>
<!--
	Blockchain-Based Academic Credential Verification System
-->
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
        body {
            background-color: #f0f8ff; /* Light blue background */
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-top: 20px;
            color: #333;
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

        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        .form-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #4682b4; /* Steel blue */
            margin-bottom: 20px;
        }

        form input[type="text"], 
        form input[type="password"], 
        form input[type="submit"], 
        form input[type="reset"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form input[type="submit"], 
        form input[type="reset"] {
            background-color: #4682b4;
            color: #ffffff;
            cursor: pointer;
        }

        form input[type="submit"]:hover, 
        form input[type="reset"]:hover {
            background-color: #315f72;
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
						<div id="gtco-logo"><a href="index.jsp"><h5></h5></div>
					</div>

					<div class="col-xs-10 text-right menu-1">
			
						<ul>
							<li class="active"><a href="index.jsp">Home</a></li>
							<li><a href="about.jsp">About</a></li>
							<li class="has-dropdown">
								<a href="#">Login</a>
								<ul class="dropdown">
									<li><a href="adminlogin.jsp">Admin</a></li>
									<li><a href="guest.jsp">Guest</a></li>
								</ul>
							</li>
<!--							<li class="has-dropdown">
								<a href="#">Dropdown</a>
								<ul class="dropdown">
									<li><a href="#">HTML5</a></li>
									<li><a href="#">CSS3</a></li>
									<li><a href="#">Sass</a></li>
									<li><a href="#">jQuery</a></li>
								</ul>
							</li>
-->							<!--<li><a href="portfolio.html">Portfolio</a></li>
							<li><a href="contact.html">Contact</a></li>-->
						</ul>
					</div>
				</div>
				
			</div>
		</nav>

		<div class="form-container">
                    <div class="form-title">Student Login</div>
                    <form name="form1" method="post" action="">
                        <label for="textfield">USN</label>
                        <input type="text" name="textfield" id="textfield" required>
                        <label for="textfield2">Password</label>
                        <input type="password" name="textfield2" id="textfield2" required>
                        <div align="center">
                            <input type="submit" name="button" id="button" value="Submit">
                            <input type="reset" name="button2" id="button2" value="Reset">
                        </div>
                    </form>
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
      
	  
	
	  rs=stmt.executeQuery("select * from student where usn="+"'"+u+"'"+" and pwd="+"'"+p+"'");
	 /// rs=stmt.executeQuery("select * from adminlogin");
  String f="",a="",m="",e="",id="",status="";
      
    if(rs.next())
 {
	 
 	
	
	session.setAttribute("usn",u);

	

        response.sendRedirect("studentpage.jsp"); 
   }
  else
    {
	out.println( "<script>alert('Login Unsuccess, Please Check your login details');window.location='studentlogin.jsp';</script>");

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


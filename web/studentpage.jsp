<%-- 
    Document   : index
    Created on : 20 Dec, 2021, 11:23:13 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Blockchain-Based Academic Credential Verification System
-->
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Certificate Issue</title>
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
            background-color: #f8f9fa; /* Light gray background */
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin: 20px 0;
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


        .profile-container {
            max-width: 900px;
            margin: 40px auto;
            background-color: moccasin;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .profile-details {
            flex: 1;
            margin-right: 20px;
        }

        .profile-details table {
            width: 100%;
            border-collapse: collapse;
        }

        .profile-details td {
            padding: 10px;
            vertical-align: top;
        }

        .profile-photo {
            width: 150px; /* Adjust as needed */
            height: 150px; /* Adjust as needed */
            border-radius: 50%; /* Makes it round */
            border: 2px solid #ccc; /* Optional border */
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Optional shadow */
            overflow: hidden; /* Ensures content fits within the circle */
            display: flex;
            align-items: center; /* Vertically centers the image */
            justify-content: center;
        }

        .profile-photo img {
            width: 100%; /* Ensures the image fits the container */
            height: 100%; /* Maintains aspect ratio */
            object-fit: cover; /* Fills the circle and prevents stretching */
            object-position: center top; 
        }
    </style>

	</head>
	<body>
		
	<div class="gtco-loader"></div>
	
	<div id="page">
            <div class="page-title">
                <h3>Blockchain Based Academic Credential Verification System</h3>
            </div>

		<nav class="gtco-nav" role="navigation">
			<div class="gtco-container">
				
				<div class="row">
					<div class="col-sm-2 col-xs-12">
						<div id="gtco-logo"><a href="index.html"><h5></h5></div>
					</div>

					<div class="col-xs-10 text-right menu-1">
			
						<ul>
							<li class="active"><a href="studentpage.jsp">Home</a></li>
							<li><a href="downloadcertificate.jsp">Download Certificate</a></li>
                                                        <li><a href="studentviewhash.jsp">View Hash</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
				</div>
				
			</div>
		</nav>
 
            
             <%@page import="dbconnection.Dbconnection"%>
		  <%@page import ="java.sql.*"%>
          <%@page import="java.util.*,java.io.*"%>
          <%   
                                          
try
{
    
   Connection con=Dbconnection.getConnection(); 

    PreparedStatement pst=con.prepareStatement("select * from student where usn=?");
    pst.setString(1,session.getAttribute("usn").toString());
    ResultSet rs=pst.executeQuery();
    rs.next();
    String name=rs.getString(2);
    String mobile=rs.getString(3);
    String email=rs.getString(4);
    String fpath=rs.getString(6);
    
   
   %>

		<div class="profile-container">
        <div class="profile-details">
            <h2>Student Profile</h2>
            <table>
                <tr>
                    <td><strong>Name:</strong></td>
                    <td><%=name%></td>
                </tr>
                <tr>
                    <td><strong>Mobile No.:</strong></td>
                    <td><%=mobile%></td>
                </tr>
                <tr>
                    <td><strong>Email ID:</strong></td>
                    <td><%=email%></td>
                </tr>
            </table>
        </div>
        <div class="profile-photo">
            <img src="view.jsp?id=<%=fpath%>" alt="Student Photo">
        </div>
    </div>

            <%
                }
                catch(Exception e)
                {
                    out.println(e);
                    e.printStackTrace();

                }

                %>
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


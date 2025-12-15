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

    <style>
        body {
            background: url('your-background-image.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        .gtco-nav {
            background-color: #333;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff6347;
        }

        .gtco-logo img {
            height: 50px;
            width: auto;
        }

        .menu-1 ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .menu-1 ul li {
            margin-right: 15px;
        }

        .menu-1 ul li a {
            text-decoration: none;
            font-size: 16px;
            color: #fff;
            font-weight: bold;
        }

        .menu-1 ul li a:hover {
            color: #007bff;
        }

        .vision-mission {
            display: flex;
            gap: 20px;
            margin: 40px 20px;
            min-height: 400px;
        }

        .image-slider {
            flex: 1;
            max-width: 40%;
            min-width: 300px;
            min-height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .owl-carousel .item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }

        .owl-nav {
            position: absolute;
            top: 45%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 10px;
        }

        .owl-nav button.owl-prev,
        .owl-nav button.owl-next {
            background-color: rgba(0, 0, 0, 0.5);
            border: none;
            color: #fff;
            font-size: 20px;
            padding: 10px 15px;
            border-radius: 50%;
            cursor: pointer;
            transition: 0.3s;
        }

        .owl-nav button:hover {
            background-color: rgba(255, 255, 255, 0.8);
            color: #000;
        }

        .owl-dots {
            display: none !important;
        }

        .text-content {
            flex: 2;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            padding: 20px;
            color: #000;
        }

        .text-content h2 {
            font-size: 24px;
            color: burlywood;
            margin-bottom: 10px;
        }

        .text-content p,
        .text-content ul li {
            font-size: 16px;
            line-height: 1.6;
        }

        .footer {
            background-color: #222;
            color: #fff;
            padding: 40px 0;
        }

        .footer .container {
            max-width: 1200px;
        }

        .footer h4 {
            font-size: 18px;
        }

        .footer p,
        .footer li {
            font-size: 14px;
        }

        .gototop {
            position: fixed;
            bottom: 20px;
            right: 20px;
        }

        .gototop a {
            display: inline-block;
            background: #007bff;
            color: #fff;
            padding: 10px 15px;
            border-radius: 50%;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div id="page">
    <!-- Navigation -->
    <nav class="gtco-nav">
        <div class="gtco-logo">
            <img src="images/logo.webp" alt="BIT Logo">
        </div>
        <div class="menu-1">
            <ul>
                <li class="active"><a href="adminpage.jsp">Home</a></li>
                <li><a href="registerstudent.jsp">Register Student</a></li>
                <li><a href="uploadcertificate.jsp">Upload Certificate</a></li>
                <li><a href="viewhash.jsp">View Hash</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="vision-mission">
        <div class="image-slider">
            <div id="slider-carousel" class="owl-carousel owl-theme">
                <div class="item"><img src="images/1.webp" alt="Image 1"></div>
                <div class="item"><img src="images/2.jpg" alt="Image 2"></div>
                <div class="item"><img src="images/3.webp" alt="Image 3"></div>
            </div>
        </div>
        <div class="text-content">
            <h2>About Us</h2>
            <p>Bangalore Institute of Technology (BIT) was established in the year 1979 with an objective of providing quality education in the field of technology.</p>
            <h2>Vision</h2>
            <p>Establish and develop the Institute as a Centre of higher learning, with expanding knowledge in Engineering and Technology for societal success.</p>
            <h2>Mission</h2>
            <ul>
                <li>Provide quality education across Engineering disciplines.</li>
                <li>Lead in Science, Tech, and Research benefiting society.</li>
                <li>Collaborate with industry and government sectors.</li>
                <li>Enhance personality through cultural & professional activities.</li>
            </ul>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h4>BIT College</h4>
                    <p><strong>Address:</strong> Bangalore Institute of Technology, Bangalore, India</p>
                    <p><strong>Phone:</strong> +91 080 26615865</p>
                    <p><strong>Email:</strong> admin@example.com</p>
                </div>
                <div class="col-md-4">
                    <h4>Follow Us</h4>
                    <ul class="social-media-links">
                        <li><a href="https://www.facebook.com/bitsince1979">Facebook</a></li>
                        <li><a href="https://x.com/bitsince1979">Twitter</a></li>
                        <li><a href="https://www.linkedin.com/school/bitsince1979">LinkedIn</a></li>
                        <li><a href="https://www.instagram.com/bitsince1979/">Instagram</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <p class="text-center">&copy; 2025 BIT College | All Rights Reserved</p>
    </div>
</div>

<!-- Scroll to Top -->
<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>

<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script>
    $(document).ready(function(){
        $("#slider-carousel").owlCarousel({
            items: 1,
            loop: true,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true,
            nav: true,
            navText: ['❮', '❯'], // Clean minimal arrows
            dots: false
        });
    });
</script>
</body>
</html>

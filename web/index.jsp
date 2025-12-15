<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Blockchain Credential Verification</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Secure and verifiable academic credentials powered by blockchain technology." />
    <meta name="keywords" content="blockchain, certificate verification, academic credentials, immutable, verifiable" />
    <meta name="author" content="Academic Credential System" />

    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

    <style>
        :root {
            --header-footer-bg: #293a52;
            --header-footer-text: #ecf0f1;
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --link-hover-color: #ffc107;
            --light-color: #ecf0f1;
        }
        
        html, body {
            height: 100%;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            line-height: 1.6;
            background-color: var(--light-color);
            display: flex;
            flex-direction: column;
        }

        #page {
            flex: 1 0 auto;
        }
        
        .hero-section, footer {
            background-color: var(--header-footer-bg);
            color: var(--header-footer-text);
        }

        .hero-section {
            padding: 100px 0;
            position: relative;
            z-index: 1; /* Added z-index */
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('images/blockchain-pattern.png') repeat;
            opacity: 0.05;
            z-index: -1; /* Changed to negative z-index */
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 3.5rem;
            position: relative; /* Added */
            z-index: 2; /* Added */
        }
        
        .hero-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            position: relative; /* Added */
            z-index: 2; /* Added */
        }
        
        .navbar {
            background-color: white;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 15px 0;
            transition: all 0.3s ease;
            z-index: 1030; /* Higher than hero section */
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--primary-color) !important;
        }
        
        .navbar-brand span {
            color: var(--secondary-color);
        }
        
        .nav-link {
            font-weight: 500;
            color: var(--primary-color) !important;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            color: var(--secondary-color) !important;
        }
        
        .dropdown-menu {
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        
        .dropdown-item:hover {
            background-color: var(--light-color);
            color: var(--secondary-color);
        }

        .btn-primary {
            background-color: var(--secondary-color);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            color: white;
            display: inline-block;
            position: relative; /* Added */
            z-index: 2; /* Added */
        }
        
        .btn-primary:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            color: white;
        }
        
        .hero-buttons {
            margin-top: 30px;
        }
        
        .btn-outline-light {
            border: 2px solid white;
            color: white;
            background: transparent;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-outline-light:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            height: 100%;
            border-top: 4px solid var(--secondary-color);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }
        
        .feature-title {
            font-weight: 600;
            color: var(--primary-color);
        }

        .owl-carousel-fullwidth .item img {
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            height: 500px;
            object-fit: cover;
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 50px;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: var(--secondary-color);
        }

        footer {
            padding: 30px 0;
            text-align: center;
            margin-top: auto;
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            .navbar-brand {
                font-size: 1.5rem;
            }
            .hero-section {
                padding: 80px 0;
            }
            .owl-carousel-fullwidth .item img {
                height: 300px;
            }
        }
    </style>
</head>
<body>
    
<div class="gtco-loader"></div>

<div id="page">

    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Block<span>Certify</span></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="index.jsp">Home</a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Login
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="loginDropdown">
                            <li><a class="dropdown-item" href="adminlogin.jsp"><i class="fas fa-user-shield me-2"></i>Admin</a></li>
                            <li><a class="dropdown-item" href="studentlogin.jsp"><i class="fas fa-user-graduate me-2"></i>Student</a></li>
                            <li><a class="dropdown-item" href="guest.jsp"><i class="fas fa-user me-2"></i>Guest</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero-section text-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 mx-auto">
                    <h1 class="hero-title">Blockchain-Based Academic Credential Verification</h1>
                    <p class="hero-subtitle">Secure, tamper-proof verification of academic certificates using blockchain technology</p>
                                <div class="hero-buttons">
                <a href="guest.jsp" class="btn btn-primary btn-lg me-3">Verify a Certificate</a>
            </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 my-5">
        <div class="container">
            <h2 class="section-title text-center">Why Choose Our System</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="feature-title">Tamper-Proof Security</h3>
                        <p>Blockchain technology ensures that academic credentials cannot be altered or falsified after issuance.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-qrcode"></i>
                        </div>
                        <h3 class="feature-title">Instant Verification</h3>
                        <p>Quickly verify certificates using QR codes or unique identifiers with our decentralized system.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h3 class="feature-title">Global Accessibility</h3>
                        <p>Verify credentials from anywhere in the world, 24/7, without relying on institutional availability.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="owl-carousel owl-carousel-fullwidth">
                    <div class="item">
                        <img src="images/slider1.png" alt="Academic Credentials on a screen">
                    </div>
                    <div class="item">
                        <img src="images/slider2.jpg" alt="Students studying with a laptop">
                    </div>
                    <div class="item">
                        <img src="images/slider3.jpg" alt="A university campus building">
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <p class="mb-0">&copy; 2025 BlockCertify. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

<script>
    // Navbar scroll effect
    $(window).scroll(function() {
        if ($(this).scrollTop() > 50) {
            $('.navbar').addClass('scrolled');
        } else {
            $('.navbar').removeClass('scrolled');
        }
    });

    // Initialize Owl Carousel for the banner images
    $('.owl-carousel-fullwidth').owlCarousel({
        items: 1,
        loop: true,
        margin: 0,
        nav: false,
        dots: true,
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true
    });
</script>

</body>
</html>
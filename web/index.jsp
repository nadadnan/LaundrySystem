<%-- 
    Document   : index
    Created on : 24 Nov 2024, 9:45:26 am
    Author     : M S I
--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CoinLaundry</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="styles.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="styles.css">
        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <style>
            /* General Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                color: #333;
                background-color: #f5f5f5;
            }

            header {
                background-color: rgba(115, 114, 114, 0.7);
                padding: 1rem;
                position: fixed;
                top: 0;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                transition: top 0.3s ease-in-out;
                z-index: 1000;
            }

            header nav {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
            }

            header h1 {
                color: black;
                font-size: 1.5rem;
                margin-left: 1rem;
                font-weight: bold;
            }

            .nav-links {
                list-style: none;
                display: flex;
                gap: 4rem;
                font-size: 1rem;
            }

            .nav-links li a {
                color: black;
                text-decoration: none;
                font-weight: bold;
            }

            .login-button {
                background-color: black;
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 4px;
                cursor: pointer;
            }

            .login-button:hover {
                background-color: #333;
            }

            /* Dropdown Styles */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: white;
                min-width: 150px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1;
                right: 0;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .login-button {
                background-color: #333;
            }

            .hamburger {
                display: none;
                cursor: pointer;
                font-size: 2rem;
                color: black;
            }

            .nav-links {
                display: flex;
                gap: 2rem;
            }

            @media (max-width: 768px) {
                /* Mobile Navigation */
                .hamburger {
                    display: block;
                }

                .nav-links {
                    display: none;
                    flex-direction: column;
                    gap: 1rem;
                    position: absolute;
                    top: 60px;
                    left: 0;
                    width: 100%;
                    background-color: rgba(255, 255, 255, 0.95);
                    padding: 1rem;
                    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                }

                .nav-links.active {
                    display: flex;
                }

                .nav-links li a {
                    font-size: 1.2rem;
                    color: black;
                }
            }

            /* Sub-navigation styles */
            .sub-nav {
                display: none; /* Hidden by default */
                position: absolute;
                top: 100%; /* Position it below the parent menu */
                left: 0;
                background-color: white;
                list-style: none;
                padding: 0;
                margin: 0;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                z-index: 1;
            }

            .sub-nav li {
                border-bottom: 1px solid #ddd;
            }

            .sub-nav li a {
                display: block;
                padding: 12px 16px;
                text-decoration: none;
                color: black;
                font-size: 1rem;
            }

            .sub-nav li a:hover {
                background-color: #f1f1f1;
            }

            /* Show sub-navigation on hover */
            .dropdown:hover .sub-nav {
                display: block;
            }



            main {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                justify-content: center;
            }

            .hero-section {
                background-image: url('dist/img/background/bg-home.jpg');
                background-size: cover;
                background-position: center;
                flex: 1;
                padding: 8rem 2rem;
                text-align: left;
                color: black;
                min-height: 100vh;
            }

            .hero-section h2 {
                font-size: 2.5rem;
                font-weight: bold;
                margin-top: 7rem;
                margin-bottom: 1rem;
            }

            .hero-section p {
                font-size: 1.2rem;
                margin-bottom: 2rem;
            }

            .cta-button {
                background-color: black;
                color: white;
                border: none;
                padding: 0.8rem 2rem;
                font-size: 1rem;
                border-radius: 4px;
                cursor: pointer;
            }

            .cta-button:hover {
                background-color: #333;
            }

            footer {
                background-color: black;
                color: white;
                text-align: center;
                padding: 1.5rem;

            }

            .social-icons {
                display: flex;
                justify-content: center;
                gap: 1.5rem;
                margin-bottom: 1rem;
            }

            .social-icons img {
                width: 24px;
                height: 24px;
            }

            footer p {
                font-size: 0.9rem;
            }



            /*******************************/
            /****** Pricing Plan CSS *******/
            /*******************************/

            /* Pricing Plan Section with Video Background */
            /* General Styles for Pricing Section */
            .price {
                position: relative;
                z-index: 1; /* Ensures content is above the video and overlay */
                color: white;
                text-align: center;
                width: 100%;
                padding: 3rem 1rem; /* General padding */
                background-image: url('dist/img/background/mem.jpg');
                background-size: cover;
                background-position: center;
                flex: 1;
            }

            /* Darken background with a pseudo-element */
            .price::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Dark overlay with 50% opacity */
                z-index: -1; /* Place overlay behind content */
            }


            .price .container {
                max-width: 1200px; /* Limits the width of the content */
                margin: auto; /* Centers the container */
                padding: 0 15px; /* Prevents horizontal overflow */
            }

            .price .price-item {
                text-align: center;
                background: #ffffff;
                border-radius: 5px;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                width: 300px; /* Fixed width for desktop */
                margin: 0 auto; /* Center the box */
            }

            .price .price-header {
                padding: 30px 0 50px 0;
                color: #000000;
                background: #FFD662;
                border-radius: 5px 5px 0 0;
            }

            .price .featured-item .price-header {
                color: #ffffff;
                background: #00539C;
            }

            .price .price-icon {
                margin-bottom: 15px;
            }

            .price .price-icon i {
                display: inline-block;
                font-size: 45px;
            }

            .price .price-title h2 {
                font-size: 24px;
                font-weight: 300;
                letter-spacing: 2px;
            }

            .price .price-pricing h2 {
                font-size: 60px;
                font-weight: 100;
                margin-left: 15px;
                margin-bottom: 0;
            }

            .price .price-pricing h2 small {
                position: absolute;
                font-size: 18px;
                font-weight: 300;
                margin-top: 16px;
                margin-left: -30px;
            }

            .price .price-body {
                padding: 20px 0;
                background: #ffffff;
                border-radius: 0 0 5px 5px;
            }

            .price .price-des ul {
                margin: 0;
                padding: 0;
                list-style: none;
            }

            .price .price-des ul li {
                color: #2A293E;
                font-size: 14px;
                font-weight: 300;
                padding: 5px;
                border-bottom: 1px solid #eeeeee;
            }

            .price .price-des ul li:last-child {
                border: none;
            }

            .price .price-footer {
                padding-bottom: 30px;
                background: #ffffff;
                border-radius: 0 0 5px 5px;
            }

            .price .price-action a {
                display: inline-block;
                padding: 10px 25px;
                color: #000000;
                font-size: 14px;
                letter-spacing: 2px;
                background: #FFD662;
                border-radius: 5px;
                transition: 0.3s;
            }

            .price .price-action a i {
                margin-right: 5px;
            }

            .price .price-action a:hover {
                color: #ffffff;
                background: #00539C;
            }

            .price .featured-item .price-action a {
                color: #ffffff;
                background: #00539C;
            }

            .price .featured-item .price-action a:hover {
                color: #000000;
                background: #FFD662;
            }

            /* Centering price items and ensuring proper alignment */
            .price .row {
                justify-content: center; /* Center the row content */
            }

            .price .col-md-6 {
                display: flex;
                justify-content: center; /* Center individual items within their column */
            }

            /* Responsive Styles */
            @media (max-width: 768px) {
                #pricing-plan {
                    height: auto; /* Allow content to determine height */
                    padding: 3rem 1rem; /* Add padding for better spacing on small screens */
                }

                .video-background {
                    height: auto; /* Adjust height for responsiveness */
                    width: 100%; /* Ensure video covers full width */
                    object-fit: cover; /* Maintain aspect ratio */
                }

                .price .price-item {
                    width: 100%; /* Make price items take full width */
                    margin-bottom: 2rem; /* Add space between the items */
                }

                .price .price-header {
                    padding: 20px 0; /* Adjust padding for smaller screens */
                }

                .price .price-body {
                    padding: 15px; /* Ensure proper padding within the container */
                }

                .price .price-action a {
                    padding: 10px 20px; /* Adjust button size */
                    font-size: 14px; /* Reduce font size for buttons */
                }

                .price .container {
                    padding: 0; /* Remove extra padding to avoid horizontal scrolling */
                }

                .price .price-des ul li {
                    font-size: 13px; /* Slightly smaller font for better fit */
                    word-wrap: break-word; /* Prevent text overflow */
                }
            }

            /* Ensure video overlay spans the entire section */
            .video-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Semi-transparent overlay for readability */
                z-index: 1;
            }


            /* Service Section Styles */
            #services {
                background-color: #ffffff;
                padding: 3rem 1rem;
                text-align: center;
            }

            #services .section-title {
                font-size: 2rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #333;
            }

            #services .section-description {
                font-size: 1rem;
                color: #666;
                margin-bottom: 2rem;
            }

            .service-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 2rem;
            }

            .service-card {
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                text-align: center;
                max-width: 300px;
                transition: transform 0.3s ease;
            }

            .service-card:hover {
                transform: scale(1.05);
            }

            .service-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .service-card h3 {
                font-size: 1.5rem;
                margin: 1rem 0;
                color: #333;
            }

            .service-card h4 {
                font-size: 1rem;
                margin: 1rem 0;
                color: #333;
            }

            .service-card p {
                padding: 0 1rem 1rem;
                font-size: 0.9rem;
                color: #666;
            }


            /* Contact Us Section with Video Background */
            .contact-section {
                position: relative;
                overflow: hidden;
                padding: 2rem;
            }

            .contact-section .video-background {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover; /* Ensures the video covers the container */
                z-index: -2;
            }

            /* Dark overlay for better content readability */
            .contact-section .video-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Adjust overlay opacity */
                z-index: -1;
            }

            /* Contact form container */
            .contact-container {
                position: relative;
                z-index: 1; /* Ensure content is above video and overlay */
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                color: #333;
            }

            /* Responsive Adjustments */
            @media (max-width: 768px) {
                .contact-section {
                    padding: 1rem;
                }

                .contact-section .video-background {
                    height: 100%;
                    width: 100%;
                }

                .contact-container {
                    padding: 1rem;
                    width: 100%;
                }
            }


            .price-table-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .price-table {
                width: 85%; /* Adjust the width to make it smaller */
                max-width: 800px; /* Limit the max width */
                border-collapse: collapse;
            }

            .price-table th, .price-table td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .price-table th {
                background-color: #f4f4f4;
                font-weight: bold;
            }

            .price-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

        </style>
    </head>
    <body>
        <header id="navbar">
            <nav>
                <h1>Coin Laundry</h1>
                <!-- Hamburger Menu -->
                <div class="hamburger" id="hamburger">&#9776;</div>
                <ul class="nav-links" id="nav-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li class="dropdown">
                        <a href="#pricing">
                            Service and Pricing 
                            <i class="fa fa-caret-down"></i> <!-- Add an icon here -->
                        </a>
                        <ul class="sub-nav">
                            <li><a href="#wash-fold">Wash & Fold</a></li>
                            <li><a href="#handwash">Hand Wash</a></li>
                            <li><a href="#dryclean">Dry Clean</a></li>
                        </ul>
                    </li>
                    <li><a href="#coverage-area">Coverage Area</a></li>
                    <!--li><a href="#benefits">Benefits</a></li>
                    
                    <li><a href="#contact">Contact Us</a></li-->
                </ul>


                <div class="dropdown">
                    <button class="login-button">Log in <i class="fa fa-caret-down"></i></button>
                    <div class="dropdown-content">
                        <a href="cust_login.jsp">Customer</a>
                        <a href="staff_login.jsp">Staff</a>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <div class="hero-section">
                <h2>Because Your Time is Precious,<br> and Your Clothes are Too!</h2>
                <p>From pick-up to drop-off, we've got every wash cycle covered.</p>
                <a href="cust_login.jsp"><button class="cta-button">Book a pickup</button></a>
            </div>

            <!-- Service Section -->
            <section id="services">
                <div class="services-container">
                    <h2 class="section-title">Our Services</h2>
                    <p class="section-description">Discover a range of professional laundry services designed to save your time and give your clothes the care they deserve.</p>
                    <div class="service-grid">
                        <!-- Service 1: Wash & Fold -->
                        <div class="service-card">
                            <img src="dist/img/background/wf.jpeg" alt="Wash & Fold Service">
                            <h3>10 KG: Wash, Dry & Fold</h3>
                            <h4>RM25</h4> 
                            <p>Perfect for your everyday laundry needs. Suitable for 1-2 people.</p>
                        </div>
                        <div class="service-card">
                            <img src="dist/img/background/wf.jpeg" alt="Wash & Fold Service">
                            <h3>14 KG: Wash, Dry & Fold</h3>
                            <h4>RM36</h4> 
                            <p>Perfect for your everyday laundry needs. Suitable for 3-5 people.</p>
                        </div>
                        <div class="service-card">
                            <img src="dist/img/background/wf.jpeg" alt="Wash & Fold Service">
                            <h3>25 KG: Wash, Dry & Fold</h3>
                            <h4>RM50</h4>                            
                            <p>Perfect for your everyday laundry needs. Suitable for more than 5 people.</p>
                        </div>
                        <!-- Service 2: Hand Wash >
                        <div class="service-card">
                            <img src="dist/img/background/by_hand.jpg" alt="Hand Wash Service">
                            <h3>Handwash, Dry & Fold</h3>
                            <h4>RM5 per piece</h4>
                            <p>Delicate fabrics need special care. Our hand wash service ensures your garments stay in pristine condition.</p>
                        </div>
                        
                        <div class="service-card">
                            <img src="packageImages/fold1.jpg" alt="Dry Cleaning Service">
                            <h3>Fold Only</h3>
                            <h4>RM1 per piece</h4>
                            <p>Bring in your clean and dried laundry, and we?ll expertly fold it for you, saving you time and effort!</p>
                        </div>
                        
                        <div class="service-card">
                            <img src="packageImages/iron1.jpeg" alt="Dry Cleaning Service">
                            <h3>Ironing Only</h3>
                            <h4>RM3 per piece</h4>
                            <p>Bring in your clean clothes, and we?ll provide professional ironing to ensure they are wrinkle-free and perfectly pressed, ready to wear or store!</p>
                        </div>
                        <!-- Add more services as needed -->
                    </div>
                </div>              
            </section>

            <!-- Benefits Section  background-image:url('dist/img/background/bg2.png')-->
            <div id="benefits" class="benefits-section" style="padding: 2rem; background-color: white">
                <h2 style="text-align: center; margin-bottom: 1rem;">Why Choose Us?</h2>
                <p style="text-align: center; margin-bottom: 2rem;">
                    Here is why our laundry service stands out.
                </p>
                <div style="display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap;">
                    <div style="text-align: center; width: 300px; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                        <i class="fa fa-clock-o" style="font-size: 3rem; color: black; margin-bottom: 1rem;"></i>
                        <h3>Time-Saving</h3>
                        <p>Focus on what matters while we take care of your laundry.</p>
                    </div>
                    <div style="text-align: center; width: 300px; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                        <i class="fa fa-truck" style="font-size: 3rem; color: black; margin-bottom: 1rem;"></i>
                        <h3>Convenient Pickup & Delivery</h3>
                        <p>Free doorstep pickup and drop-off for hassle-free service.</p>
                    </div>
                    <div style="text-align: center; width: 300px; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                        <i class="fa fa-thumbs-up" style="font-size: 3rem; color: black; margin-bottom: 1rem;"></i>
                        <h3>Quality Guaranteed</h3>
                        <p>Professionally cleaned and handled with utmost care.</p>
                    </div>
                    <div style="text-align: center; width: 300px; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                        <i class="fa fa-tags" style="font-size: 3rem; color: black; margin-bottom: 1rem;"></i>
                        <h3>Affordable Pricing</h3>
                        <p>Competitive rates with no hidden charges.</p>
                    </div>
                </div>
            </div>


            <div id="coverage-area" style="
                 position: relative;
                 overflow: hidden;
                 color: white; /* Text color for contrast against video background */
                 text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);">

                <!-- Video Background -->
                <video autoplay muted loop playsinline style="
                       position: absolute;
                       top: 0;
                       left: 0;
                       width: 100%;
                       height: 100%;
                       object-fit: cover;
                       z-index: -2;">
                    <source src="dist/img/background/handwash.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>

                <!-- Dark Overlay -->
                <div style="
                     position: absolute;
                     top: 0;
                     left: 0;
                     width: 100%;
                     height: 100%;
                     background: rgba(0, 0, 0, 0.5); /* Adjust opacity for desired darkness */
                     z-index: -1;"></div>

                <!-- Content Section -->
                <div style="
                     position: relative;
                     z-index: 1;
                     max-width: 1200px;
                     margin: 2rem auto;
                     padding: 2rem;">
                    <h2 style="text-align: center; margin-bottom: 2rem; color: #fff;">Service Coverage Area</h2>
                    <div style="display: flex; gap: 2rem; flex-wrap: wrap;">
                        <!-- Coverage Map -->
                        <div style="flex: 1; min-width: 300px;">
                            <iframe src="https://www.google.com/maps/d/embed?mid=18UqA6EFTvDeAsKpGnBCWKlXYM4uYUr0&ehbc=2E312F" 
                                    width="100%" height="400" style="border: none; border-radius: 5px;"></iframe>
                        </div>
                        <!-- Description and Contact Section -->
                        <div style="flex: 1; min-width: 300px; display: flex; flex-direction: column; justify-content: center;">
                            <p style="margin-bottom: 1.5rem; color: #ddd; line-height: 1.6;">
                                Our services are available in the highlighted areas shown on the map, 
                                including postal codes: <b>20680, 21020, 21030, 21060, 21080, 21100, and 21300. </b> 
                                We pride ourselves on providing prompt and professional laundry solutions to our community. 
                                If your location is within these designated zones, you can easily schedule pickups and deliveries.
                            </p>
                            <p style="margin-bottom: 2rem; color: #ddd; line-height: 1.6;">
                                For customers outside these areas, we sincerely apologize for any inconvenience caused. 
                                Rest assured, we are actively working to expand our business to serve more regions in the future. 
                                Thank you for your support and understanding as we grow together!
                            </p>
                            <a href="cust_register.jsp" style="
                               display: inline-block;
                               padding: 0.8rem 1.5rem;
                               background-color: #ff6b6b;
                               color: white;
                               text-decoration: none;
                               text-align: center;
                               border-radius: 5px;
                               font-weight: bold;
                               transition: background-color 0.3s ease;">
                                Make a new account now!
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!--div id="contact" class="contact-section" style="
                 padding: 2rem 0;
                 background-color: #f9f9f9;">
                <div class="contact-container" style="
                     max-width: 580px;
                     margin: 0 auto;
                     background-color: white;
                     padding: 2rem;
                     border-radius: 10px;
                     box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                    <h2 style="text-align: center; margin-bottom: 1rem;">Contact Us</h2>
                    <p style="text-align: center; margin-bottom: 2rem; color: #555;">
                        We love to hear from you! Please fill out the form below to get in touch.
                    </p>
                    <form action="/action_page.php" method="post" style="display: flex; flex-direction: column; gap: 1rem;">
                        <div>
                            <label for="name" style="display: block; margin-bottom: 0.5rem;">Name</label>
                            <input type="text" id="name" name="name" placeholder="Your name.." style="
                                   width: 100%;
                                   padding: 0.8rem;
                                   border: 1px solid #ccc;
                                   border-radius: 5px;" 
                                   required>
                        </div>
                        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                            <div style="flex: 1;">
                                <label for="email" style="display: block; margin-bottom: 0.5rem;">Email</label>
                                <input type="email" id="email" name="email" placeholder="Your email.." style="
                                       width: 100%;
                                       padding: 0.8rem;
                                       border: 1px solid #ccc;
                                       border-radius: 5px;" 
                                       required>
                            </div>
                            <div style="flex: 1;">
                                <label for="phone" style="display: block; margin-bottom: 0.5rem;">Phone number</label>
                                <input type="tel" id="phone" name="phone" placeholder="011-123456789" pattern="[0-9]{3}-[0-9]{7}" required style="
                                       width: 100%;
                                       padding: 0.8rem;
                                       border: 1px solid #ccc;
                                       border-radius: 5px;" 
                                       required>
                            </div>
                        </div>
                        <div>
                            <label for="message" style="display: block; margin-bottom: 0.5rem;">Message</label>
                            <textarea id="message" name="message" placeholder="Write something..." style="
                                      width: 100%;
                                      padding: 0.8rem;
                                      border: 1px solid #ccc;
                                      border-radius: 5px;
                                      height: 150px;" 
                                      required></textarea>
                        </div>
                        <div style="text-align: right;">
                            <input type="submit" value="Submit" style="
                                   padding: 0.8rem 1.5rem;
                                   background-color: #333;
                                   color: white;
                                   border: none;
                                   border-radius: 5px;
                                   cursor: pointer;">
                        </div>
                    </form>
                </div>
            </div-->





        </main>

        <footer>
            <div class="social-icons">
                <a href="#" style="color: white;"><i class="fa fa-facebook-f" style="font-size:24px"></i></a>
                <a href="#" style="color: white;"><i class="fa fa-twitter" style="font-size:24px"></i></a>
                <a href="#" style="color: white;"><i class="fa fa-youtube-play" style="font-size:24px"></i></a>
                <a href="#" style="color: white;"><i class="fa fa-instagram" style="font-size:24px"></i></a>
            </div>
            <p>Copyright 2024 - Design by Nad</p>
        </footer>

        <script>
            let prevScrollPos = window.pageYOffset;
            const navbar = document.getElementById("navbar");

            window.onscroll = function () {
                let currentScrollPos = window.pageYOffset;
                if (prevScrollPos > currentScrollPos) {
                    navbar.style.top = "0";
                } else {
                    navbar.style.top = "-70px"; // Adjust this value based on header height
                }
                prevScrollPos = currentScrollPos;
            };

            // Toggle the mobile menu
            const hamburger = document.getElementById("hamburger");
            const navLinks = document.getElementById("nav-links");

            hamburger.addEventListener("click", () => {
                navLinks.classList.toggle("active");
            });
        </script>

    </body>
</html>

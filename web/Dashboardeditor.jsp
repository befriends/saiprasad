<%-- 
    Document   : Dashboardeditor
    Created on : 24 Apr, 2016, 1:00:54 PM
    Author     : vishwas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths" style="" lang="en"><head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Dairy Management System</title>
        <meta charset="UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/font-awesome.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/contact_me.js"></script>
        <script src="js/jqBootstrapValidation.js"></script>
        <script src="js/modernizr.js"></script>
        <script src="js/script.js"></script>
        <script src="js/Kernel.js"></script></head>
</head>
<body class="loginbody" style="background-image: url('images/Chocomilk.jpg') ">

    <!-- Start Logo Section -->
    <section id="logo-section" class="text-center">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <a href="#">
                        <div class="logo text-center">
                            <h1 style="color:#990099">SaiPrasad</h1>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <div class="mainbody-section text-center">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="menu-item blue">
                        <a href="DailyCollection.jsp" data-toggle="modal">
                            <i class="glyphicon glyphicon-registration-mark"></i>
                            <p>Daily Collection</p>
                        </a>
                    </div>
                    <div class="menu-item green">
                        <a href="Report.jsp" data-toggle="modal">
                            <i class="fa fa-file-photo-o"></i>
                            <p>Report</p>
                        </a>
                    </div>
                    <div class="menu-item light-red">
                        <a href="#about-modal" data-toggle="modal">
                            <i class="fa fa-user"></i>
                            <p>Help</p>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="menu-item color">
                        <a href="#service-modal" data-toggle="modal">
                            <i class="fa fa-area-chart"></i>
                            <p>Profit and Loss</p>
                        </a>
                    </div>
                    <div class="menu-item light-orange">
                        <a href="#team-modal" data-toggle="modal">
                            <i class="fa fa-users"></i>
                            <p>Milk Delivery</p>
                        </a>
                    </div>
                    <div class="menu-item purple">
                        <a href="AddSupplier.jsp" data-toggle="modal">
                            <i class="fa fa-usd"></i>
                            <p>Registration</p>
                        </a>
                    </div>                        
                </div>
                <div class="col-md-4">
                    <div class="menu-item light-red">
                        <a href="#contact-modal" data-toggle="modal">
                            <i class="fa fa-envelope-o"></i>
                            <p>Rate Calculator</p>
                        </a>
                    </div>
                    <div class="menu-item color">
                        <a href="#clients-modal" data-toggle="modal">
                            <i class="fa fa-comment-o"></i>
                            <p>Clients</p>
                        </a>
                    </div>
                    <div class="menu-item blue">
                        <a href="#news-modal" data-toggle="modal">
                            <i class="fa fa-edit"></i>
                            <p>Attendance</p>
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>    
</body></html>

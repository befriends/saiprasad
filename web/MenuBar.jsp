<!DOCTYPE html>
<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
   <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />
</head>
<body>
   <!-- bootstrap responsive multi-level dropdown menu -->
   <nav class="navbar navbar-inverse" role="navigation">
      <div class="container-fluid">
         <!-- header -->
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#multi-level-dropdown">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="Home.jsp">SmartDairy</a>
         </div>
         <!-- menus -->
         <div class="collapse navbar-collapse" id="multi-level-dropdown">
            <ul class="nav navbar-nav">
            <li><a href="#">Home</a></li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Master<b class="caret"></b></a>
               <ul class="dropdown-menu">
               <li class="dropdown-submenu">
                  <a href="#" tabindex="-1">Registration</a>
                  <ul class="dropdown-menu">
                  <li ><a href="AddSupplier.jsp">Customer</a></li>                          
                  <li ><a href="DairyRegistration.jsp">Dairy</a></li>
<!--                  <li><a href="#">Ceiling Lamps</a></li>
                  <li><a href="#">Table Lamps</a></li>-->
<!--                  <li class="dropdown-submenu">
                     <a href="#" tabindex="-1">Floor Lamps</a>
                     <ul class="dropdown-menu">
                     <li><a href="#">Living Room</a></li>
                     <li><a href="#">Bed Room</a></li>
                     <li><a href="#">Garden Lamps</a></li>
                     </ul>
                  </li>-->
                  </ul>
               </li>
               <li ><a href="getDaillyCollection.jsp">Daily Collection</a></li>
               <li ><a href="DaillySell.jsp">Daily Sell</a></li>
               <li ><a href="FoodSell.jsp">Food Sell</a></li>
               <li ><a href="MilkRateGenerator.jsp">Rate Generator</a></li>
               </ul>
            </li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Purchase<b class="caret"></b></a>
               <ul class="dropdown-menu">
                   <li ><a href="getDaillyCollection.jsp">Purchase Material</a></li>
               </ul>
            </li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Payment<b class="caret"></b></a>
               <ul class="dropdown-menu">
                   <li ><a href="CustomerBill.jsp">Customer Bill</a></li>
                   <li ><a href="DairyBill.jsp">Dairy Bill</a></li>
               </ul>
            </li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reports<b class="caret"></b></a>
               <ul class="dropdown-menu">
               <li ><a href="ReportController?act=1&submodule=datewise" target="_blank"> Daily Order Report</a></li>
               <li class="dropdown-submenu">
                  <a href="#" tabindex="-1">Sale</a>
                  <ul class="dropdown-menu">
                  <li ><a href="SelectDairyName.jsp">Dairy Bill Report</a></li>                          
                  <li ><a href="SelectDate.jsp">Date Report</a></li>                          
                  <li ><a href="SelectMonth.jsp" > Month Report</a></li>
<!--                  <li><a href="#">Ceiling Lamps</a></li>
                  <li><a href="#">Table Lamps</a></li>-->
<!--                  <li class="dropdown-submenu">
                     <a href="#" tabindex="-1">Floor Lamps</a>
                     <ul class="dropdown-menu">
                     <li><a href="#">Living Room</a></li>
                     <li><a href="#">Bed Room</a></li>
                     <li><a href="#">Garden Lamps</a></li>
                     </ul>
                  </li>-->
                  </ul>
               </li>
               <li class="dropdown-submenu">
                  <a href="#" tabindex="-1">Purchase</a>
                  <ul class="dropdown-menu">
                  <li><a href="CustomerName.jsp"> Customer Bill Report</a></li>
                  <li><a href="SelectCustomerName.jsp"> Customer Report</a></li>
                  <li><a href="SelectPurchaseDate.jsp">Date Report</a></li>
                  <li><a href="SelectPurchaseMonth.jsp">Month Report</a></li>
                  </ul>
               </li>
               </ul>
            </li>
            <li ><a href="login.jsp?logout=true">Log Out</a></li>
            </ul>
         </div>
      </div>
   </nav>
   <script src="js/jquery.js" type="text/javascript"></script>
   <script src="js/bootstrap.min.js" type="text/javascript"></script>
<!--   <script type="text/javascript">
    $('ul.nav li.dropdown').hover(function() {
      $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
    }, function() {
      $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
    });
    </script>-->
</body>
</html>
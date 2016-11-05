<!-- bootstrap responsive multi-level dropdown menu -->
<nav class="navbar navbar-inverse" style="background-color: saddlebrown; margin-bottom: 2px; color: black;" role="navigation">
      <div class="container-fluid">
         <!-- header -->
         <div class="navbar-header" style="width:20%;">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#multi-level-dropdown">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </button>
             <a class="navbar-brand" href="Home.jsp" style="width:100%; font-family: cursive;font-weight: bolder;text-align: center;background-color: tomato; color: Black;border-radius: 5em;">SmartDairy</a>
         </div>
         <!-- menus -->
         <div class="collapse navbar-collapse" id="multi-level-dropdown">
            <ul class="nav navbar-nav">
            <li><a href="Home.jsp">Home</a></li>
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
               <li class="dropdown-submenu">
                  <a href="#" tabindex="-1">Rate Chart</a>
                  <ul class="dropdown-menu">
<!--                  <li ><a href="AddSupplier.jsp">Purchase</a></li>                          
                  <li ><a href="DairyRegistration.jsp">Sell</a></li>-->
                <li class="dropdown-submenu">
                     <a href="#" tabindex="-1">Purchase</a>
                     <ul class="dropdown-menu">
                     <li><a href="ratechart.jsp?ispurchase=1&iscow=1" target="_blank">Cow</a></li>
                     <li><a href="ratechart.jsp?ispurchase=1&isbuffalo=1" target="_blank">Buffalo</a></li>
                     </ul>
                  </li>
                  <li class="dropdown-submenu">
                     <a href="#" tabindex="-1">Sell</a>
                     <ul class="dropdown-menu">
                         <li><a href="ratechart.jsp?issell=1&iscow=1" target="_blank">Cow</a></li>
                     <li><a href="ratechart.jsp?issell=1&isbuffalo=1" target="_blank">Buffalo</a></li>
                     </ul>
                  </li>
                  </ul>
               </li>
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
                  <li><a href="SelectCustomerName.jsp"> Customer Report</a></li>
                  <li><a href="SelectPurchaseDate.jsp">Date Report</a></li>
                  <li><a href="SelectPurchaseMonth.jsp">Month Report</a></li>
                  </ul>
               </li>
               </ul>
            </li>
            <li ><a href="Login.jsp?logout=true">Log Out</a></li>
            </ul>
         </div>
      </div>
   </nav>

<!--<div>
    <div class="rmm style" style="width: 90%;">
        <ul style="background-color: orangered ;width: 100%;">
            <li class="current-menu-item"><a href="home.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-king"></span> Master</a>
                <ul>
                    <li><a href="#"><span class="glyphicon glyphicon-plus"></span> Add</a>
                        <ul>
                            <li ><a href="AddSupplier.jsp">User Registration </a></li>                          
                            <li ><a href="DairyRegistration.jsp">Dairy registration </a></li>
                            <li ><a href="AddMenuItem.jsp">MenuItem</a></li>
                        </ul>
                    <li ><a href="AddMaterialStock.jsp">Material</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-plus"></span> Sell</a>
                        <ul>
                            <li ><a href="DaillySell.jsp">Daily Sell </a></li> 
                            <li ><a href="FoodSell.jsp">Food Sell </a></li>             

                        </ul>
                    <li ><a href="getDaillyCollection.jsp"><span class="glyphicon glyphicon-comment"></span> Daily Collection</a></li>
                    <li ><a href="DaillySell.jsp"><span class="glyphicon glyphicon-comment"></span> Daily Sell</a></li>
                    <li ><a href="FoodSell.jsp"><span class="glyphicon glyphicon-comment"></span> Food Sell</a></li>
                    <li ><a href="MilkRateGenerator.jsp"><span class="glyphicon glyphicon-comment"></span> Rate Generator</a></li>
                    
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-list"></span> Order</a>
                <ul>
                    <li class="dir"><a href="GetMilk.jsp"><span class="glyphicon glyphicon-edit"></span> Get Milk</a></li>
                    <li class="dir"><a href="TableDashboard.jsp" target="_blank"><span class="glyphicon glyphicon-list-alt"></span> Current Order List</a></li>
                </ul>
            </li>
            <li><a href="#">Purchase</a>
                <ul>
                    <li class="dir"><a href="PurchaseFood.jsp">Purchase Material</a></li>
                    <li class="dir"><a href="AddExpenceMaterial.jsp">Expense Material</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-piggy-bank"></span> Payment</a>
                <ul>
                    <li class="dir"><a href="CustomerBill.jsp">Make Payment</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-tasks"></span> Reports</a>
                <ul>
                    <li class="dir"><a href="ReportController?act=1&submodule=datewise" target="_blank"> Daily Order Report</a></li>
                    <li class="dir"><a href="SelectDateAndAllTableList.jsp"> Table Wise Report</a></li>
                    <li><a href="#">Sales</a>
                        <ul>
                            <li class="dir"><a href="SelectDate.jsp">Date Report</a></li>
                            <li class="dir"><a href="SelectMonth.jsp" > Month Report</a></li>
                            <li class="dir"><a href="SelectYear.jsp" >Year Report</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Purchase</a>
                        <ul>
                            <li class="dir"><a href="SelectCustomerName.jsp"> Customer Report</a></li>
                            <li class="dir"><a href="SelectPurchaseDate.jsp">Date Report</a></li>
                            <li class="dir"><a href="SelectPurchaseMonth.jsp">Month Report</a></li>
                            <li class="dir"><a href="SelectPurchaseYear.jsp">Year Report</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Expense</a>
                        <ul>
                            <li class="dir"><a href="ExpenseMaterialName.jsp">Material Report</a></li>
                            <li class="dir"><a href="ExpenseMaterialDate.jsp">Date Report</a></li>
                            <li class="dir"><a href="ExpenseMaterialMonth.jsp">Month Report</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Payment</a>
                        <ul>
                            <li class="dir"><a href="SelectPaymentDate.jsp">Date Report </a></li>
                            <li class="dir"><a href="SelectPaymentEmployee.jsp">Employee Report </a></li>
                        </ul>
                    </li>
                    <li class="dir"><a href="CancelOrderDetails.jsp"> Cancel Report</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-user"></span> Profile </a>
                <ul>
                    <li><a href="AddSupplier.jsp">Create User</a></li>
                    <li><a href="DairySellForm.jsp">Dairy Registration</a></li>
                </ul>
            </li>
            <li><a href="login.jsp?logout=true"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
    </div>
</div>-->
<div style="text-align: center;width: 90%;margin-left: auto;margin-right: auto;">
    <!--<img src="images/header7.jpg" style="height: 150px; width: 100%;" alt="Header Image" />-->
</div>
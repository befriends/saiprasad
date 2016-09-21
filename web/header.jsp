
<div>
    <div class="rmm style" style="width: 90%;">
        <ul style="background-color: orangered ;width: 100%;">
            <li class="current-menu-item"><a href="home.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-king"></span> Master</a>
                <ul>
                    <li><a href="#"><span class="glyphicon glyphicon-plus"></span> Add</a>
                        <ul>
                            <li ><a href="AddSupplier.jsp">Registration</a></li>                          
                            <li ><a href="AddSubCategory.jsp">Sub-Category</a></li>
                            <li ><a href="AddMenuItem.jsp">MenuItem</a></li>
                        </ul>
                    <li ><a href="AddMaterialStock.jsp">Material</a></li>
                    <li ><a href="AddMessage.jsp"><span class="glyphicon glyphicon-comment"></span> Messages</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-list"></span> Order</a>
                <ul>
                    <li class="dir"><a href="GetOrder.jsp"><span class="glyphicon glyphicon-edit"></span> Get Order</a></li>
                    <li class="dir"><a href="TableDashboard.jsp" target="_blank"><span class="glyphicon glyphicon-list-alt"></span> Current Order List</a></li>
                </ul>
            </li>
            <li><a href="#">Purchase</a>
                <ul>
                    <li class="dir"><a href="AddPurchaseMaterial.jsp">Purchase Material</a></li>
                    <li class="dir"><a href="AddExpenceMaterial.jsp">Expense Material</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-piggy-bank"></span> Payment</a>
                <ul>
                    <li class="dir"><a href="MakePayment.jsp">Make Payment</a></li>
                </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-tasks"></span> Reports</a>
                <ul>
                    <li class="dir"><a href="ReportController?act=1&submodule=datewise" target="_blank"> Daily Order Report</a></li>
                    <li class="dir"><a href="SelectDateAndAllTableList.jsp"> Table Wise Report</a></li>
                    <li><a href="#">Sales</a>
                        <ul>
                            <li class="dir"><a href="SelectDate.jsp">Date Report</a></li>
                            <li class="dir"><a href="SelectMonthAndYear.jsp" > Month Report</a></li>
                            <li class="dir"><a href="SelectYear.jsp" >Year Report</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Purchase</a>
                        <ul>
                            <li class="dir"><a href="PurchaseMaterialName.jsp"> Material Report</a></li>
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
                    <li><a href="AddEmployeeDetails.jsp">Employee Profile</a></li>
                </ul>
            </li>
            <li><a href="login.jsp?logout=true"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
    </div>
</div>

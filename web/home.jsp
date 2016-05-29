<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="css/normalize.css">
        <title>Home Page</title>
    </head>

    <body>
        <div class="main_container" style="height: 600px;">

            <div>
                <img src="" title="Welcome To SmartHotel" alt="Welcome To SmartHotel" style="width: 100%;height: 10%;">
            </div>

            <!--Menu-->

            <div>
                <hr>
                <nav id="primary_nav_wrap" style="width: 100%;">
                    <ul>
                        <li class="current-menu-item"><a href="#">Home</a></li>

                        <li><a href="#">Product</a>
                            <ul>
                                <li ><a href="Addsupplier.jsp">Category</a></li>                          
                                <li ><a href="AddSubCategory.jsp">Sub-Category</a></li>
                                <li ><a href="AddMenuItem.jsp">Menu Item</a></li>
                            </ul>
                        </li>
                        <li><a href="#">Sales</a>
                            <ul>
                                <li class="dir"><a href="#">Sales List</a></li>
                                <li class="dir"><a href="#">Sales Return</a></li>
                                <li class="dir"><a href="#">Day End</a></li>

                            </ul>
                        </li>
                        <li><a href="#">Payment</a></li>
                        <li><a href="#">Reports</a>
                            <ul>
                                <li><a href="#">Order Report</a></li>
                                <li><a href="#">Sales Report</a></li>
                                <li><a href="#">Payment Report</a></li>
                            </ul>
                        </li>
                        <li><a href="#">Profile </a>
                            <ul>
                                <li><a href="AddUser.jsp">UserProfile</a></li>
                                <li><a href="#">Table</a></li>
                                <li><a href="login.jsp">Logout</a></li>
                            </ul>
                        </li>

                        <li><a href="#">Contact Us</a></li>
                    </ul>
                </nav>
                <hr>
            </div>
            <div>
                <strong>
                    <%
                        if (request.getParameter("msg") != null) {
                    %><%=request.getParameter("msg")%><%
                        }
                    %>
                </strong>
            </div>

        </div>
    </body>
</html>

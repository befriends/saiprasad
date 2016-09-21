
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>



<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <!--style for menu-->
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>

        <script type="text/javascript" src="js/jquery.js"></script> 
        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Home Page</title>
    </head>

    <body style="background-color: #555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; margin-top: -20px; width: 100%; height: 100px; background-color: antiquewhite;">
                    <%
                        if (session.getAttribute("UserName") != null) {
                    %>
                    <div style="text-align: center;"><br><h3>Welcome <font style="font-family: arial; font-size: 30px; font-weight: bold; color: maroon; text-decoration: underline;"><%=session.getAttribute("UserName")%></font></h3></div>
                            <%
                            } else {
                            %>
                    <strong><%=request.getParameter("msg")%></strong>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>

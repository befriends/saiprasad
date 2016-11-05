<%-- 
    Document   : PurchaseFood
    Created on : 7 Sep, 2016, 11:06:06 AM
    Author     : sai
--%>
<%@page import="DaoImpl.PurchaseSellDaoImpl"%>
<%@page import="Dao.PurchaseSellDao"%>
<%@page import="DaoImpl.MilkSupplierDaoImpl"%>
<%@page import="Dao.MilkSupplierDao"%>
<%@page import="DaoImpl.CommonDaoImpl"%>
<%@page import="Dao.CommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONObject"%>
<%!
    String message = "";
%>
<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Form </title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">
        <!--style for menu-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />

        <!--script for menu-->
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->
        <!--<script type="text/javascript" src="js/calendar.js"></script>-->
        <script src="js/bootstrap.min.js"></script>
    </head>
    <script>

        function numbersonly(e) {
            var unicode = e.charCode ? e.charCode : e.keyCode
            if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
                if ((unicode < 48 || unicode > 57) && (unicode < 9 || unicode > 10) && (unicode < 37 || unicode > 39)) //if not a number
                    return false //disable key press
            }
        }
        function limitlength(obj, length) {
            var maxlength = length
            if (obj.value.length > maxlength)
                obj.value = obj.value.substring(0, maxlength)
        }
        
            function autoDate() {
                var tDay = new Date();
                var tMonth = tDay.getMonth() + 1;
                var tDate = tDay.getDate();
                if (tMonth < 10)
                    tMonth = "0" + tMonth;
                if (tDate < 10)
                    tDate = "0" + tDate;
                document.getElementById("datepicker").value = tDate + "/" + tMonth + "/" + tDay.getFullYear();
            }

            function addLoadEvent(func) {
                var oldonload = window.onload;
                if (typeof window.onload != 'function') {
                    window.onload = func;
                } else {
                    window.onload = function() {
                        if (oldonload) {
                            oldonload();
                        }
                        func();
                    }
                }
            }

            addLoadEvent(function() {
                autoDate();
            });
            $(document).ready(function ()
            {
            $("#datepicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
});

            function resetform() {
                document.getElementById("orderform").reset();
            }
    </script>
    <!--<style type="text/css">	
    </style>-->
    <body style="background-color:#555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color:powderblue;">
                    <!--<form action method="post">-->
                    <%
                        if (request.getParameter("result") != "" && request.getParameter("result") != null) {
                            JSONObject jobj = new JSONObject(request.getParameter("result"));
                            message = jobj.getString("message");
                            if (jobj.getBoolean("success")) {
                    %><div class="alert alert-success fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" title="close">×</a>
                        <strong>Success!</strong> Indicates a successful or positive action.
                    </div><%
                    } else {
                    %><div class="alert alert-danger fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" title="close">×</a>
                        <strong>Success!</strong> Indicates a successful or positive action.
                    </div><%
                            }
                        }

                        HashMap<String, String> params = new HashMap<String, String>();
                        params.put("submodule", "purchasefood"); // Database Table Name
                        params.put("columnname", "code"); // Database Column Name
                        CommonDao commonDaoObj = new CommonDaoImpl();
                        String id = commonDaoObj.generateNextID(params);

                        PurchaseSellDao purchaseDAOObj = new PurchaseSellDaoImpl();
//                            JSONObject jsonList = milkDAOObj.getMaterialList();

                    %>
                    <%!
                        JSONObject jobj = null;
                    %>


                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Purchase Food Form</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="dailyCollection" method="post"  onkeypress="myFunction()" onsubmit="return validate()">
                                <table width="140">
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="userid" class="control-label col-sm-3">Custom Id: </label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="codeid" name="code" value="<%=id%>" readonly="true" />
                                                </div>

                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-inline">

                                                <label for="date" class="control-label col-sm-3">Purchase Date: </label>                                       

                                                <div class="col-sm-8">
                                                    <input type="text" class="date-picker" id="datepicker" placeholder="Enter Date" name="date" value="" required="" size=""/>
                                                </div>

                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">

                                                <label for="companyname" class="control-label col-sm-3">Company Name:</label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="companyname" placeholder="Enter Company Name" name="companyname" autofocus="true" required=""/>
                                                </div>

                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-inline">

                                                <label for="foodname" class="control-label col-sm-3">Food Name:</label>


                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="foodname" name="foodname" placeholder="Enter Food Name" required=""/>
                                                </div>

                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">

                                                <label for="quantity" class="control-label col-sm-3">Quantity:</label>


                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="quantity" placeholder="Enter quantity" name="quantity" required=""/>
                                                </div>

                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-inline">
                                                <label for="purchaserate" class="control-label col-sm-3">Purchase Rate:</label>


                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="purchaserate" placeholder="Enter Purachase Rate" name="purchaserate"  required=""/>
                                                </div>

                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="sellrate" class="control-label col-sm-3">Sell Rate:</label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="sellrate" placeholder="Enter Sell Rate" name="sellrate" required=""/>
                                                </div>

                                            </div>

                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="sub total" class="control-label col-sm-3">Sub Total:</label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="subtotal" placeholder="Enter SubTotal" name="subtotal" required=""/>
                                                </div>

                                            </div>
                                        <td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="discount" class="control-label col-sm-3">Discount:</label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="discount" placeholder="Enter Discount" name="discount" required=""/>
                                                </div>

                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="totalamount" class="control-label col-sm-3">Total Amount:</label>

                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="totalamount" placeholder="Enter Discount" name="totalamount" required=""/>
                                                </div>

                                            </div>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <div class="form-group">
                                                <div class="col-sm-offset-5 col-sm-10">
                                                    <button type="submit" name="submit" value="Add" class="btn btn-default">Add</button>
                                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                                    <button  type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                                </div>
                                            </div>
                                        </td>

                                    </tr>
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="PurchaseFood" />

                                </table>
                            </form>


                        </fieldset>    

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
<%-- 
    Document   : FoodSell
    Created on : 10 Sep, 2016, 5:02:04 PM
    Author     : sai
--%>


<%@page import="DaoImpl.SellDaoImpl"%>
<%@page import="Dao.SellDao"%>
<%@page import="DaoImpl.PurchaseSellDaoImpl"%>
<%@page import="Dao.PurchaseSellDao"%>
<%@page import="org.json.JSONObject"%>
<%@page import="DaoImpl.CommonDaoImpl"%>
<%@page import="Dao.CommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String message = "";
%>
<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />
        <!--script for menu-->
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->
        <script src="js/bootstrap.min.js"></script>  
        <script src="js/commonFunction.js"></script>
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" lang="javascript" >
            function loadSubCategory() {
                var parentComboId = 'customername';
                var childComboId = 'milktype';
                var url = 'dailyCollection';
                var submodule = 'Purchase';
                loadComboValues(parentComboId, childComboId, url, submodule);


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


            function resetform() {
                document.getElementById("orderform").reset();
            }

        </script>

    </head>
    <body  style="background-color:#555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color:powderblue;">
                    <%  //                                                           Only for  Disply message after execution
                        if (request.getParameter("result") != "" && request.getParameter("result") != null) {
                            JSONObject jobj = new JSONObject(request.getParameter("result"));
                            message = jobj.getString("message");
                            if (jobj.getBoolean("success")) {
                    %>          <span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: crimson;"><%=message%></h3></span><br /><%
                    } else {
                        %>      <span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: red;"><%=message%></h3></span><br /><%
                                }
                            }   /// End

                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("submodule", "foodsell"); // Database Table Name
                            params.put("columnname", "code"); // Database Column Name
                            CommonDao commonDaoObj = new CommonDaoImpl();
                            String id = commonDaoObj.generateNextID(params);

                            SellDao sellDaoObj = new SellDaoImpl();

                            JSONObject JsonList = sellDaoObj.getCategoryList();
                        %>
                        <%!
                            JSONObject jobj = null;
                        %>



                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Food Sell</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="SellController" method="post">
                                <table>
                                    <tr>
                                        <td>                      <div class="form-group">
                                                <label for="customid" class="control-label col-sm-3">Custom Id: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="customid" name="customid" value="<%=id%>" readonly="true" />
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <label for="date" class="control-label col-sm-3">Date: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="date-picker" id="datepicker" placeholder="Enter Date" name="date" value="" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group" >
                                                <label for="customername" class="control-label col-sm-3">Customer Name:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="customername" placeholder="Enter Quantity " name="customername" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>


                                            <div class="form-group">
                                                <label for="foodname"class="control-label col-sm-3">Food Name :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="foodname" placeholder="" name="foodname" onchange="loadSubCategory()" required="">
                                                        <option value="">--Please Select Name--</option>
                                                        <%                    JSONArray jarr = JsonList.getJSONArray("data");
                                                            for (int cnt = 0; cnt < jarr.length(); cnt++) {
                                                                jobj = jarr.getJSONObject(cnt);

                                                        %>
                                                        <option value="<%=jobj.getLong("purchaseid")%>"><%=jobj.getString("foodname")%></option>

                                                        <%
                                                            }
                                                        %>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <label for="sellrate"class="control-label col-sm-3">Sell Rate :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="sellrate" placeholder="Enter Sell Rate" name="sellrate" required="">
                                                    <!--                                        <select class="form-control" id="sellrate" placeholder="" name="sellrate"  required="">
                                                                                                <option value="">--Please Select Type--</option>
                                                    <% //  JSONArray jarr1 = subCategoryJsonList.getJSONArray("data");
                                                        //                                                for (int cnt = 0; cnt < jarr1.length(); cnt++) {
                                                        //                                                    jobj = jarr1.getJSONObject(cnt);

                                                    %>
            
            
                                                    <%// 

                                                    %>
                                                </select> -->
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group" >
                                                <label for="quantity" class="control-label col-sm-3">Quantity:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="quantity" placeholder="Enter Quantity " name="quantity" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                            <div class="form-group" >
                                                <label for="subtotal" class="control-label col-sm-3">Sub-Total:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="subtotal" placeholder="Enter Sub Total" name="subtotal" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group" >
                                                <label for="discount" class="control-label col-sm-3">Discount:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="discount" placeholder="Enter Discount" name="discount" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group" >
                                                <label for="totalamount" class="control-label col-sm-3">Total Amount:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="totalamount" placeholder="Enter Total Amount" name="totalamount" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <label for="current bill"class="control-label col-sm-3">Current Bill :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="currentbill" placeholder="" name="currentbill">
                                                        <option value="">--Please Select Designation--</option>
                                                        <option value=""></option>
                                                        <option value=""></option>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" name="submit" value="Add" class="btn btn-default">Add </button>
                                            <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                            <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                        </div>
                                    </div>
                                            <td>
                                    </tr>
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="FoodSell" />
                                </table>
                            </form>
                        </fieldset>


                        </body>
                        </html>

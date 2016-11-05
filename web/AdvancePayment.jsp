<%-- 
    Document   : AdvancePayment
    Created on : 16 Oct, 2016, 12:38:01 PM
    Author     : sai
--%>


<%@page import="org.json.JSONArray"%>
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
        <title>Advance Payment </title>
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
         <style type="text/css">
            input[type="text"] {
            width: 230px;
            }
            label{
                font-size: 14px;
               
            }
            button{
                width: 5em;
            }
        </style>
    </head>
    <script type="text/javascript" lang="javascript">
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
        $(document).ready(function()
        {
            $("#datepicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });

        function resetform() {
            document.getElementById("advancepayment").reset();
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

                        PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();

                        JSONObject JsonList = purchaseDaoObj.getMilkmandetailsList();

                    %>
                    <%!
                        JSONObject jobj = null;
                    %>

                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Advance Payment </span>

                    <div style="max-height: 600px;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="advancepayment" class="form-horizontal" action="MilkSupplierController" method="post"  onkeypress="myFunction()" onsubmit="return validate()">
                                <table style=width:100%;">
                                    <tr>                                       
                                        <td>
                                            <div class="form-inline">
                                                <label for="date" class="control-label col-sm-3"style="font-size: 14px;"> Date : </label>                                       
                                                <div class="col-sm-8">
                                                    <input type="text" class="date-picker" style="width: 230px;" id="datepicker" placeholder="--- Enter Date ---" name="datepicker" value="" required="" size=""/>
                                                </div>
                                            </div>
                                        </td>                                   
                                        <td>
                                            <div class="form-inline">
                                                <label for="personname"class="control-label col-sm-3" style="font-size: 14px;">Person Name :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="personname" style="width: 230px;" placeholder="" name="personname"  required="">
                                                        <option value="">--Please Select Name--</option>
                                                        <% JSONArray jarr = JsonList.getJSONArray("data");
                                                            for (int cnt = 0; cnt < jarr.length(); cnt++) {
                                                                jobj = jarr.getJSONObject(cnt);

                                                        %>
                                                        <option value="<%=jobj.getString("milkmanid")%>"><%=jobj.getString("fullname")%></option>

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
                                            <div class="form-inline">
                                                <label for="amount" class="control-label col-sm-3"style="font-size: 14px;">Amount :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="width: 230px;" id="amount" name="amount" placeholder="--- Enter Amount ---" required=""/>
                                                </div>
                                            </div>
                                        </td>                                    
                                        <td>
                                            <div class="form-inline">
                                                <label for="reason" class="control-label col-sm-3"style="font-size: 14px;">Reason :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="font-size: 13px;width: 230px;" id="reason" placeholder="--- Enter Reason ---" name="reason" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">

                                                <label for="contactpersonname" class="control-label col-sm-3"style="font-size: 14px;">Contact Person:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="contactpersonname" style="width: 230px;" placeholder="--- Contact Person Name ---" name="contactpersonname"  required=""/>
                                                </div>
                                            </div>
                                        </td>                                       
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <div class="col-sm-offset-5 col-sm-10">
                                                    <button type="submit" name="submit" value="Add"  class="btn btn-success">Add</button>
                                                    <button  type="button" name="cancel" value="Cancel"  class="btn btn-danger col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-primary col-sm-offset-1">Reset</button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="advancepayment" />

                                </table>
                            </form>
                        </fieldset>    
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
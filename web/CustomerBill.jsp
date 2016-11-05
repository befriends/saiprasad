<%-- 
    Document   : CustomerBill
    Created on : 2 Oct, 2016, 2:36:44 PM
    Author     : sai
--%>


<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%--<%@page import="java.sql.Date"%>--%>
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
    String DATE_FORMAT_NOW = "dd/MM/yyyy";
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
    String stringDate = sdf.format(date);

    String userID = "";
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
        <title>Customer Bill</title>
        <script type="text/javascript" src="js/jquery.min.js"></script> 
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">
        <!--style for menu-->
        <!--<link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />
        <!--script for menu-->
        <script src="js/commonFunctions.js"></script>
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->
        <script src="js/bootstrap.min.js"></script>      
        <script type="text/javascript" lang="javascript" >
            function loadSubCategory(parentcomboId, setvaluecomboId) {
                var parentComboId = parentcomboId;

                var selectedId = $("#" + parentComboId).val();
                var parentComboName = document.getElementById(parentComboId).name;
                var url = 'dailyCollection';
                var submodule = 'StartDate';
//                loadComboValues(parentComboId, childComboId, url, submodule);
                $.ajax({
                    url: url + "?act=4&submodule=" + submodule + "&" + parentComboName + "=" + selectedId, // act=4 => action 4 is for getting values from DB.
                    context: document.body,
                    success: function(responseobj) {
                        var jsonObj = JSON.parse(responseobj).data;
                        var issuccess = JSON.parse(responseobj).isSuccess;
                        if (issuccess) {
//                        startDate = jsonObj[0];
                            var startdate = jsonObj[0];
                            $("#startdate").val(startdate);
                            //setter
                            var year = startdate.split("/")[2];
                            var month = startdate.split("/")[1];
                            var day = startdate.split("/")[0];
                            $( "#enddate" ).datepicker( "option", "minDate", new Date(year+"/"+month+"/"+day) );

                        }
                        var selectedValue = $("#" + parentcomboId).val();
                        $("#" + setvaluecomboId).val(selectedValue);
                    }
                });
            }
           $(document).ready(function() {
               
               

                $("#enddate").datepicker({
                    dateFormat: 'dd/mm/yy',
                    maxDate: new Date(),
                   onSelect: function() {
                       $.ajax({
                            url: "dailyCollection",
                            context: document.body,
                            method: "POST",
                            data: {
                                enddate : $("#enddate").val(),
                                startdate : $("#startdate").val(),
                                milkmanid : $("#milkmanid").val(),
                                act: 4,
                                submodule:"billdetails"
                            },
                            success: function(responseObj) {
                                var response = JSON.parse(responseObj).data;
                                $("#billingdetailstable tr td").remove();
                                var billDetailsTable = $("#billingdetailstable");
                                var totalamount = 0;
                                var totalmilk = 0;
                                for(var ind = 0; ind < response.length; ind++){
                                    var tr = document.createElement("tr");
                                    var td1 = document.createElement("td");
                                    td1.innerHTML = ind + 1;
                                    tr.appendChild(td1);
                                    var td2 = document.createElement("td");
                                    td2.innerHTML = response[ind].date;
                                    tr.appendChild(td2);
                                    var td3 = document.createElement("td");
                                    td3.innerHTML = response[ind].type;
                                    tr.appendChild(td3);
                                    var td4 = document.createElement("td");
                                    td4.innerHTML = response[ind].fat;
                                    tr.appendChild(td4);
                                    var td5 = document.createElement("td");
                                    td5.innerHTML = response[ind].lacto;
                                    tr.appendChild(td5);
                                    var td6 = document.createElement("td");
                                    td6.innerHTML = response[ind].snf;
                                    tr.appendChild(td6);
                                    var td7 = document.createElement("td");
                                    td7.innerHTML = response[ind].totalmilk;
                                    tr.appendChild(td7);
                                    totalmilk += response[ind].totalmilk;
                                    var td8 = document.createElement("td");
                                    td8.innerHTML = response[ind].rate;
                                    tr.appendChild(td8);
                                    var td9 = document.createElement("td");
                                    td9.innerHTML = response[ind].totalamount;
                                    tr.appendChild(td9);
                                    totalamount += response[ind].totalamount;

                                    billDetailsTable.append(tr);
                                }
                                $("#totalliter").val(totalmilk);
                                $("#subtotal").val(totalamount);
                                $("#tamount").val(totalamount);
                            }
                        });
                    }
                });
            });

            $(document).ready(function() {
                $("#commissionid").change(function() {
                    var totalAmount = parseFloat($("#tamount").val() === "" ? "0" : $("#tamount").val());
                    if(totalAmount > 0){
                        var commission = parseFloat($("#commissionid").val() === "" ? "0" : $("#commissionid").val());
                        var totalliter = parseInt($("#totalliter").val());
                        var totcommission = commission * totalliter;
                        $("#totalcommission").val(totcommission);
                        calculateTotal();
//                        var totalCommission = totcommission;
//                        var subTotal = parseFloat($("#subtotal").val());
//                        var amountAfterDeduction = (subTotal + totalCommission);
//                        $("#tamount").val(amountAfterDeduction);
                    } else{
                        $("#commissionid").val("");
                    }
                });
                $("#deductionid").change(function() {
                    var totalAmount = parseFloat($("#tamount").val() === "" ? "0" : $("#tamount").val());
                    if(totalAmount > 0){
                        var deductionAmount = parseFloat($("#deductionid").val() === "" ? "0" : $("#deductionid").val());
                        $("#totaldeduction").val(deductionAmount);
                        calculateTotal();
//                        var subTotal = parseFloat($("#subtotal").val());
//                        var amountAfterDeduction = subTotal - deductionAmount;
//                        $("#tamount").val(amountAfterDeduction);
                    } else{
                        $("#deductionid").val("");
                    }
                });
            });
            
            function calculateTotal(){
                var totalAmount = parseFloat($("#tamount").val() === "" ? "0" : $("#tamount").val());
                if(totalAmount > 0){
                    var subTotal = parseFloat($("#subtotal").val());
                    var totalliter = parseInt($("#totalliter").val());
                    var commission = parseFloat($("#commissionid").val() === "" ? "0" : $("#commissionid").val());
                    var deductionAmount = parseFloat($("#deductionid").val() === "" ? "0" : $("#deductionid").val());
                    var totalCommission = commission * totalliter;
                    
                    var finalAmount = ((subTotal - deductionAmount) + totalCommission);
                    $("#tamount").val(finalAmount);
                } else{
                    $("#commissionid").val("");
                    $("#deductionid").val("");
                }
            }


            function resetform() {
                document.getElementById("customerbillform").reset();
            }
        </script>
        <style type="text/css">
            .gridrowheight td{
                line-height: 5px;
            }

        </style>
    </head>
    <%!
        JSONObject jobj = null;
    %>
    <body  style="background-color:#555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color:powderblue;">
                    <%  // Only for  Disply message after execution
                        if (request.getParameter("result") != "" && request.getParameter("result") != null) {
                            JSONObject jobj = new JSONObject(request.getParameter("result"));
                            message = jobj.getString("message");
                            if (jobj.getBoolean("success")) {
                    %>          <span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: crimson;"><%=message%></h3></span><br /><%
                    } else {
                        %>          <span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: red;"><%=message%></h3></span><br /><%
                                }
                            }   /// End

                            PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();

                            JSONObject JsonList = purchaseDaoObj.getMilkmandetailsList();
                            String startDate = request.getParameter("startDate");
                            String milkManId = request.getParameter("milkManId");

                            String selectedDate = "";
                            if (request.getParameter("selectedDate") == null) {
                                selectedDate = stringDate;
                            } else {
                                selectedDate = request.getParameter("selectedDate");
                            }
                        %>
                       <div>
                           <img src="images/Milk.jpg" alt="" width="1110" height="110" />
                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Customer Bill Generation Form</span>
                       </div>

                    <div style="max-height: 600px;font-size: 10px;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="customerbillform" class="form-horizontal" action="dailyCollection" method="post">
                                <table style="width:100%;">
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="customid" class="control-label col-sm-3">MilkMan Id : </label> 
                                                <div class="col-sm-8 text-left">
                                                    <!--<input type="text" class="form-control" id="customid" name="milkid" required=""/>-->
                                                    <select class="form-contol" id="milkmanid" placeholder="" name="milkmanid" onchange="loadSubCategory('milkmanid', 'milkmanname')" required="">
                                                        <option value="" selected="true">--Please Select ID--</option>
                                                        <%  JSONArray jarr = JsonList.getJSONArray("data");
                                                            for (int cnt = 0; cnt < jarr.length(); cnt++) {
                                                                jobj = jarr.getJSONObject(cnt);
                                                        %>
                                                        <option value="<%=jobj.getString("milkmanid")%>"><%=jobj.getString("code")%></option>
                                                        <%
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="cusname" class="control-label col-sm-3">Name : </label>
                                                <div class="col-sm-8 text-left">
                                                    <select class="form-control" style="font-size: 10px;" id="milkmanname" placeholder="" name="milkmanname" onchange="loadSubCategory('milkmanname', 'milkmanid')" required="">
                                                        <option value="">--Please Select Name--</option>
                                                        <% //                    JSONArray jarr = JsonList.getJSONArray("data");
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
                                                <label for="startdate" class="control-label col-sm-3">Starting Date : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" id="startdate" placeholder="Stariting Date" name="startdate" value="" readonly="true" required=""/>

                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="enddate" class="control-label col-sm-3" >Ending Date : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" class="date-picker" selected="true" id="enddate" name="enddate" value="" placeholder="--- Select End Date ---" required="" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="text"class="control-label col-sm-3">Commission : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" id="commissionid" placeholder="0.00" name="commissionid" value=""/>

                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="text"class="control-label col-sm-3">Deduction : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" id="deductionid" placeholder="0.00" name="deductionid" value="" />

                                                </div>
                                            </div>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="text"class="control-label col-sm-3">Remark : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" id="remarkid" placeholder="Remark" name="remarkid" value="" required=""/>

                                                </div>
                                            </div>
                                        </td>
                                    </tr>                                                                       
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="AddDaillySell" />
                                </table>
                            </form>
                        </fieldset>

                        <%
                            double grandTotal = 0.00;
                            double grandMilkTotal = 0.00;
                            JSONObject milkBillList = purchaseDaoObj.getMilkbilldetails(startDate, selectedDate, milkManId);
                            JSONArray itemarr = milkBillList.getJSONArray("data");
                            if (milkBillList != null && milkBillList.has("success") && milkBillList.has("data")) {
                                itemarr = milkBillList.getJSONArray("data");
                            }
                        %>

                        <div class="container-fluid" style="height: 350px;overflow: scroll;text-align: center;">
                            <table class="table table-condensed table-bordered table-hover" style="table-layout:fixed;" id="billingdetailstable" >
                                <thead>
                                    <tr class="gridrowheight">
                                        <th style="display: none;">ID</th>
                                        <th style="width: 5%;text-align: center;">Sr. No.</th>
                                        <th style="width: 10%;">Date</th>
                                        <th style="width: 8%;">Type</th>
                                        <th style="width: 7%;">Fat</th>
                                        <th style="width: 10%;"> Lactose</th>
                                        <th style="width: 10%;">S.N.F</th>
                                        <th style="width: 10%;">Liter</th>
                                        <th style="width: 7%;">Rate</th>
                                        <th style="width: 13%;">Amount</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <%
                                        int cnt = 0;
                                        double totalAmount = 0.00;
                                        for (cnt = 0; cnt < itemarr.length(); cnt++) {
                                            JSONObject obj = itemarr.getJSONObject(cnt);
                                            totalAmount = Double.parseDouble(obj.getString("totalamount"));
                                            double totalMilk = Double.parseDouble(obj.getString("totalmilk"));


                                    %>
                                <tr class="success gridrowheight" id="recordid<%=cnt%>">
                                    <td style="display: none;">
                                        <label id="purchaseid" style="display: none;"><%=obj.getString("purchaseid")%></label>
                                        <label id="submodule" style="display: none;">sell entry</label>
                                    </td>
                                    <td><label><%=cnt + 1%></label></td>
                                    <td><label name="date"><%=obj.get("date")%></label></td>
                                    <td><label name="type"><%=obj.get("type")%></label></td>
                                    <td><label name="fat"><%=obj.get("fat")%></label></td>
                                    <td><label name="lacto"><%=obj.get("lacto")%></label></td>
                                    <td><label name="snf"><%=obj.get("snf")%></label></td>
                                    <td><label name="totalmilk"><%=obj.get("totalmilk")%></label></td>
                                    <td><label name="rate"><%=obj.get("rate")%></label></td>
                                    <td><label name="totalamount"><%=obj.get("totalamount")%></label></td>
                                </tr>  

                                <%

                                        grandTotal += totalAmount;
                                        grandMilkTotal += totalMilk;
                                    }
                                %>
                                </tbody>
                            </table>                        
                        </div>
                        <div>
                            <!--Buttons--> 

                            <table style="width: 100%;">
                                <tr>                                    

                                    <td>
                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Commission: </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="totalcommission" placeholder="0.00" name="totalcommission" value="" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Total Milk: </label>
                                            <div class="col-sm-9 text-left">
                                                <input type="text" id="totalliter" placeholder="0.00" name="totalliter" value="<%=grandMilkTotal%>" required="" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Deduction: </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="totaldeduction" placeholder="0.00" name="deduction" value="" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Total: </label>
                                            <div class="col-sm-8">
                                                <input type="hidden" id="subtotal" placeholder="0.00" name="subtotal" readonly="true"/>
                                                <input type="text" id="tamount" placeholder="0.00" name="tamount" readonly="true"/>
                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td><td></td>
                                </tr>
                            </table>
                                               
                                <div class="form-group"> 
                                <div class="col-sm-offset-3 col-sm-10" style="padding-top: 10px;padding-bottom: 10px;">
                                    
                                    <button type="submit" name="submit" id="submit" value="Add"  onclick="generatebill()" style="width: 7em;" class="btn btn-success">Generate </button>&nbsp;&nbsp;
                                     <button type="button" onclick="printbill()" target=_blank" style="width: 7em;" onclick="generatebill()" class="btn btn-warning " >Print Bill</button>&nbsp;&nbsp;
                                    <button type="button" name="cancel" value="Cancel" class="btn btn-danger" style="width: 7em; onClick="window.location = 'Home.jsp'">Cancel</button>&nbsp;&nbsp;
                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel"  style="width: 7em;" class="btn btn-primary">Reset</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type = "text/javascript" src = "js/GridViewUserController.js" ></script> 
        <script type="text/javascript" lang="javascript">
            function generatebill(){
                if($("#tamount").val() !== "" && $("#tamount").val() !== "0" && $("#totalliter").val() !== "" && $("#totalliter").val() !== "0"){
                    $.ajax({
                        url: "BillingController",
                        context: document.body,
                        method: "POST",
                        data: {
                            milkmanid : $("#milkmanid").val(),
                            milkmanname : $("#milkmanname").val(),
                            startdate : $("#startdate").val(),
                            enddate : $("#enddate").val(),
                            commission : $("#commissionid").val() === "" ? "0" : $("#commissionid").val(),
                            deduction : $("#deductionid").val() === "" ? "0" : $("#deductionid").val(),
                            remarks : $("#remarkid").val(),
                            subtotal : $("#subtotal").val(),
                            totalamount : $("#tamount").val(),
                            totalcommission : $("#totalcommission").val() === "" ? "0" : $("#totalcommission").val(),
                            totaldeduction : $("#totaldeduction").val() === "" ? "0" : $("#totaldeduction").val(),
                            totalmillk : $("#totalliter").val(),
                            act : 1,
                            submodule : "customerbill"
                        },
                        success: function(responseObj){
                           var isSuccess = JSON.parse(responseObj).success;
                           if(isSuccess){
                               var message = JSON.parse(responseObj).message;
                               alert(message);
                               location.reload();
                           } else{
                               var errormessage = JSON.parse(responseObj).errormessage;
                               alert(errormessage);
                           }
                        }
                    })
                } else{
                    alert("Bill can't be generated because total amount is 0 or empty.");
                }
            }
            function printbill(){
                
                         if($("#tamount").val() !== "" && $("#tamount").val() !== "0" && $("#totalliter").val() !== "" && $("#totalliter").val() !== "0"){
                    $.ajax({
                        url: "BillingController",
                        context: document.body,
                        method: "POST",
                        data: {
                            milkmanid : $("#milkmanid").val(),
                            milkmanname : $("#milkmanname").val(),
                            startdate : $("#startdate").val(),
                            enddate : $("#enddate").val(),
                            commission : $("#commissionid").val() === "" ? "0" : $("#commissionid").val(),
                            deduction : $("#deductionid").val() === "" ? "0" : $("#deductionid").val(),
                            remarks : $("#remarkid").val(),
                            subtotal : $("#subtotal").val(),
                            totalamount : $("#tamount").val(),
                            totalcommission : $("#totalcommission").val() === "" ? "0" : $("#totalcommission").val(),
                            totaldeduction : $("#totaldeduction").val() === "" ? "0" : $("#totaldeduction").val(),
                            totalmillk : $("#totalliter").val(),
                            act : 1,
                            submodule : "customerbill"
                        },
                        success: function(responseObj){
                           var isSuccess = JSON.parse(responseObj).success;
                           if(isSuccess){
                               var message = JSON.parse(responseObj).message;
                               alert(message);
                            $('#milkmanid').val("");
                            $('#milkmanname').val("");
                            $('#startdate').val("");    
                            $('#enddate').val("");    
                            $('#commissionid').val("");
                            $('#deductionid').val("");    
                            $('#remarkid').val("");    

                               location.reload();
                           } else{
                               var errormessage = JSON.parse(responseObj).errormessage;
                               alert(errormessage);
                           }
                        }
                    })
                } else{
                    alert("Bill can't be generated because total amount is 0 or empty.");
                }
           
                        var totalcommission = $("#totalcommission").val();
                        var totaldeduction = $("#totaldeduction").val();
                        var totalliter = $("#totalliter").val();
                        var totalamount = $("#tamount").val();
                        var startDate = $("#startdate").val();
                        var selectedDate = $("#enddate").val();
                        var milkManId = $("#milkmanid").val();
                        var remark =$("#remarkid").val();
                        window.open('CustomerBillPrint.jsp?totalcommission='+totalcommission+'&totaldeduction='+totaldeduction+'&totalliter='+totalliter+'&startDate='+startDate+'&selectedDate=<%=selectedDate %>&milkManId='+milkManId+'&remark='+remark+'&totalamount='+totalamount, '_blank');
                    }
        </script>
    </body>
</html>

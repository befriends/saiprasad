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
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>     
        <!--script for menu-->
        <script src="js/commonFunctions.js"></script>
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
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
                            $("#dateid").val(jsonObj[0]);

                        }
                        var selectedValue = $("#" + parentcomboId).val();
                        $("#" + setvaluecomboId).val(selectedValue);
                    }
                });
            }
           $(document).ready(function() {

                $("#datepicker").datepicker({
                    dateFormat: 'dd/mm/yy',
                   onSelect: function() {
                        var selectedDate = $("#datepicker").val();
                        var selectedDateForJava = $("#dateid").val();
                        var milkManId = $("#milkmanid").val();
                        $("#customerbillform")[0].action = "CustomerBill.jsp";
                        window.location = "?selectedDate=" + selectedDate + "&startDate=" + selectedDateForJava + "&milkManId=" + milkManId;
                        
//                         $("#datepicker").val(selectedDate);
//                         $("#dateid").val(selectedDateForJava);
//                         $("#milkmanid").val(milkManId);
                    }
                });
            });
//            $(document).ready(function() {
//                 $("#datepicker").click(function() {
//                      $('#datepick').datepicker('show');
//                        var selectedDate = $("#datepicker").val();
//                        var selectedDateForJava = $("#dateid").val();
//                        var milkManId = $("#milkmanid").val();
//                        $("#customerbillform")[0].action = "CustomerBill.jsp";
//                        window.location = "?selectedDate=" + selectedDate + "&startDate=" + selectedDateForJava + "&milkManId=" + milkManId;
//           
//           });
//        });

            $(document).ready(function() {
                $("#commissionid").change(function() {

                    var commission = parseFloat($("#commissionid").val());
                    var totalliter = parseInt($("#totalliter").val());
                    var totcommission = commission * totalliter;
                    $("#totalcommission").val(totcommission);

                });
                $("#deductionid").change(function() {
                    var deductionid = parseFloat($("#deductionid").val());
                    $("#deduction").val(deductionid);

                });
                $("#commissionid").change(function() {

                    var totalcommission = parseFloat($("#totalcommission").val());
                    var total = parseFloat($("#tamount").val());
                    var totalam = (total + totalcommission);
                    $("#tamount").val(totalam);
                });
                $("#deductionid").change(function() {

                    var ded = parseFloat($("#deduction").val());
                    var total = parseFloat($("#tamount").val());
                    var dedtotal = total - ded;
                    $("#tamount").val(dedtotal);

                });
            });


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
                    <%  //                                                           Only for  Disply message after execution
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

                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Customer Bill Generation Form</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;font-size: 10px;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="customerbillform" class="form-horizontal" action="dailyCollection" method="post">
                                <table>
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
                                                <label for="date"class="control-label col-sm-3">Starting Date : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" id="dateid" placeholder="Stariting Date" name="dateid" value="" readonly="true" required=""/>

                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="datepicker" class="control-label col-sm-3" >Ending Date : </label>
                                                <div class="col-sm-8 text-left">
                                                    <input type="text" class="date-picker" selected="true" id="datepicker" name="date" value="" placeholder="--- Select End Date ---" required="" />
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
                                    <!--                                    <tr>
                                                                            <td>
                                    
                                                                                <div class="form-group"> 
                                    
                                                                                    <div class="col-sm-offset-4 col-sm-10">
                                                                                        <button type="submit" name="submit" id="submit" value="Add" class="btn btn-default">Add </button>
                                                                                        <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                                                                        <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                        </tr>-->

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
                            <table class="table table-condensed table-bordered table-hover"style="table-layout:fixed;" id="tbl" >
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
                                    <tr class="info gridrowheight" id="editrecordid<%=cnt%>" style="display:none;">
                                <form name="editrecords">
                                    <td style="display: none;">
                                        <label id="purchaseid" style="display: none;"><%=obj.getString("purchaseid")%>)%></label>
                                        <label id="submodule" style="display: none;">daillycollection</label>
                                    </td>
                                    <td><label><%=cnt + 1%></label></td>
                                    <td style="display: none;">
                                        <label id="purchaseid" style="display: none;"><%=obj.getString("purchaseid")%></label>
                                        <label id="submodule" style="display: none;">daillycollection</label>
                                    </td>
                                    <td>
                                        <input type="text" name="date" value="<%=obj.get("date")%>"/></td>
                                    <td>
                                        <input type="text" name="type" value="<%=obj.get("type")%>"/></td>

                                    <td>
                                        <input type="text" name="fat" value="<%=obj.get("fat")%>" readonly />
                                    </td>
                                    <td>
                                        <input type="text" name="lacto" value="<%=obj.get("lacto")%>"/>
                                    </td>
                                    <td>
                                        <input type="text" name="snf" value="<%=obj.get("snf")%>"/>
                                    </td>
                                    <td> <input type="text" name="totalmilk" value="<%=obj.get("totalmilk")%>"/></td>
                                    <td>
                                        <input type="text" name="rate" value="<%=obj.get("rate")%>"/></td>
                                    <td>   <input id="total" type="text" name="totalamount" value="<%=obj.get("totalamount")%>"/></td>

                                </form>
                                </tr>
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
                                            <label for="text"class="control-label col-sm-3">TotalMilk: </label>
                                            <div class="col-sm-9 text-left">
                                                <input type="text" id="totalliter" placeholder="0.00" name="totalliter" value="<%=grandMilkTotal%>" required="" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Deduction: </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="deduction" placeholder="0.00" name="deduction" value="" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>
                                    <td>

                                        <div class="form-inline">
                                            <label for="text"class="control-label col-sm-3">Total: </label>
                                            <div class="col-sm-8">
                                                <input type="text" id="tamount" placeholder="0.00" name="tamount" value="<%=grandTotal%>" readonly="true"/>

                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td><td></td>


                                </tr>
                            </table>
                            <div class="form-group"> 

                                <div class="col-sm-offset-4 col-sm-10">
                                    <button type="submit" name="submit" id="submit" value="Add"  onclick="proceedorder()" class="btn btn-default">Generate </button>
                                    <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                </div>
                            </div>





                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--                                                <script type="text/javascript" lang="javascript">
                    function proceedorder() {
                        var billingtable = $('#tbl tbody tr');
                        var cnt;
                        var jsonarr = [];
        
                        if (billingtable.length > 0) {
                            for (cnt = 0; cnt < billingtable.length; cnt++) {
                                var trEle = $('#billingtable tbody tr[id=row' + cnt + ']');
                                var menuitemid = $('#billingtable tbody tr[id=row' + cnt + '] td[id=idmenuitem' + cnt + ']').text();
                                var message = $('#billingtable tbody tr[id=row' + cnt + '] td[id=idmessage' + cnt + ']').text();
                                var quantity = $('#billingtable tbody tr[id=row' + cnt + '] td[id=idquantity' + cnt + ']').text();
                                var rate = $('#billingtable tbody tr[id=row' + cnt + '] td[id=idrate' + cnt + ']').text();
                                var subtotal = $('#billingtable tbody tr[id=row' + cnt + '] td[id=idsubtotal' + cnt + ']').text();
        
                                var jsonobj = {};
                                jsonobj["menuitemid"] = menuitemid;
                                jsonobj["message"] = message;
                                jsonobj["quantity"] = quantity;
                                jsonobj["rate"] = rate;
                                jsonobj["subtotal"] = subtotal;
        
                                jsonarr.push(jsonobj);
                            }
                            var orderjsonlist = {};
                            orderjsonlist ["data"] = jsonarr;
                            orderjsonlist ["userid"] = "<%=userID%>";
                            if ($('#tableno :selected')[0].index === 0) {
                                alert("Please select table for proceed order.");
                                return false;
                            }
                            orderjsonlist ["tableid"] = $('#tableno :selected').val();
                            var tno = $('#tableno :selected').text();
                            orderjsonlist ["tableno"] = tno.substr(tno.length - 7, 6);
                            var status = $('#tableno :selected')[0].isbooked;
        
                            var isbooked = false;
                            if (status === 1) {
                                isbooked = true;
                            }
        
                            $.ajax({
                                url: "dailyCollection",
                                context: document.body,
                                method: "POST",
                                data: {
                                    act: 1, // act=1 => action 1 is for saving order to DB.
                                    submodule:"AddDaillyMilk",
        //                            orderlistjson: JSON.stringify(orderjsonlist)
                                },
                                success: function(responseObj) {
                                    alert('Order proceeded.....');
                                    location.reload();
                                }
                            });
                        } else {
                            alert("Order list is empty. Please add menu's to order list.");
                        }
                    }
                            
           </script>-->
        <script type = "text/javascript" src = "js/GridViewUserController.js" ></script> 



    </body>
</html>

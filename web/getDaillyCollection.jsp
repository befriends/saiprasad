<%-- 
    Document   : getDaillyColllection
    Created on : 2 Sep, 2016, 1:37:12 PM
    Author     : sai
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
    String stringDate = sdf.format(date );

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daily Collection</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>  
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">
        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
        <script src="js/bootstrap.min.js"></script>  
        <script src="js/commonFunctions.js"></script>
        <!--<script type="text/javascript" src="js/calendar.js"></script>-->
        <script type="text/javascript" lang="javascript" >
            function loadSubCategory(parentcomboId, setvaluecomboId) {
                var parentComboId = parentcomboId;
                var selectedId = $("#"+parentComboId).val();
                var parentComboName = document.getElementById(parentComboId).name;
                var url = 'dailyCollection';
                var submodule = 'Purchase';
//                loadComboValues(parentComboId, childComboId, url, submodule);
                $.ajax({
                    url: url + "?act=4&submodule=" + submodule + "&" + parentComboName + "=" + selectedId, // act=4 => action 4 is for getting values from DB.
                    context: document.body,
                    success: function(responseobj) {
                        var jsonObj = JSON.parse(responseobj).data;
                        var issuccess = JSON.parse(responseobj).isSuccess;
                        if(issuccess){
                            $("#milktypeid").val(jsonObj[0].name);
                        }
                        var selectedValue = $("#"+parentcomboId).val();
                        $("#"+setvaluecomboId).val(selectedValue);
                    }
                });
            }
//            function test(){alert('Ok');}
//            function autoDate() {
//                var tDay = new Date();
//                var tMonth = tDay.getMonth() + 1;
//                var tDate = tDay.getDate();
//                if (tMonth < 10)
//                    tMonth = "0" + tMonth;
//                if (tDate < 10)
//                    tDate = "0" + tDate;
//                if(document.getElementById("datepicker").value="")
//                {
//                document.getElementById("datepicker").value = tDate + "/" + tMonth + "/" + tDay.getFullYear();
//            }
//        }
//
//            function addLoadEvent(func) {
//                var oldonload = window.onload;
//                if (typeof window.onload != 'function') {
//                    window.onload = func;
//                } else {
//                    window.onload = function() {
//                        if (oldonload) {
//                            oldonload();
//                        }
//                        func();
//                    }
//                }
//            }
//
//            addLoadEvent(function() {
//                autoDate();
//            });
            
            
            $(document).ready(function (){
                $("#datepicker").change(function (){
                    stringDate = $("#datepicker").val();
                });
            });
           


            function resetform() {
                document.getElementById("daillycollectionform").reset();
            }
            
             $(document).ready(function() {
                $("#fat").blur(function() {
                    var lacto = parseFloat($("#lacto").val());
                    var fat = parseFloat($("#fat").val());
//                    var d = parseInt($("#discount").val());
                    //       var a=parseInt(lacto)/parseInt(fat);
                    var lacto1 = lacto / 4;
                    var fat1 = 0.21 * fat;
                    var snf = lacto1 + fat1 + 0.36;
                    var roundOff = Math.round(snf * 10) / 10;
                    $("#snf").val("");
                    $("#snf").val(roundOff);
                });
                $("#lacto").blur(function() {
                    var lacto = parseFloat($("#lacto").val());
                    var fat = parseFloat($("#fat").val());
//                    var d = parseInt($("#discount").val());
                    //       var a=parseInt(lacto)/parseInt(fat);
                    var lacto1 = lacto / 4;
                    var fat1 = 0.21 * fat;
                    var snf = lacto1 + fat1 + 0.36;
                    var roundOff = Math.round(snf * 10) / 10;
                    $("#snf").val("");
                    $("#snf").val(roundOff);
                });
                 $("#datepicker").datepicker({
                dateFormat: 'dd/mm/yy',
                 onSelect: function() {
                    var selectedDate = $("#datepicker").val();
                    $("#daillycollectionform")[0].action = "getDaillyCollection.jsp";
                    window.location = "?selectedDate="+ selectedDate;
                  }
            });
             // Datepicker code end
            // date code begin
            var tDay = new Date();
            var tMonth = tDay.getMonth() + 1;
            var tDate = tDay.getDate();
            if (tMonth < 10)
                tMonth = "0" + tMonth;
            if (tDate < 10)
                tDate = "0" + tDate;
            if($("#datepicker").val() === ""){
                $("#datepicker").val(tDate + "/" + tMonth + "/" + tDay.getFullYear());
            }
            // date code end
            });

        </script>

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
                        %>      <span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: red;"><%=message%></h3></span><br /><%
                                }
                            }   /// End

//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("submodule", "menuitem"); // Database Table Name
//                            params.put("columnname", "menuitemid"); // Database Column Name
//                            CommonDao commonDaoObj = new CommonDaoImpl();
//                            String id = commonDaoObj.generateNextID(params);

                            PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();                            

                            JSONObject JsonList = purchaseDaoObj.getMilkmandetailsList();
                            
                            
                        String selectedDate = "";
                        if (request.getParameter("selectedDate") == null) {
                            selectedDate = stringDate;
                        } else {
                            selectedDate = request.getParameter("selectedDate");
                        }
                        %>



                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Daily Collection</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="daillycollectionform" class="form-horizontal" action="dailyCollection" method="post">
                                <table>
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="date" class="control-label col-sm-3">Date: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="date-picker" id="datepicker" value="<%=selectedDate %>" placeholder="Enter Date" name="date" value="" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline">
                                                <label for="customid" class="control-label col-sm-3">MilkMan Id:</label> 
                                                <div class="col-sm-8">
                                                    <!--<input type="text" class="form-control" id="customid" name="milkid" required=""/>-->
                                                    <select class="form-contol" id="milkmanid" placeholder="" name="milkmanid" onchange="loadSubCategory('milkmanid', 'milkmanname')" required="">
                                                        <option value="">--Please Select ID--</option>
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
                                        <td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="milkmanname"class="control-label col-sm-3">Name :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="milkmanname" placeholder="" name="milkmanname" onchange="loadSubCategory('milkmanname', 'milkmanid')" required="">
                                                        <option value="">--Please Select Name--</option>
                                                        <%  //JSONArray jarr = JsonList.getJSONArray("data");
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
                                        <td>


                                            <div class="form-inline">
                                                <label for="milktype"class="control-label col-sm-3">Milk Type :</label>
                                                <div class="col-sm-8">                                                                                                       
                                                    <input type="text" id="milktypeid" placeholder="Milk Type" name="milktype" value="" readonly="true" required=""/>                                                        
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="liter" class="control-label col-sm-3">Liter:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="liter" placeholder="Enter Liter " name="liter" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">Lactose:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="lacto" placeholder="Enter Lacto" name="lactose" />
                                                </div>
                                            </div>
                                        </td>
                                        </tr>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">Fat:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="fat" placeholder="Enter Fat" name="fat"  required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">SNF:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="snf" placeholder="Enter SNF" name="snf" value="" required="" readonly="true"/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="type"class="control-label col-sm-3">Select Shift :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="designation" placeholder="" name="shift" required="">
                                                        <option value="">--Please Select Designation--</option>
                                                        <option value="M">Morning</option>
                                                        <option value="E">Evening</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">Remark:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="remark" placeholder="Enter Lacto" name="remark" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group"> 
                                                <div class="col-sm-offset-5 col-sm-10">
                                                    <button type="submit" name="submit" value="Add" class="btn btn-default">Add </button>
                                                    <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                                </div>
                                            </div>
                                        <td>
                                    </tr>
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="AddDailyMilk" />
                                </table>
                            </form>
                        </fieldset>
                         <%                            
                            JSONObject milkCollectionList = purchaseDaoObj.getMilkManRecordList(selectedDate);
                            JSONArray itemarr = milkCollectionList.getJSONArray("data");
                            if (milkCollectionList != null && milkCollectionList.has("success") && milkCollectionList.has("data")) {
                                itemarr = milkCollectionList.getJSONArray("data");
                            }
                        %>

                        <table class="table table-condensed table-bordered table-hover"style="table-layout:fixed;" id="tbl" >
                            <thead>
                                <tr class="">
                                    <th style="display: none;">ID</th>
                                    <th style="width: 5%;text-align: center;">Sr. No.</th>
                                    <th style="width: 10%;">Code</th>
                                    <th style="width: 8%;">Type</th>
                                    <th style="width: 10%;">Shift</th>
                                    <th style="width: 7%;">Fat</th>
                                    <th style="width: 10%;"> Lactose</th>
                                    <th style="width: 10%;">Liter</th>
                                    <th style="width: 7%;">Rate</th>
                                    <th style="width: 13%;">TotalAmount</th>
                                    <th style="width: 20%;">Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    int cnt = 0;
                                    for (cnt = 0; cnt < itemarr.length(); cnt++) {
                                        JSONObject obj = itemarr.getJSONObject(cnt);
                                %>
                                <tr class="info" id="editrecordid<%=cnt%>" style="display:none;">
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
                                    <input type="text" name="code" value="<%=obj.get("code")%>"/>
                                </td>
                                <td>
                                    <input type="text" name="type" value="<%=obj.get("type")%>"/></td>
                                <td>
                                    <input type="text" name="shift" value="<%=obj.get("shift")%>"/></td>
                                <td>
                                    <input type="text" name="fat" value="<%=obj.get("fat")%>" readonly />
                                </td>
                                <td>
                                    <input type="text" name="lacto" value="<%=obj.get("lacto")%>"/>
                                </td>
                                <td> <input type="text" name="totalmilk" value="<%=obj.get("totalmilk")%>"/></td>
                                <td>
                                    <input type="text" name="rate" value="<%=obj.get("rate")%>"/></td>
                                <td>
                                    <input type="text" name="totalamount" value="<%=obj.get("totalamount")%>"/></td>


                                <td>  <p class="btn btn-info" onClick="updaterecord(<%=cnt%>)"><span class="glyphicon glyphicon-save"></span>&nbsp;Save</p>
                                    &nbsp;|&nbsp;
                                    <p class="btn btn-default" onClick="cancel(<%=cnt%>)"><span class="glyphicon glyphicon-remove"></span>&nbsp;Cancel</p></td>
                            </form>
                            </tr>
                            <tr class="success" id="recordid<%=cnt%>">
                                <td style="display: none;">
                                    <label id="purchaseid" style="display: none;"><%=obj.getString("purchaseid")%></label>
                                    <label id="submodule" style="display: none;">sell entry</label>
                                </td>
                                <td><label><%=cnt + 1%></label></td>
                                <td><label name="code"><%=obj.get("code")%></label></td>
                                <td><label name="type"><%=obj.get("type")%></label></td>
                                <td><label name="shift"><%=obj.get("shift")%></label></td>
                                <td><label name="fat"><%=obj.get("fat")%></label></td>
                                <td><label name="lacto"><%=obj.get("lacto")%></label></td>
                                <td><label name="totalmilk"><%=obj.get("totalmilk")%></label></td>
                                <td><label name="rate"><%=obj.get("rate")%></label></td>
                                <td><label name="totalamount"><%=obj.get("totalamount")%></label></td>


                                <td>
                                    <p class="btn btn-success" onClick="showeditrecord(<%=cnt%>)"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Edit</p>
                                    &nbsp;|&nbsp;
                                    <p class="btn btn-danger" onClick="deleterecord(<%=cnt%>)"><span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</p>
                                </td>
                            </tr>  

                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <script type="text/javascript" src="js/GridViewUserController.js"></script>   

                        </body>
                        </html>

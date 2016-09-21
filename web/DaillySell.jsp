<%-- 
    Document   : getDaillyColllection
    Created on : 2 Sep, 2016, 1:37:12 PM
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery.min.js"></script> 
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>     
        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
        <script src="js/bootstrap.min.js"></script>      
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" lang="javascript" >
//            function loadSubCategory() {
//                var parentComboId = 'cusname';
//                var childComboId = 'milktype';
//                var url = 'dailyCollection';
//                var submodule = 'Purchase';
//                loadComboValues(parentComboId, childComboId, url, submodule);
//            }
        </script>
        <script type="text/javascript" lang="javascript">

            $(document).ready(function() {
                $("#fat").blur(function() {
                    var lacto = parseFloat($("#lacto").val());
                    var fat = parseFloat($("#fat").val());
//                    var d = parseInt($("#discount").val());
                    //       var a=parseInt(lacto)/parseInt(fat);
                    var lacto1 = lacto / 4;
                    var fat1 = 0.21 * fat;
                    var snf = lacto1 + fat1 + 0.36;
                  var  roundOff = Math.round(snf * 10) / 10;
                    $("#snf").val(roundOff);
                });
            });
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
                            params.put("submodule", "sellentry"); // Database Table Name
                            params.put("columnname", "sellid"); // Database Column Name
                            CommonDao commonDaoObj = new CommonDaoImpl();
                            String id = commonDaoObj.generateNextID(params);

                            SellDao sellDaoObj = new SellDaoImpl();

                            JSONObject JsonList = sellDaoObj.getDairyNameList();
                        %>
                        <%!
                            JSONObject jobj = null;
                        %>



                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Daily Sell Form</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="SellController" method="post">
                                <table>
                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="date" class="control-label col-sm-3">Date: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="date-picker" id="date" placeholder="Enter Date" name="date" value="" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-inline">
                                                <label for="customid" class="control-label col-sm-3">Custom Id: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="sellid" name="customid" value="<%=id%>" readonly="true" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <div class="form-inline">
                                                <label for="cusname"class="control-label col-sm-3">Dairy Name :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="dairyname" placeholder="" name="dairyname" required="">
                                                        <option value="">--Please Select Name--</option>
                                                        <%                    JSONArray jarr = JsonList.getJSONArray("data");
                                                            for (int cnt = 0; cnt < jarr.length(); cnt++) {
                                                                jobj = jarr.getJSONObject(cnt);

                                                        %>
                                                        <option value="<%=jobj.getLong("dairyid")%>"><%=jobj.getString("dairyname")%></option>

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
                                                    <select class="form-control" id="milktype" placeholder="" name="milktype" required="">
                                                        <option value="">--Please Select Designation--</option>
                                                        <option value="BOTH">BOTH</option>
                                                        <option value="COW">COW</option>
                                                        <option value="BUFFALO">BUFFALO</option>

                                                    </select>

                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="liter" class="control-label col-sm-3">Driver Name:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="drivername" placeholder="Enter Driver Name " name="drivername" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="liter" class="control-label col-sm-3">Tanker Number:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="tankerno" placeholder="Enter Liter " name="tankerno" required=""/>
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
                                                    <input type="text" class="form-control" id="lacto" value="0"  placeholder="Enter Lacto" name="lactose"  required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">Fat:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="fat" value="0" placeholder="Enter Fat" name="fat" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3"> S.N.F:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="snf" value="0" placeholder="Enter SNF" name="snf"  required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-inline" >
                                                <label for="fat" class="control-label col-sm-3">Protein:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" id="protien" placeholder="Enter Protien" name="protein" required=""/>
                                                </div>
                                            </div>
                                        </td>
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
                                    </tr>
                                    <tr>
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

                                                <div class="col-sm-offset-2 col-sm-10">
                                                    <button type="submit" name="submit" value="Add" class="btn btn-default">Add </button>
                                                    <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
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
                            JSONObject subCategoryList = sellDaoObj.getSubCategoryList();
                            JSONArray itemarr = subCategoryList.getJSONArray("data");
                            if (subCategoryList != null && subCategoryList.has("success") && subCategoryList.has("data")) {
                                itemarr = subCategoryList.getJSONArray("data");
                            }
                        %>

                        <table class="table table-condensed table-bordered table-hover"style="table-layout:fixed;" id="tbl" >
                            <thead>
                                <tr class="">
                                    <th style="display: none;">ID</th>
                                    <th style="width: 10%;text-align: center;">Sr. No.</th>
                                    <th style="width: 20%;">Driver Name</th>
                                    <th style="width: 20%;">Tanker Number</th>
                                    <th style="width: 10%;"> Total Milk</th>
                                    <th style="width: 13%;">Date</th>
                                    <th style="width: 7%;">Type</th>
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
                                    <label id="sellid" style="display: none;"><%=obj.getLong("sellid")%>)%></label>
                                    <label id="submodule" style="display: none;">sellentry</label>
                                </td>
                                <td><label><%=cnt + 1%></label></td>
                                <td style="display: none;">
                                    <label id="sellid" style="display: none;"><%=obj.getLong("sellid")%></label>
                                    <label id="submodule" style="display: none;">sellentry</label>
                                </td>
                                <td>
                                    <input type="text" name="drivername" value="<%=obj.get("drivername")%>"/>
                                </td>
                                <td>
                                    <input type="text" name="tankerno" value="<%=obj.get("tankerno")%>" readonly />
                                </td>
                                <td>
                                    <input type="text" name="totalmilk" value="<%=obj.get("totalmilk")%>"/>
                                </td>
                                <td> <input type="text" name="date" value="<%=obj.get("date")%>"/></td>
                                <td>
                                    <input type="text" name="type" value="<%=obj.get("type")%>"/></td>

                                <td>  <p class="btn btn-info" onClick="updaterecord(<%=cnt%>)"><span class="glyphicon glyphicon-save"></span>&nbsp;Save</p>
                                    &nbsp;|&nbsp;
                                    <p class="btn btn-default" onClick="cancel(<%=cnt%>)"><span class="glyphicon glyphicon-remove"></span>&nbsp;Cancel</p></td>
                            </form>
                            </tr>
                            <tr class="success" id="recordid<%=cnt%>">
                                <td style="display: none;">
                                    <label id="sellid" style="display: none;"><%=obj.getLong("sellid")%></label>
                                    <label id="submodule" style="display: none;">sell entry</label>
                                </td>
                                <td><label><%=cnt + 1%></label></td>
                                <td><label name="drivername"><%=obj.get("drivername")%></label></td>
                                <td><label name="tankerno"><%=obj.get("tankerno")%></label></td>
                                <td><label name="totalmilk"><%=obj.get("totalmilk")%></label></td>
                                <td><label name="date"><%=obj.get("date")%></label></td>
                                <td><label name="type"><%=obj.get("type")%></label></td>

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

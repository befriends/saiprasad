<%-- 
    Document   : getDaillyColllection
    Created on : 2 Sep, 2016, 1:37:12 PM
    Author     : sai
--%>

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
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>     
        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
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
                            params.put("submodule", "menuitem"); // Database Table Name
                            params.put("columnname", "menuitemid"); // Database Column Name
                            CommonDao commonDaoObj = new CommonDaoImpl();
                            String id = commonDaoObj.generateNextID(params);

                            PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();

                            JSONObject JsonList = purchaseDaoObj.getCategoryList();
                        %>
                        <%!
                            JSONObject jobj = null;
                        %>



                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Purchase Form</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="dailyCollection" method="post">

                                <div class="form-inline">
                                    <label for="date" class="control-label col-sm-2">Date: </label>
                                    <div class="col-sm-8">
                                        <input type="text" class="date-picker" id="hiredate" placeholder="Enter Date" name="date" value="" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-inline">
                                    <label for="customid" class="control-label col-sm-2">MilkMan Id:</label> 
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="customid" name="milkid" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-inline">
                                    <label for="customername"class="control-label col-sm-2">Name :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="customername" placeholder="" name="customername" onchange="loadSubCategory()" required="">
                                            <option value="">--Please Select Name--</option>
                                            <%                    JSONArray jarr = JsonList.getJSONArray("data");
                                                for (int cnt = 0; cnt < jarr.length(); cnt++) {
                                                    jobj = jarr.getJSONObject(cnt);

                                            %>
                                            <option value="<%=jobj.getLong("id")%>"><%=jobj.getString("fullname")%></option>

                                            <%
                                                }
                                            %>

                                        </select>
                                    </div>
                                </div><br>
                                <div class="form-inline">
                                    <label for="milktype"class="control-label col-sm-2">Milk Type :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="milktype" placeholder="" name="type"  required="">
                                            <option value="">--Please Select Type--</option>
                                            <% //  JSONArray jarr1 = subCategoryJsonList.getJSONArray("data");
                                                //                                                for (int cnt = 0; cnt < jarr1.length(); cnt++) {
                                                //                                                    jobj = jarr1.getJSONObject(cnt);

                                            %>


                                            <%// 

                                            %>
                                        </select> 
                                    </div>
                                </div><br>
                                <div class="form-inline" >
                                    <label for="liter" class="control-label col-sm-2">Liter:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="liter" placeholder="Enter Liter " name="liter" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-inline" >
                                    <label for="fat" class="control-label col-sm-2">Fat:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="fat" placeholder="Enter Fat" name="fat" onkeypress="return numbersonly(event)" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-inline" >
                                    <label for="fat" class="control-label col-sm-2">Lactose:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="lacto" placeholder="Enter Lacto" name="lactose" onkeypress="return numbersonly(event)" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-inline">
                                    <label for="type"class="control-label col-sm-2">Select Shift :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="designation" placeholder="" name="shift" required="">
                                            <option value="">--Please Select Designation--</option>
                                            <option value="M">Morning</option>
                                            <option value="E">Evening</option>

                                        </select>
                                    </div>
                                </div><br>
                                <div class="form-inline" >
                                    <label for="fat" class="control-label col-sm-2">Remark:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="remark" placeholder="Enter Lacto" name="remark" required=""/>
                                    </div>
                                </div><br>
                                <div class="form-group"> 
                                    <div class="col-sm-offset-2 col-sm-5">
                                        <button type="submit" name="submit" value="Add" class="btn btn-default">Add </button>
                                        <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                        <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                    </div>
                                </div>
                                <input type="hidden" name="act" value="1" />
                                <input type="hidden" name="submodule" value="Purchase" />
                            </form>
                        </fieldset>
                        <%                                                JSONObject menuitemJSONObject = purchaseDaoObj.getSubCategoryList();
                            JSONArray itemarr = new JSONArray();
                            if (menuitemJSONObject != null && menuitemJSONObject.has("success") && menuitemJSONObject.has("data")) {
                                itemarr = menuitemJSONObject.getJSONArray("data");
                            }
                        %>

                        </body>
                        </html>

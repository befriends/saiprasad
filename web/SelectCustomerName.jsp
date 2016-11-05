<%-- 
    Document   : SelectCustomerName
    Created on : 30 Sep, 2016, 6:36:51 PM
    Author     : sai
--%>


<%@page import="DaoImpl.PurchaseSellDaoImpl"%>
<%@page import="Dao.PurchaseSellDao"%>
<%@page import="Dao.PurchaseSellDao"%>
<%@page import="DaoImpl.CommonDaoImpl"%>
<%@page import="Dao.CommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONObject"%>
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
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="css/normalize.css">
        <title>Customer Name</title>
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <!--style for menu-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript" src="js/jquery.js"></script> 
        <!--script for menu-->
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->
        <script src="js/bootstrap.min.js"></script>               
        
    </head>
    <body style="background-color: #555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color: powderblue;">
                    <%
                        PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();

                        JSONObject JsonList = purchaseDaoObj.getMilkmandetailsList();

                    %>
                    <%!
                        JSONObject jobj = null;
                    %>
                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Customer Name</span>
                    <div>
                        <fieldset style="border:1px solid silver; padding:5px;">
                            <form role="form" id="orderform" class="form-horizontal" target="_blank" action="ReportController" method="post"  onsubmit="return validate()" >
                                <div class="form-group">
                                    <label for="customername" class="control-label col-sm-2"> Customer Name:</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="customername" placeholder="Select Customer Name"  name="customername" autofocus="true" required="">
                                            <option value="">--- Select Customer Name ---</option>
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
                                <div class="form-group"> 
                                    <div class="col-sm-offset-2 col-sm-5">
                                        <button type="submit" name="submit" value="Add" class="btn btn-default">Generate</button>
                                        <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                        <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                    </div>
                                </div>
                                <input type="hidden" name="act" value="1" />
                                <input type="hidden" name="submodule" value="purchaseCustomerName" />
                            </form>

                        </fieldset>
                    </div>
                </div>
            </div>
        </div>



    </body>
</html>

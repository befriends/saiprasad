<%@page import="org.json.JSONArray"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd"
    >
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Form </title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />

        <!--script for menu-->
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->

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
                        params.put("submodule", "milkmandetails"); // Database Table Name
                        params.put("columnname", "code"); // Database Column Name
                        CommonDao commonDaoObj = new CommonDaoImpl();
                        String id = commonDaoObj.generateNextID(params);

                        MilkSupplierDao milkDAOObj = new MilkSupplierDaoImpl();
//                            JSONObject jsonList = milkDAOObj.getMaterialList();

                    %>
                    <%!
                        JSONObject jobj = null;
                    %>


                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Registration Form</span>

                    
                    <!--<div style="overflow-y: scroll;overflow-x: hidden;;">-->
                    <div style="max-height: 600px;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="MilkSupplierController" method="post"  onkeypress="myFunction()" onsubmit="return validate()">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <label for="userid" class="control-label col-sm-3">Custom Id: </label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="codeid" name="code" value="<%=id%>" readonly="true" />
                                                </div>
                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-group">
                                                <label for="fullname" class="control-label col-sm-3">First Name:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="firstname" placeholder="Enter First Name" name="firstname" autofocus="true" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                            <div class="form-group">
                                                <label for="lastname" class="control-label col-sm-3">Last Name :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="lastname" name="lastname" placeholder="Enter Last Name" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <label for="dairyname" class="control-label col-sm-3">Dairy Name:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="dairyname" placeholder="Enter Dairy Name" name="dairyname" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                            <div class="form-group">
                                                <label for="mobilenumber" class="control-label col-sm-3">Mobile Number :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="mobilenumber" placeholder="Enter Mobile Number" name="mobilenumber" onkeypress="return numbersonly(event)" onkeyup="return limitlength(this, 10)" required=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>


                                            <div class="form-group">
                                                <label for="accountnumber" class="control-label col-sm-3">Account Number:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="accountnumber" placeholder="Enter Account Number" name="accountnumber"/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                            <div class="form-group">
                                                <label for="accountbranch" class="control-label col-sm-3">Account Branch:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="acountbranch" placeholder="Enter Account Branch" name="acountbranch"/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-group">
                                                <label for="address" class="control-label col-sm-3">Address :</label>
                                                <div class="col-sm-8">
                                                    <input type="text" style="width: 230px;" class="form-control" id="address" placeholder="Enter Address" name="address" required=""/>
                                                </div>
                                            </div>  
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <label for="type"class="control-label col-sm-3">Select Type :</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" style="width: 230px;" id="designation" placeholder="" name="type" required="">
                                                        <option value="">--Please Select Type</option>                                                 
                                                        <option value="COW">COW</option>
                                                        <option value="BUFFALO">BUFFALO</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">

                                                <div class="col-sm-offset-5 col-sm-10">
                                                    <button type="submit" name="submit" value="Add" style="width: 5em;" class="btn btn-success">Add</button>
                                                    <button  type="button" name="cancel" value="Cancel" style="width: 5em;" class="btn btn-danger col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                                    <button type="button" name="cancel" style="width: 5em;" onclick="resetform()" value="Cancel" class="btn btn-primary col-sm-offset-1">Reset</button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <input type="hidden" name="act" value="1" />
                                    <input type="hidden" name="submodule" value="RegistrationSuplier" />
                                </table>
                            </form>
                        </fieldset> 
                                                <%
                            JSONObject milkManList = milkDAOObj.getmilkMandetailsList();
                            JSONArray itemarr = milkManList.getJSONArray("data");
                            if (milkManList != null && milkManList.has("success") && milkManList.has("data")) {
                                itemarr = milkManList.getJSONArray("data");
                            }
                        %>

                        <table class="table table-condensed table-bordered table-hover"style="table-layout:fixed;" id="tbl" >
                            <thead>
                                <tr class="">
                                    <th style="display: none;">ID</th>
                                    <th style="width: 10%;text-align: center;">Sr. No.</th>
                                    <th style="width: 10%;">Code</th>
                                    <th style="width: 20%;">Type</th>                                    
                                    <th style="width: 20%;">Name</th>
                                    <th style="width: 20%;">mobile</th>
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
                                    <label id="milkmanid" style="display: none;"><%=obj.getString("milkmanid")%>)%></label>
                                    <label id="submodule" style="display: none;">milkmandetails</label>
                                </td>
                                <td><label><%=cnt + 1%></label></td>
                                <td style="display: none;">
                                    <label id="milkmanid" style="display: none;"><%=obj.getString("milkmanid")%></label>
                                    <label id="submodule" style="display: none;">milkmandetails</label>
                                </td>
                                <td>
                                    <input type="text" name="code" value="<%=obj.get("code")%>"  />
                                </td>
                                <td>
                                    <input type="text" name="type" value="<%=obj.get("type")%>"  />
                                </td>
                                <td>
                                    <input type="text" name="fullname" value="<%=obj.get("fullname")%>"/>
                                </td>
                                <td>
                                    <input type="text" name="mobile" value="<%=obj.get("mobile")%>"/>
                                </td>
                                
                                <td>  <p class="btn btn-info" onClick="updaterecord(<%=cnt%>)"><span class="glyphicon glyphicon-save"></span>&nbsp;Save</p>
                                    &nbsp;|&nbsp;
                                    <p class="btn btn-default" onClick="cancel(<%=cnt%>)"><span class="glyphicon glyphicon-remove"></span>&nbsp;Cancel</p></td>
                            </form>
                            </tr>
                            <tr class="success" id="recordid<%=cnt%>">
                                <td style="display: none;">
                                    <label id="milkmanid" style="display: none;"><%=obj.getString("milkmanid")%></label>
                                    <label id="submodule" style="display: none;">milkmandetails </label>
                                </td>
                                <td><label><%=cnt + 1%></label></td>
                                <td><label name="code"><%=obj.get("code")%></label></td>
                                <td><label name="type"><%=obj.get("type")%></label></td>
                                <td><label name="fullname"><%=obj.get("fullname")%></label></td>
                                <td><label name="mobile"><%=obj.get("mobile")%></label></td>

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

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
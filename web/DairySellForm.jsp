<%@page import="DaoImpl.SellDaoImpl"%>
<%@page import="Dao.SellDao"%>
<%@page import="DaoImpl.MilkSupplierDaoImpl"%>
<%@page import="Dao.MilkSupplierDao"%>
<%@page import="DaoImpl.CommonDaoImpl"%>
<%@page import="Dao.CommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONObject"%>
<%!
    String message = "";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd"
    >
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sell Register Form </title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <!--style for menu-->
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>

        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>

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
                        params.put("submodule", "dairysell"); // Database Table Name
                        params.put("columnname", "dairyid"); // Database Column Name
                        CommonDao commonDaoObj = new CommonDaoImpl();
                        String id = commonDaoObj.generateNextID(params);

                        SellDao sellDAOObj = new SellDaoImpl();
//                            JSONObject jsonList = milkDAOObj.getMaterialList();

                    %>
                    <%!
                        JSONObject jobj = null;
                    %>


                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Dairy Sell Form</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="orderform" class="form-horizontal" action="SellController" method="post"  onkeypress="myFunction()" onsubmit="return validate()">

                                <div class="form-group">
                                    <label for="dairyid" class="control-label col-sm-2">Code: </label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="codeid" name="code" value="<%=id%>" readonly="true" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="dairyname" class="control-label col-sm-2">Dairy Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="dairyname" placeholder="Enter Dairy Name" name="dairyname" autofocus="true" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="personname" class="control-label col-sm-2">Person Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="personname" name="personname" placeholder="Enter Person Name" required=""/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="altername" class="control-label col-sm-2">Alternate Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="altername" placeholder="Enter Alternate Name" name="altername" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="control-label col-sm-2">Address</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="address" placeholder="Enter Address" name="address" required=""/>
                                    </div>
                                </div>     

                                <div class="form-group">
                                    <label for="mobilenumber" class="control-label col-sm-2">Mobile Number</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="mobile" placeholder="Enter Mobile Number" name="mobile" onkeypress="return numbersonly(event)" onkeyup="return limitlength(this, 10)" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="alternumber" class="control-label col-sm-2">Alternate Number</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="aleternumber" placeholder="Enter Alternate Number" name="alternumber" onkeypress="return numbersonly(event)" onkeyup="return limitlength(this, 10)" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="accountnumber" class="control-label col-sm-2">Account Number</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="account" placeholder="Enter Account Number" name="account" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="accountbranch" class="control-label col-sm-2">Branch Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="acountbranch" placeholder="Enter Branch Name" name="accountbranch" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="tankernumber" class="control-label col-sm-2">Tanker Number</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="tankerno" placeholder="Enter Tanker Number" name="tankernumber" required=""/>
                                    </div>
                                </div>  

                                <div class="form-group">
                                    <label for="amount" class="control-label col-sm-2">Advanced Amount</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="amount" placeholder="Enter Advanced Amount" name="amount"  required=""/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="type"class="control-label col-sm-2">Select Type</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="designation" placeholder="" name="type" required="">
                                            <option value="">--Please Select Type</option>                                                 
                                            <option value="COW">COW</option>
                                            <option value="BUFFALO">BUFFALO</option>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-offset-2 col-sm-5">
                                    <button type="submit" name="submit" value="Add" class="btn btn-default">Add</button>
                                    <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                    <button  type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                </div>
                                </div>
                                <input type="hidden" name="act" value="1" />
                                <input type="hidden" name="submodule" value="AddDairySell" />

                            </form>
                        </fieldset>    
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
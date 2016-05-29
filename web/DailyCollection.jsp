<%-- 
    Document   : DailyCollection
    Created on : 5 May, 2016, 8:03:57 AM
    Author     : vishwas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <link href="css/style.css" rel="stylesheet">
    <head>
        <title>Register form with HTML5 using placeholder and CSS3</title>
        <link rel="stylesheet" href="css/bootstrap.css" type="text/css"/>
    </head>
    <script type="text/javascript">
        function validateForm() {
            var x = document.forms["dailyCollection_form"]["code"].value;
//            var y = document.forms["dailyCollection_form"]["liter"].value;
//            var z = document.forms["dailyCollection_form"]["fat"].value;
//            var z = document.forms["dailyCollection_form"]["lacto"].value;
            
            if (x == null || x == "") {
                alert("Code must be filled out");
                return false;
            }
        }
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }   
        function getdetails(){
            var codeno = document.getElementById('codeno').value;
            $.ajax({
                url: "dailyCollection?act=4&module=collection&codeno="+codeno,
                context: document.body,
                success:function (responseobj){
                    
                }
            });
        }
    </script>
    <style type="text/css">	
    </style>
    <body style="background:url(images/milk.jpg) fixed;background-size:cover;">
        <div id="backgrnd" align="center" style="";>
<!--            <div class="logo text-center">
                <h1 style="color:#990099">Purchase Entry</h1>

            </div>-->

            <!--<div id="" class="col-md-6">-->
                <form action="dailyCollection" name="dailyCollection_form" onsubmit="return validateForm()" method="Post">
                    <fieldset>

                        <legend>Purchase</legend>


                        <div class="col-md-5" style="margin-left:3%">

                            <div class="col-md-5"><label>Code No</label></div>
                            <div class="col-md-7"><input type="text" id="codeno" name="code" onchange="getdetails()" placeholder="Code" />
                                <input type="button" value="search" onclick="getdetails()"></div><br></br>
                            <div class="col-md-5"><label>Name</label></div>
                            <div class="col-md-7"><input type="text" name="custname" placeholder="Customer Name" />
                            <input type="hidden" name="act" value="1" />
                            <input type="hidden" name="module" value="Purchase" />
                            </div><br></br>
                            <div class="col-md-5"><label>Dairy</label></div>
                            <div class="col-md-7"><input type="text" name="dairyname" placeholder="Dairy Name" readonly/></div><br></br>
                            <div class="col-md-5"><label>Type</label></div>
                            <div class="col-md-7">
                                <select name="type">
                                        <option>Cow</option>
                                        <option>Buffalo</option>
                                </select>
                            </div>
                            
                            
                            
                            
                            <!--<br>-->
                        </div>


                        <div class="col-md-6" style="margin-left:3%">
                            <div class="col-md-5"><label>Liter</label></div>
                            <div class="col-md-7"><input type="text" name="liter" placeholder="Total Milk" /></div><br></br>
                            <div class="col-md-5"><label>Fat</label></div>
                            <div class="col-md-7"><input type="text" name="fat" placeholder="Fat" /></div><br></br>
                            <div class="col-md-5"><label>Lacto</label></div>
                            <div class="col-md-7"><input type="text" name="lacto" placeholder="lacto" /></div><br></br>
                            <div class="col-md-5"><label>Remark</label></div>
                            <div class="col-md-7"><input type="text" name="remark" placeholder="Select Shift" /></div><br></br>
                        </div>
                        <input type="submit" name="cancel" value="cancel" style="margin-right: 3%"/>
                        <input type="submit" name="save" value="save"/>
                    </fieldset>    
                </form>
        </div>

    </body>
</html>



<%-- 
    Document   : GetMilk
    Created on : 19 Sep, 2016, 11:53:52 AM
    Author     : sai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RateGenerator</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js"></script>
        <link rel="stylesheet" href="css/responsivemultimenu.css" type="text/css"/>     
        <!--script for menu-->
        <script type="text/javascript" src="js/responsivemultimenu.js"></script>
        <script src="js/bootstrap.min.js"></script>
         <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">
        <script type="text/javascript" lang="javascript">
            
            function resetform() {
                document.getElementById("rategeneratorid").reset();
            }
            $(document).ready(function (){
                
            
             $("#datepicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
            });
            
        </script>  
        <style>
            table {
                font-family:serif;
                border-collapse: collapse;
                width: 90%;
                text-align: auto;
                background-color: buttonshadow;



            }

            td, th {
                border: 1px solid #basic;
                text-align:center;
                background-color: buttonshadow;
                padding: 5px;
                animation-direction: alternate;
            }

            tr:nth-child(even) {
                background-color:;
           }

        </style>
    </head>
    <body style="background-color:#555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="container-fluid">

                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color:buttonshadow;">
                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;"> Rate Generator</span>

                    <div style="max-height: 600px; overflow-y: scroll;overflow-x: hidden;">
                        <fieldset style="border:1px solid silver; padding:5px;">               

                            <form role="form" id="rategeneratorid" class="form-horizontal" action="RateGeneretorController" method="post">

                                <table >
                                    <tr>
                                        <td>

                                        </td>
                                        <td> 
                                            <div class="form-group col-sm-14">
                                                <label for="fat" class="control-label col-sm-3">From </label>                            

                                            </div>
                                        </td>


                                        <td>
                                            <div class="form-group col-sm-14">
                                                <label for="tofat" class="control-label col-sm-3">To</label>

                                            </div>
                                        </td>
                                        <td>
<!--                                            <div class="form-group col-sm-14">
                                                <label for="type"class="control-label col-sm-5">Milk Type </label>
                                                <div class="col-sm-9">
                                                    <select class="form-control" id="designation" placeholder="" name="shift" required="">
                                                        <option value="">--Please Select Designation--</option>
                                                        <option value="M">Morning</option>
                                                        <option value="E">Evening</option>

                                                    </select>
                                                </div>
                                            </div>-->
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <div class="form-group" >

                                                <label for="fat" class="control-label col-sm-5">FAT:</label>
                                            </div>
                                        </td>
                                        <td> 
                                           
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="fromfat" placeholder="Enter Fat" name="fromfat" value=""/>
                                                </div>
                                           
                                        </td>


                                        <td>
                                            
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="tofat" placeholder="Enter Fat " name="tofat" />
                                                </div>
                                           
                                        </td>  
                                         <td>
                                            <div class="form-group col-sm-14">
                                                <label for="type"class="control-label col-sm-5">Milk Type: </label>
                                                <div class="col-sm-7">
                                                    <select class="form-control" id="milktype" placeholder="" name="milktype" required="">
                                                        <option value="">--Please Select Type--</option>
                                                        <option value="COW">COW</option>
                                                        <option value="BUFFALO">BUFFALO</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group" >
                                                <label for="liter" class="control-label col-sm-5">SNF:</label>
                                            </div>
                                        </td>
                                        <td> 

<!--                                            <div class="form-group col-sm-14">
                                                <label for="fromfat" class="control-label col-sm-5">From </label>                            -->
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="fromsnf" placeholder="Enter SNF" name="fromsnf" value=""/>
                                                </div>

                                            <!--</div>-->
                                        </td>


                                        <td>
<!--                                            <div class="form-group col-sm-14">
                                                <label for="tofat" class="control-label col-sm-5">To</label>-->
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="tosnf" placeholder="Enter SNF " name="tosnf" />
                                                </div>
                                            <!--</div>-->
                                        </td>
                                        <td>
                                            <div class="form-group col-sm-14">
                                                <label for="type"class="control-label col-sm-5">Rate Type :</label>
                                                <div class="col-sm-7">
                                                    <select class="form-control" id="rateype" placeholder="" name="ratetype" required="">
                                                        <option value="">--Please Select Type--</option>
                                                        <option value="Purchase">Purchase</option>
                                                        <option value="Sell">Sell</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                            <tr>
                                        <td>
                                            <div class="form-group" >
                                                <label for="liter" class="control-label col-sm-5">Basic:</label>
                                            </div>
                                        </td>
                                        <td> 

<!--                                            <div class="form-group col-sm-14">
                                                <label for="fromfat" class="control-label col-sm-5">From </label>                            -->
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="fromrate" placeholder="Enter Rate" name="fromrate" value=""/>
                                                </div>

                                            <!--</div>-->
                                        </td>


                                        <td>
<!--                                            <div class="form-group col-sm-14">
                                                <label for="tofat" class="control-label col-sm-5">To</label>-->
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="torate" placeholder="Enter Rate " name="torate" />
                                                </div>
                                            <!--</div>-->
                                        </td> 
                                        <td>
                                            <div class="form-inline">
                                                <label for="datepicker" class="control-label col-sm-5">Applied Date: </label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="date-picker" id="datepicker" name="applieddate" placeholder="---Select Applied Date ---"value="" required="" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>

                                <table width="">
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td></td>

                                        <td>                   
                                        </td>
                                        <td></td>

                                        <td> 

                                            <div class="form-group col-sm-14">
                                                <label for="fromfat" class="control-label col-sm-5">Decrease </label>                            
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="dfat" placeholder="Enter Fat" name="dfat" value=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td><td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td> 
                                        </td>
                                        <td>  <div>
                                                <img src="images/upward.jpg" style="height: 70px; width: 20%;" alt="upward image" />
                                            </div></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td> 
                                            <div class="form-group col-sm-14">
                                                <label for="snf" class="control-label col-sm-5">Decrease </label>                            
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="dsnf" placeholder="Enter SNF" name="dsnf" value=""/>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div>
                                                <img src="images/backward.jpg" style="height: 70px; width: %;" alt="Header Image" />
                                            </div>
                                        </td>


                                        <td>

                                            <!--<center> <div class="vertical-line"></div></center>-->

                                            <div class="form-group col-sm-14" >
                                                <label for="rate" class="control-label col-sm-5">Basic</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="rate" placeholder="Enter rate" name="rate" />
                                                </div>
                                            </div>

                                        </td>
                                        <td>
                                            <div>
                                                <img src="images/forward.jpg" style="height: 70px; width: %;" alt="Header Image" />
                                            </div>
                                        </td>

                                        <td>             

                                            <div class="form-group col-sm-14">
                                                <label for="tofat" class="control-label col-sm-5">Increase</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="asnf" placeholder="Enter SNF " name="asnf" />

                                                </div>
                                            </div>
                                        </td>              
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td></td>


                                        <td></td>
                                        <td>
                                            <div>
                                                <img src="images/downward.jpg" style="height: 70px; width: 20%;" alt="Header Image" />
                                            </div>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td> 
                                        <td></td>


                                        <td> 
                                            <!--<center> <div class="vertical-line" ></div></center>-->
                                            <div class="form-group col-sm-14">
                                                <label for="fromfat" class="control-label col-sm-5">Increase </label>                            
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="afat" placeholder="Enter Fat" name="afat" value=""/>
                                                </div>
                                            </div>
                                            </div>
                                        </td>
                                        <td></td>

                                        <td></td>
                                    </tr>



                                </table>

                                <div class="form-group"> 

                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" name="submit" value="Add" class="btn btn-default">Generate </button>
                                        <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'home.jsp'">Cancel</button>
                                        <button type="button" name="cancel" onclick="resetform()" value="Cancel" class="btn btn-default col-sm-offset-1">Reset</button>
                                    </div>
                                </div>



                                <input type="hidden" name="act" value="1" />
                                <input type="hidden" name="submodule" value="AddRate" />

                            </form>
                        </fieldset>
                    </div>
                </div>
            </div>
    </body>
</html>

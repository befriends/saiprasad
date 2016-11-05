<%-- 
    Document   : SelectDate
    Created on : 28 Sep, 2016, 12:52:05 PM
    Author     : sai
--%>

<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>date wise sale</title>
        <link rel="stylesheet" href="css/style.css" />
        <script src="js/jquery.min.js"></script>
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <!--style for menu-->
        <link href="css/menubarcustomcss.css" rel="stylesheet" type="text/css" />
       
       
        <script type="text/javascript" src="js/jquery.js"></script> 
        <!--script for menu-->
        <!--<script type="text/javascript" src="js/responsivemultimenu.js"></script>-->
        <script src="js/bootstrap.min.js"></script> 
         <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">

        <!--<script type="text/javascript" src="js/calendar.js"></script>-->
        <script type="text/javascript"lang="javascript">

            function resetform() {
                document.getElementById("dateform").reset();
            }

        </script>
        <script type="text/javascript" lang="javascript">
            
             $(document).ready(function ($)
            {
            $("#datepicker").datepicker({
                dateFormat: 'dd/mm/yy'
            });
})(jQuery);
        </script>
    </head>
    <body style="background-color: #555;">
        <jsp:include page="header.jsp"/>
        <div class="container">
            <!--  Body  -->
            <div class="container-fluid">
                <div style="margin-left: auto; margin-right: auto; width: 100%; background-color: powderblue;">

                    <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;">Date Wise Report</span>
                    <div style="max-height: 400px; overflow-y: scroll;overflow-x: hidden;">

                        <form role="form" class="form-horizontal" id="dateform" target="_blank" action="ReportController" method="post"  onkeypress="myFunction()" > 
                            <div class="form-group">
                                <label for="datepicker" class="control-label col-sm-2">Select Date:</label>
                                <div class="col-sm-8">
                                    <input class="date-picker" type="text"  name="datepicker" value="" id="datepicker" placeholder="--- Select Date ---" autofocus="true" required=""/><br><br>
                                </div>
                            </div>
                            <div class="form-group"> 
                                <div class="col-sm-offset-2 col-sm-5">
                                    <button type="submit" name="submit" value="Add" class="btn btn-default" >Generate</button>
                                    <button type="button" name="cancel" value="Cancel" class="btn btn-default col-sm-offset-1" onClick="window.location = 'Home.jsp'">Cancel</button>
                                    <button type="button" name="cancel" onclick="resetform()" value="Reset" class="btn btn-default col-sm-offset-1">Reset</button>
                                </div>
                            </div>
                            <input type="hidden" name="act" value="1" />
                            <input type="hidden" name="submodule" value="datewise" />
                        </form>
                    </div>
                </div>
            </div>
            <!--  Footer  -->
            <div class="container-fluid">
            </div>            
        </div>
    </div>
</body>
</html>

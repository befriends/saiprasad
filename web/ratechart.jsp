<%-- 
    Document   : ratechart
    Created on : 24 Sep, 2016, 3:42:08 PM
    Author     : sai
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="DaoImpl.RateGeneretorDaoImpl"%>
<%@page import="Dao.RateGeneretorDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rate Chart</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--<link href="css/style.css" rel="stylesheet" type="text/css"/>-->
        <script src="js/jquery.js"></script>
    </head>
    <body style="background-color: #d0e9c6;">
        <div class="container" style="font-size: 12px;">
        <%! double snf = 8.5, fat = 3.5, brate = 40.00, fatIncAmount = 0.15, fatDecAmount = 0.50, snfIncAmount = 0.20, snfDecAmount = 0.20;%>
        <% 
            String chartTitle = "Rate Chart";
            double rowfat = 2.5, colsnf = 7.0;
            double chartfat = 2.5, chartsnf = 7.0;
            DecimalFormat df = new DecimalFormat("#.#");
            DecimalFormat form = new DecimalFormat("#.##");
            int isPurchase = request.getParameter("ispurchase") != null ? Integer.parseInt(request.getParameter("ispurchase")) : 0;
            int isSell = request.getParameter("issell") != null ? Integer.parseInt(request.getParameter("issell")) : 0;
            int isCow = request.getParameter("iscow") != null ? Integer.parseInt(request.getParameter("iscow")) : 0;
            int isBuffalo = request.getParameter("isbuffalo") != null ? Integer.parseInt(request.getParameter("isbuffalo")) : 0;
            
            HashMap<String, Integer> params = new HashMap<String, Integer>();
            params.put("iscow", isCow);
            params.put("isbuffalo", isBuffalo);
            params.put("ispurchase", isPurchase);
            params.put("issell", isSell);
            
            RateGeneretorDao rateGeneretorDao = new RateGeneretorDaoImpl();
            JSONObject responseJobj = rateGeneretorDao.getChartDetails(params);
            
            snf = responseJobj.getDouble("snf");
            fat = responseJobj.getDouble("fat");
            brate = responseJobj.getDouble("brate");
            fatIncAmount = responseJobj.getDouble("fatIncAmount");
            fatDecAmount = responseJobj.getDouble("fatDecAmount");
            snfIncAmount = responseJobj.getDouble("snfIncAmount");
            snfDecAmount = responseJobj.getDouble("snfDecAmount");
            
            if(isCow == 1 && isPurchase == 1){
                chartTitle = "Cow Purchase Rate Chart";
            } else if(isBuffalo == 1 && isPurchase == 1){
                chartTitle = "Buffalo Purchase Rate Chart";
            } else if(isCow == 1 && isSell == 1){
                chartTitle = "Cow Sell Rate Chart";
            } else if(isBuffalo == 1 && isSell == 1){
                chartTitle = "Buffalo Purchase Rate Chart";
            }
        %>
        <span class="label label-info center-block" style="height:30px;font-size:20px;font-weight:bolder;vertical-align:middle;margin: 10px 10px 0px 10px;"><%=chartTitle %></span>
        <table style="border-collapse: collapse;margin-left: auto;margin-right: auto;">
            <% for(int row = 0; row <= 20; row++) { %>
            <tr>
                <% for(int col = 0; col <= 20; col++) { 
                    if(row==0 && col==0){
                %>
                    <td style="border: 1px solid white;padding: 5px;background-color: black;">&nbsp;</td>
                <%    
                    } else if(row==0){
                %>
                    <td style="border: 1px solid white;padding: 5px;text-align: center;background-color: black;color: white;font-weight:bolder;"><%=Double.valueOf(df.format(rowfat)) %></td>
                <%    rowfat += 0.1;
                    } else if(col==0){
                %>
                    <td style="border: 1px solid white;padding: 5px;text-align: center;background-color: black;color: white;font-weight:bolder;"><%=Double.valueOf(df.format(colsnf)) %></td>
                <%    colsnf += 0.1;
                    } else{
                        double fatdiff = 0.0;
                        double snfdiff = 0.0;
                        double fatamount = 0.0;
                        double snfamount = 0.0;
                        if(chartfat >= fat){
                            fatdiff = Double.valueOf(form.format(chartfat - fat));
                            fatamount = (fatdiff * fatIncAmount)*10;
                        } else if(chartfat < fat){
                            fatdiff = Double.valueOf(form.format(fat - chartfat));
                            fatamount = (fatdiff * fatDecAmount)*10;
                            fatamount = -fatamount;
                        }
                        
                        if(chartsnf >= snf){
                            snfdiff = Double.valueOf(form.format(chartsnf - snf));
                            snfamount = (snfdiff * snfIncAmount)*10;
                        } else if(chartsnf < snf){
                            snfdiff = Double.valueOf(form.format(snf - chartsnf));
                            snfamount = (snfdiff * snfDecAmount)*10;
                            snfamount = -snfamount;
                        }
                        
                        double amount = brate + Double.valueOf(form.format(fatamount)) + Double.valueOf(form.format(snfamount));
                        String tdcss = "background-color:lightgray";
                        if(snf == Double.valueOf(df.format(chartsnf)) && fat == Double.valueOf(df.format(chartfat))){
                            tdcss="background-color:red;font-weight:bolder;color:white;";
                        } else if(snf == Double.valueOf(df.format(chartsnf))){
                            tdcss="background-color:yellow";
                        } else if(fat == Double.valueOf(df.format(chartfat))){
                            tdcss="background-color:orange";
                        }
                        chartfat += 0.1;
                %>
                    <td style="border: 1px solid black;padding: 5px;text-align: center;<%=tdcss %>;"><%=String.format( "%.2f", Double.valueOf(form.format(amount))) %></td>
                <%  }
                  }
                  if(row!=0){
                      chartfat = 2.5;
                      chartsnf += 0.1;
                  }
                }%>
            </tr>
        </table>
        </div>
    </body>
</html>

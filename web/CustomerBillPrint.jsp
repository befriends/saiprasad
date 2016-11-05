<%-- 
    Document   : BillPrint
    Created on : 28 Oct, 2016, 10:54:59 AM
    Author     : sai
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="Dao.PurchaseSellDao"%>
<%@page import="DaoImpl.PurchaseSellDaoImpl"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery.js"></script>
        <%!
            String startDate = "";
            String selectedDate = "";
            double total = 0;
            String milkManId = "";
            String customerName ="";
             double grandTotal = 0, deduction = 0,totalcommission=0,totalamnt=0;
    String milkType="",remark="",code="";

        %>
        <%  
            PurchaseSellDao purchaseDaoObj = new PurchaseSellDaoImpl();
           startDate = request.getParameter("startDate");
           selectedDate = request.getParameter("selectedDate");
           milkManId = request.getParameter("milkManId");
           remark = request.getParameter("remark");          
          double  totalcommission = Double.parseDouble(request.getParameter("totalcommission").length()==0 ? "0" : request.getParameter("totalcommission"));
          double  totaldeduction = Double.parseDouble(request.getParameter("totaldeduction").length()==0 ? "0" : request.getParameter("totaldeduction"));
           double totalamount = Double.parseDouble(request.getParameter("totalamount").length()==0 ? "0" : request.getParameter("totalamount"));
            JSONObject milkmanJson = purchaseDaoObj.getMilkbilldetails(startDate, selectedDate, milkManId);
            
//            double discount = Double.parseDouble(request.getParameter("disc").length()==0 ? "0" : request.getParameter("disc"));
//            String customer = request.getParameter("customer");
            JSONArray milkmanJsonArr = null;
            if (milkmanJson != null && milkmanJson.has("success") && milkmanJson.has("data")) {
                milkmanJsonArr = milkmanJson.getJSONArray("data");
            }%>
        <style type="text/css" media="print">
            .printbutton {
                visibility: hidden;
                display: none;
            }
            @page { margin: 0.5cm }
        </style>
        <script>
            document.write("<input type='button' " +
                    "onClick='window.print()' " +
                    "class='printbutton' " +
                    "value='Print'/>");
            
            $( document ).ready(function() {
              $(".printbutton").click();
            });
        </script>
    </head>
    <body style="font-size: 10px;">
        <% if (milkmanJsonArr.length() > 0) { %>
            <% 
            double totalMilk = 0, totalRate = 0;
                customerName = milkmanJsonArr.getJSONObject(0).getString("fullname");
                 milkType = milkmanJsonArr.getJSONObject(0).optString("type","");                 
                 code = milkmanJsonArr.getJSONObject(0).optString("code","");                 
            %>
        <%@ include file="printHeader.jsp"%>
        <div style="font-size: 10px; font-weight: bold;text-align: center;">Final Bill</div>
        <style>
        .mynotsoboldtitle { font-weight:normal;line-height: 0%;}
        .lineheight{line-height: 0%;}
        </style>             
       <div> Name:<%=customerName%>&nbsp;|&nbsp;Code.:<%=code%></div>
       <div> Type:<%=milkType%></div>
        <div style="text-align: center;width: 100%;margin-left: auto;margin-right: auto;font-size: 10px;">
            <hr style="border-width: 2px;border-color: black;" />
            <table style="width: 100%;">
                <thead>
                        <tr>
                    <th style="border-bottom: 1px dashed;">Sr.No.</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Date</th>
                    <!--<th style="border-bottom: 1px dashed;text-align: right">Shift</th>-->
                    <th style="border-bottom: 1px dashed;text-align: right">Fat</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Lacto</th>
                    <th style="border-bottom: 1px dashed;text-align: right">S.N.F</th>
                    <th style="border-bottom: 1px dashed; text-align: right">Total Milk</th>
                    <th style="border-bottom: 1px dashed; text-align: right">Rate</th>                    
                    <th style="border-bottom: 1px dashed;text-align: right">Amount</th>      
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                 DecimalFormat twoDForm = new DecimalFormat("#0.00");
                            try {
                              
                                           grandTotal = 0;
                                               for (int i = 0; i < milkmanJsonArr.length(); i++) {
                                                   JSONObject item = milkmanJsonArr.getJSONObject(i);
                                                   String date = item.getString("date");
//                                                   String shift = item.getString("shift");
                                                   double milk = item.getDouble("totalmilk");
                                                   double fat = item.getDouble("fat");
                                                   double lactose = item.getDouble("lacto");
                                                   double SNF = item.getDouble("snf");
                                                   double rate = item.getDouble("rate");
                                                   double totalAmount = Double.parseDouble(item.getString("totalamount"));
                                                   totalAmount = Math.round(totalAmount * 100.0) / 100.0;
                                                   totalMilk += milk;
                                                   totalRate += rate;
                                    
                        %>
                                    <tr>
                                            <td><%=i + 1%></td>
                        <td style="text-align: right"><%=date%></td>                        
                        <td style="text-align: right"><%=fat%></td>
                        <td style="text-align: right"><%=lactose%></td>
                        <td style="text-align: right"><%=SNF%></td>
                        <td style="text-align: right"><%=twoDForm.format(milk)%></td>
                        <td style="text-align: right"><%=twoDForm.format(rate)%></td>
                       
                        <td style="text-align: right"><%=twoDForm.format(totalAmount)%></td>
                                    </tr>
                        <%
                                 grandTotal += totalAmount;
                                }
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                            %>
       <tr>
                        <td colspan="5" style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;">Total : </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;"><%=twoDForm.format(totalMilk)%></td>
                        <td colspan="2" style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;"><%=twoDForm.format(grandTotal)%></td>
                    </tr>
                    <tr>
                        <td colspan="6" style=""> </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;">Deduction For <%=(remark)%>:</td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;"><%=twoDForm.format(totaldeduction)%></td>
                    </tr>
                    <tr>
                        <td colspan="6" style=""> </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;">Commission: </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;"><%=twoDForm.format(totalcommission)%></td>
                    </tr>
                    <tr>
                        <td colspan="6" style=""> </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;">Total: </td>
                        <td style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;"><%=twoDForm.format(totalamount)%></td>
                    </tr>
                 <%} else {
                            %><div style="text-align: center;"><span>No records to display. Please Select Correct Date. </span></div><%
                            }%>
                </tbody>
            </table>
        </div>
Thank You.....!! Visit Again
        </body>
</html>

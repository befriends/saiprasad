<%-- 
    Document   : CustomerNameWiseReport
    Created on : 30 Sep, 2016, 6:37:52 PM
    Author     : sai
--%>


<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    double grandTotal = 0;
    String customerName = "",milkType="";
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
        <title>Purchase Customer Name Wise Report</title>
        <%
            JSONObject jobj = new JSONObject(request.getParameter("result"));
            JSONArray jarr = null;
            if (jobj != null && jobj.has("success") && jobj.has("data")) {
                jarr = jobj.getJSONArray("data");
                for (int i= 0; jarr.length() > i; i++ ){
                    customerName = jarr.getJSONObject(i).optString("fullname","");
                    milkType = jarr.getJSONObject(i).optString("type","");
                }

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
                    "value='Print'" +
                    "id='prt1'/>");

        </script>
    </head>
    <body>

        <style>
            .mynotsoboldtitle { font-weight:normal;line-height: 0%;}
            .lineheight{line-height: 0%;}
        </style>
        <% if (jarr.length() > 0) { %>
        <%@ include file="printHeader.jsp"%>
        <div style="font-size: 12px; font-weight: bold;text-align: center;">Purchase Customer Name Report</div>
        <div style="text-align: left;font-size: 10px;">Customer Name : <%=customerName%></div>
        <div style="text-align: left;font-size: 10px;">Milk Type : <%=milkType%></div>
        <div style="text-align: center;width: 100%;margin-left: auto;margin-right: auto;font-size: 13px;">
        <hr style="border-width: 2px;border-color: black;">
        <table style="width: 100%;">
            <thead>
                <tr>
                    <th style="border-bottom: 1px dashed;">Sr.No.</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Date</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Shift</th>
                    <th style="border-bottom: 1px dashed; text-align: right">Total Milk</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Fat</th>
                    <th style="border-bottom: 1px dashed;text-align: right">Lacto</th>
                    <th style="border-bottom: 1px dashed;text-align: right">S.N.F</th>
                    <th style="border-bottom: 1px dashed; text-align: right">Rate</th>
                    <!--<th style="border-bottom: 1px dashed;">Type</th>-->     
                    <th style="border-bottom: 1px dashed;text-align: right">Total Amount</th>                            
                    <!--<th style="border-bottom: 1px dashed; text-align: right">Amt</th>-->
                </tr>
            </thead>
            <tbody>
                    <%
                        DecimalFormat twoDForm = new DecimalFormat("#0.00");
                        try {
                               grandTotal=0;
                                                          
                            for (int i = 0; i < jarr.length(); i++) {
                                int j = 0;
                                JSONObject orderObj = jarr.getJSONObject(i);
                                JSONObject item = jarr.getJSONObject(i);
                                String date = item.getString("date");
                                String shift = item.getString("shift");
                                Double totalMilk = item.getDouble("totalmilk");
                                Double fat = item.getDouble("fat");
                                Double lactose = item.getDouble("lacto");
                                Double SNF = item.getDouble("snf");
                                Double rate = item.getDouble("rate");
//                                String type = item.getString("type");
//                                Date purchasedate = new Date(item.getLong("purchasematerialdate"));
//
//                                String orderDate = purchasedate.getDate() + "/" + (purchasedate.getMonth() + 1) + "/" + (purchasedate.getYear() + 1900);
//                                float price = Float.parseFloat(item.getString("unitprice"));
//                                Long quantity = item.getLong("quantity");
                                double totalAmount = Double.parseDouble(item.getString("totalamount"));
                                totalAmount= Math.round(totalAmount*100.0)/100.0;
                    %>
                    <tr>
                        <td><%=i + 1%></td>
                        <td style="text-align: right"><%=date%></td>
                        <td style="text-align: right"><%=shift%></td>
                        <td style="text-align: right"><%=totalMilk%></td>
                        <td style="text-align: right"><%=fat%></td>
                        <td style="text-align: right"><%=lactose%></td>
                        <td style="text-align: right"><%=SNF%></td>
                        <td style="text-align: right"><%=rate%></td>
                       
                        <td style="text-align: right"><%=twoDForm.format(totalAmount)%></td>
                    </tr>
                    <%
                                grandTotal += totalAmount;
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    %> 
                    <tr><td colspan="6" style="border-top: 1px dashed; border-bottom: 1px dashed; font-weight: bold; text-align: right;">Total : <%=twoDForm.format(grandTotal)%></td></tr>
                 <%} else {
                            %><div style="text-align: center;"><span>No records to display.</span></div><%
                            }%>
            </tbody>
            </table>                                    
            <div style="height: 20px;"></div>
    </body>
</html>

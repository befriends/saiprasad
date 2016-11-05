/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import Dao.BillingDAO;
import com.sun.org.apache.xalan.internal.xsltc.compiler.util.Type;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class BillingDAOImpl implements BillingDAO{
    
    @Override
    public JSONObject generateCustomerBill(HashMap<String, String> params) throws JSONException, IOException, SQLException{
        JSONObject responJSONObject = new JSONObject();
        Connection con = null;
        try {
            con = DBConnection.DBPool.getConnection();
            con.setAutoCommit(false);
            
            String milkmanbillid = UUID.randomUUID().toString();
            String milkmanid = params.get("milkmanid");
            String milkmanname = params.get("milkmanname");
            String startdate = params.get("startdate");
            String enddate = params.get("enddate");
            double commission = Double.parseDouble(params.get("commission"));
            double deduction = Double.parseDouble(params.get("deduction"));
            String remarks = params.get("remarks");
            double subtotal = Double.parseDouble(params.get("subtotal"));
            double totalamount = Double.parseDouble(params.get("totalamount"));
            double totalcommission = Double.parseDouble(params.get("totalcommission"));
            double totaldeduction = Double.parseDouble(params.get("totaldeduction"));
            double totalmillk = Double.parseDouble(params.get("totalmillk"));
            
            String fromyear = enddate.substring(enddate.lastIndexOf("/") + 1);
            String frommonth = enddate.substring(enddate.indexOf("/") + 1, enddate.lastIndexOf("/"));
            String fromday = enddate.substring(0, enddate.indexOf("/"));
            
            String year = startdate.substring(startdate.lastIndexOf("/") + 1);
            String month = startdate.substring(startdate.indexOf("/") + 1, startdate.lastIndexOf("/"));
            String day = startdate.substring(0, startdate.indexOf("/"));

            long enddateLong = new java.util.Date(fromyear + "/" + frommonth + "/" + fromday).getTime();
            long startdateLong = new java.util.Date(year + "/" + month + "/" + day).getTime();
            
            String sql = "insert into milkmanbilldetails(idmilkmanbilldetails, billgenerateddate, milkmanid, startdate, enddate, remark, commission, deduction, totalmilk, subtotal, totalcommission, totaldeduction, totalamnt) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
            
            PreparedStatement pst = con.prepareCall(sql);
            pst.setString(1, milkmanbillid);
            pst.setLong(2, enddateLong);
            pst.setString(3, milkmanid);
            pst.setLong(4, startdateLong);
            pst.setLong(5, enddateLong);
            pst.setString(6, remarks);
            pst.setDouble(7, commission);
            pst.setDouble(8, deduction);
            pst.setDouble(9, totalmillk);
            pst.setDouble(10, subtotal);
            pst.setDouble(11, totalcommission);
            pst.setDouble(12, totaldeduction);
            pst.setDouble(13, totalamount);
            
            int count = pst.executeUpdate();
            
            if(count == 1){
                sql = "update daillycollection set billgenerationflag = 1 where `date`>='"+ startdate +"' and `date`<='"+ enddate +"' and milkmanid='"+ milkmanid +"'";
                Statement st = con.createStatement();
                int res = st.executeUpdate(sql);
                if(res > 0){
                    con.commit();
                    responJSONObject.put("success", true);
                    responJSONObject.put("message", "Bill generated successfully.");
                } else{
                    con.rollback();
                    responJSONObject.put("success", false);
                    responJSONObject.put("errormessage", "Some error occurred during bill generation. Please try again.");
                }
            } else{
                con.rollback();
                responJSONObject.put("success", false);
                responJSONObject.put("errormessage", "Some error occurred during bill generation. Please try again.");
            }
            
        } catch (Exception e) {
            con.rollback();
            responJSONObject.put("success", false);
            responJSONObject.put("errormessage", "Some error occurred. Please try again.");
        } finally{
            con.close();
        }
        
        return responJSONObject;
    }
    
    public JSONObject generateDairyBill(HashMap<String, String> params) throws JSONException, IOException, SQLException{
        JSONObject responJSONObject = new JSONObject();
        Connection conn = null; 
        String milkDairyBillDetailsId ="",dairyId="",dairyName="",startDate="",endDate="",remarks="";
        double commission =0,deduction=0,subTotal=0,totalMilk=0,totalAmount=0,totalCommisssion=0,totalDeduction=0;
        try{
            conn =DBConnection.DBPool.getConnection();
            conn.setAutoCommit(false);
            milkDairyBillDetailsId = UUID.randomUUID().toString();
            dairyId = StringUtils.isNotEmpty(params.get("dairyid"))? params.get("dairyid"):"";
            dairyName = params.get("dairyname");
            startDate = params.get("startdate");
            endDate = params.get("enddate");
            commission =Double.parseDouble(params.get("commission"));
            deduction =Double.parseDouble(params.get("deduction"));
            remarks = params.get("remarks");
            subTotal =Double.parseDouble(params.get("subtotal"));
            totalAmount =Double.parseDouble(params.get("totalamount"));
            totalCommisssion =Double.parseDouble(params.get("totalcommission"));
            totalDeduction = Double.parseDouble(params.get("totaldeduction"));
            totalMilk = Double.parseDouble(params.get("totalmillk"));
            
           String fromyear = endDate.substring(endDate.lastIndexOf("/") + 1);
            String frommonth = endDate.substring(endDate.indexOf("/") + 1, endDate.lastIndexOf("/"));
            String fromday = endDate.substring(0, endDate.indexOf("/"));
            
            String year = startDate.substring(startDate.lastIndexOf("/") + 1);
            String month = startDate.substring(startDate.indexOf("/") + 1, startDate.lastIndexOf("/"));
            String day = startDate.substring(0, startDate.indexOf("/"));

            long enddateLong = new java.util.Date(fromyear + "/" + frommonth + "/" + fromday).getTime();
            long startdateLong = new java.util.Date(year + "/" + month + "/" + day).getTime();
           
            String sql = "insert into milkdairybilldetails(idmilkdairybilldetails, billgenerateddate, dairyid, startdate, enddate, remark, commission, deduction, totalmilk, subtotal, totalcommission, totaldeduction, totalamnt) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareCall(sql);
            pst.setString(1, milkDairyBillDetailsId);
            pst.setLong(2, enddateLong);
            pst.setString(3, dairyId);
            pst.setLong(4, startdateLong);
            pst.setLong(5, enddateLong);
            pst.setString(6, remarks);
            pst.setDouble(7, commission);
            pst.setDouble(8, deduction);
            pst.setDouble(9, totalMilk);
            pst.setDouble(10, subTotal);
            pst.setDouble(11, totalCommisssion);
            pst.setDouble(12, totalDeduction);
            pst.setDouble(13, totalAmount);
            
            int count = pst.executeUpdate();
             if(count == 1){
                sql = "update sellentry set billgenerationflag = 1 where `date`>='"+ startDate +"' and `date`<='"+ endDate +"' and dairyid='"+ dairyId +"'";
                Statement st = conn.createStatement();
                int res = st.executeUpdate(sql);
                if(res > 0){
                    conn.commit();
                    responJSONObject.put("success", true);
                    responJSONObject.put("message", "Bill generated successfully.");
                } else{
                    conn.rollback();
                    responJSONObject.put("success", false);
                    responJSONObject.put("errormessage", "Some error occurred during bill generation. Please try again.");
                }
            } else{
                conn.rollback();
                responJSONObject.put("success", false);
                responJSONObject.put("errormessage", "Some error occurred during bill generation. Please try again.");
            }
            
        }catch(Exception e){
            conn.rollback();
            
        }finally{
            conn.close();
        }
        return null;
    }
}

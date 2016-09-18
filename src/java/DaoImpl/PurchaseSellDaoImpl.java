/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import DBConnection.DBPool;
import Dao.MilkSupplierDao;
import Dao.PurchaseSellDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
/**
 *
 * @author vishwas
 */
public class PurchaseSellDaoImpl implements PurchaseSellDao{

        Connection conn = null;  
    @Override    
    public JSONObject addMilkPurchaseDetails(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;
        String milkmanid = "";
        JSONObject resultJSONObject = new JSONObject();
        String date = "", customername = "", milktype = "", liter = "", fat = "", lactose = "", shift = "", remark = "";
        long id = 0;
        try {
            Connection conn = DBPool.getConnection();
//            PreparedStatement pst = conn.prepareStatement("select id from milkmandetails where code = ?");
//            pst.setString(1, params.get("code"));
//            ResultSet rs = pst.executeQuery();
//            if (rs!=null) {
//                while(rs.next()){
//                    milkmanid = rs.getString(1);
//                }
            date = StringUtils.isNotEmpty(params.get("date")) ? params.get("date") : "";

            if (StringUtils.isNotEmpty(params.get("milkid"))) {
                id = Long.parseLong(params.get("milkid"));
            }
            customername = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            milktype = StringUtils.isNotEmpty(params.get("milktype")) ? params.get("milktype") : "";
            liter = StringUtils.isNotEmpty(params.get("liter")) ? params.get("liter") : "";
            fat = StringUtils.isNotEmpty(params.get("fat")) ? params.get("fat") : "";
            lactose = StringUtils.isNotEmpty(params.get("lactose")) ? params.get("lactose") : "";
            shift = StringUtils.isNotEmpty(params.get("shift")) ? params.get("shift") : "";
            remark = StringUtils.isNotEmpty(params.get("remark")) ? params.get("remark") : "";
            conn = DBPool.getConnection();

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
            pst = conn.prepareStatement("select count(*) from purchase_entry where id = ?");
            pst.setLong(1, id);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into purchase_entry(id,fat,lacto,date,shift,type,remark) values(?,?,?,?,?,?,?)");
                pst.setLong(1, id);
                pst.setString(2, fat);
                pst.setString(3, lactose);
//                pst.setString(4, "snf");
//                pst.setString(5, "subtotal");
//                pst.setString(6,"deduction");
//                pst.setString(7, "totalamount");
                pst.setString(4, date);
                pst.setString(5, shift);
                pst.setString(6, milktype);
                pst.setString(7, remark);
                int r = pst.executeUpdate();
                if (r > 0) {
                    resultJSONObject.put("message", "Record Added Successfully.");
                    resultJSONObject.put("success", true);
                } else {
                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                    resultJSONObject.put("success", false);
                }
            } else {
                resultJSONObject.put("success", "false");
            }
        } catch (Exception e) {

            resultJSONObject.put("success", "false");
            e.printStackTrace();
        }
        return resultJSONObject;
    }
    @Override    
    public JSONObject updateMilkPurchaseDetails(HashMap<String, String> params) throws JSONException,IOException {
        JSONObject resultJSONObject = new JSONObject();
        return resultJSONObject;
    }  
    
    public JSONObject deleteMilkPurchaseDetails(String id) throws JSONException,IOException {
        JSONObject resultJSONObject = new JSONObject();
            try {
                Connection conn = DBPool.getConnection();
                PreparedStatement pst;
                pst = conn.prepareStatement("delete from purchase_entry where purchaseid= ?");
                pst.setString(1, id);
                ResultSet rs = pst.executeQuery();
                resultJSONObject.put("success", "true");
            } catch (SQLException ex) {
                resultJSONObject.put("success", "false");
                Logger.getLogger(PurchaseSellDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        return resultJSONObject;
    }

    @Override
    public JSONObject getCollectionDetails(HashMap<String, String> params) {
        JSONObject jobj = null;
        try {
            conn = DBPool.getConnection();
            Statement st = conn.createStatement();
            
            String sql="select custid,lacto,fat from purchse_entry where code='"+params.get("codeno")+"'";
            
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                jobj.put("customername", rs.getString(0));
                jobj.put("lacto", rs.getDouble(1));
                jobj.put("fat", rs.getDouble(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobj;
    }
     @Override
    public JSONObject getCategoryList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            rs = st.executeQuery("select id,code,type,fullname from milkmandetails where isdeleted=0 order by fullname");
//            rs = st.executeQuery("select p.id,m.code,m.type,m.fullname from purchase_entry p,milkmandetails m where p.id=m.id ");
           //String query = "Select p.purchaseid,p.id,m.code,m.type from purchase_entry p,milkmandetails m where p.id=m.id ";


            if (null != rs) {

                while (rs.next()) {

                    JSONObject jobj = new JSONObject();

                    jobj.put("id", rs.getLong(1));

                    jobj.put("code", null != rs.getString(2) ? rs.getString(2) : "");

                     jobj.put("type", null != rs.getString(3) ? rs.getString(3) : "");
                    
                    jobj.put("fullname", null != rs.getString(4) ? rs.getString(4) : "");

                    jarr.put(jobj);
                }
            }

            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (JSONException e) {
            Logger.getLogger(PurchaseSellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (SQLException e) {
            Logger.getLogger(PurchaseSellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }

        return returnJSONObject;
    }
     @Override
    public JSONObject getSubCategoryList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            String query = "Select p.purchaseid,p.id,m.code,m.type from purchase_entry p,milkmandetails m where p.id=m.id ";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("purchaseid", rs.getLong(1));
                    jobj.put("id", rs.getLong(2));
                    jobj.put("code", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("type", null != rs.getString(4) ? rs.getString(4) : "");
                  //  jobj.put("fullname", null != rs.getString(5) ? rs.getString(5) : "");
                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (SQLException e) {
            Logger.getLogger(PurchaseSellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (JSONException e) {
            Logger.getLogger(PurchaseSellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } 
        return returnJSONObject;
    }
     @Override
    public JSONObject getSubCategoryListJson(String id) throws Exception {
    
        JSONObject returnJSONObject = new JSONObject();
        JSONArray jarr = new JSONArray();
        ResultSet rs = null;
        try{
            
            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            long categoryId = Long.parseLong(id);
            
            String query = "Select fullname,type from milkmandetails where id="+categoryId;

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("fullname", null != rs.getString(1) ? rs.getString(1) : "");
                    jobj.put("type", null != rs.getString(2) ? rs.getString(2) : "");
                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);
            returnJSONObject.put("isSuccess", true);
            
        } catch(Exception ex){
            ex.printStackTrace();
            returnJSONObject.put("data", "");
            returnJSONObject.put("isSuccess", false);
        } finally{
            conn.close();
        }
        
        return returnJSONObject;
    }
    @Override
    public JSONObject addPurchaseFood(HashMap< String, String> params) throws JSONException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        String customId = "", date = "", companyName = "", foodName = "", quantity = "", purchaseRate = "", sellRate = "", subTotal = "", discount = "", totalAmount = "";
        try {
            Connection conn = DBPool.getConnection();
            customId = StringUtils.isNotEmpty(params.get("code")) ? params.get("code") : "";
            date = StringUtils.isNotEmpty(params.get("date")) ? params.get("date") : "";
            companyName = StringUtils.isNotEmpty(params.get("companyname")) ? params.get("companyname") : "";
            foodName = StringUtils.isNotEmpty(params.get("foodname")) ? params.get("foodname") : "";
            quantity = StringUtils.isNotEmpty(params.get("quantity")) ? params.get("quantity") : "";
            purchaseRate = StringUtils.isNotEmpty(params.get("purchaserate")) ? params.get("purchaserate") : "";
            sellRate = StringUtils.isNotEmpty(params.get("sellrate")) ? params.get("sellrate") : "";
            subTotal = StringUtils.isNotEmpty(params.get("subtotal")) ? params.get("subtotal") : "";
            discount = StringUtils.isNotEmpty(params.get("discount")) ? params.get("discount") : "";
            totalAmount = StringUtils.isNotEmpty(params.get("totalamount")) ? params.get("totalamount") : "";
            PreparedStatement pst = null;
            if (StringUtils.isNotEmpty(foodName)) {
                pst = conn.prepareStatement("insert into purchasefood(date,companyname,foodname,quantity,purchaserate,sellrate,subtotal,discount,totalamount,code) values(?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, date);
                pst.setString(2, companyName);
                pst.setString(3, foodName);
                pst.setString(4, quantity);
                pst.setString(5, purchaseRate);
                pst.setString(6, sellRate);
                pst.setString(7, subTotal);
                pst.setString(8, discount);
                pst.setString(9, totalAmount);
                pst.setString(10, customId);
                int r = pst.executeUpdate();
                if (r > 0) {
                    resultJSONObject.put("message", "Record Added Successfully.");
                    resultJSONObject.put("success", true);
                } else {
                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                    resultJSONObject.put("success", false);
                }
            } else {
                resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                resultJSONObject.put("success", "false");
            }
        } catch (Exception e) {

            resultJSONObject.put("success", "false");
            e.printStackTrace();
        }
        return resultJSONObject;

    }
}
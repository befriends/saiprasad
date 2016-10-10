/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.MilkSupplierDao;
import Dao.PurchaseSellDao;
import com.mysql.jdbc.StringUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author vishwas
 */
public class PurchaseSellDaoImpl implements PurchaseSellDao {

    Connection conn = null;

    @Override
    public JSONObject addMilkPurchaseDetails(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;
        String milkmanid = "";
        JSONObject resultJSONObject = new JSONObject();
        String date = "", milkmanname = "", milktype = "", liter = "", fat = "", lactose = "", shift = "", remark = "", SNF = "";
        double fatDiff = 0, snfDiff = 0, incrementPerFat = 0, incrementPerSNF = 0, decrementPerFat = 0, decreamentPerSNF = 0, fatAmount = 0, snfAmount = 0, enterFat = 0, enterSNF = 0, basicFat = 0, basicSNF = 0, bRate = 0, totalamount = 0, decrementAmount = 0, enterLactose = 0;
        String rategeneratorid = "";
        DecimalFormat form = new DecimalFormat("#.##");
        ResultSet rs = null;
        try {
            Connection conn = DBPool.getConnection();

            date = !StringUtils.isNullOrEmpty(params.get("date")) ? params.get("date") : "";
            milkmanid = !StringUtils.isNullOrEmpty(params.get("milkmanid")) ? params.get("milkmanid") : "";
            milkmanname = !StringUtils.isNullOrEmpty(params.get("milkmanname")) ? params.get("milkmanname") : "";
            milktype = !StringUtils.isNullOrEmpty(params.get("milktype")) ? params.get("milktype") : "";
            liter = !StringUtils.isNullOrEmpty(params.get("liter")) ? params.get("liter") : "";
            fat = !StringUtils.isNullOrEmpty(params.get("fat")) ? params.get("fat") : "";
            lactose = !StringUtils.isNullOrEmpty(params.get("lactose")) ? params.get("lactose") : "";
            SNF = !StringUtils.isNullOrEmpty(params.get("snf")) ? params.get("snf") : "";
            shift = !StringUtils.isNullOrEmpty(params.get("shift")) ? params.get("shift") : "";
            remark = !StringUtils.isNullOrEmpty(params.get("remark")) ? params.get("remark") : "";
             PreparedStatement pst = null;
             PreparedStatement pst1 = null;
            Statement st = conn.createStatement();
            pst1 = conn.prepareStatement("select count(*) from daillycollection where date = ? and milkmanid = ? and shift=?");
            pst1.setString(1, date);
            pst1.setString(2, milkmanid);
            pst1.setString(3, shift);
             rs = pst1.executeQuery();
            rs.next();

            int isbuffelo = 0, iscow = 0;
            switch (milktype) {
                case "COW":
                    iscow = 1;
                    break;
                case "BUFFALO":
                    isbuffelo = 1;
                    break;
            }
            conn = DBPool.getConnection();

//            PreparedStatement pst = null;
          st = conn.createStatement();
            ResultSet rs1 = st.executeQuery("select rategeneratorid,brate,bfat,bsnf,dperfat,aperfat,dpersnf,apersnf from rategenerator where activeflag=1 and iscow=" + iscow + " and isbuffalo=" + isbuffelo);

            while (rs1.next()) {
                rategeneratorid = rs1.getString(1);
                bRate = rs1.getDouble(2);
                basicFat = rs1.getDouble(3);
                basicSNF = rs1.getDouble(4);
                decrementPerFat = rs1.getDouble(5);
                incrementPerFat = rs1.getDouble(6);
                decreamentPerSNF = rs1.getDouble(7);
                incrementPerSNF = rs1.getDouble(8);
                enterFat = Double.parseDouble(fat);
                enterSNF = Double.parseDouble(SNF);
                enterLactose = Double.parseDouble(lactose);
            }

            if (enterFat >= basicFat) {
                fatDiff = Double.valueOf(form.format(enterFat - basicFat));
                fatAmount = (fatDiff * incrementPerFat) * 10;
            } else if (enterFat < basicFat) {
                fatDiff = Double.valueOf(form.format(basicFat - enterFat));
                fatAmount = (fatDiff * decrementPerFat) * 10;
                fatAmount = -fatAmount;
            }

            if (enterSNF >= basicSNF) {
                snfDiff = Double.valueOf(form.format(enterSNF - basicSNF));
                snfAmount = (snfDiff * incrementPerSNF) * 10;
            } else if (enterSNF < basicSNF) {
                snfDiff = Double.valueOf(form.format(basicSNF - enterSNF));
                snfAmount = (snfDiff * decreamentPerSNF) * 10;
                snfAmount = -snfAmount;
            }
            double rate = bRate + Double.valueOf(form.format(fatAmount)) + Double.valueOf(form.format(snfAmount));
            double liter1 = Double.parseDouble(liter);
            double totalamount1 = liter1 * rate;
            totalamount = Double.valueOf(form.format(totalamount1));
//                     

            if (rs.getInt(1) == 0) {
            pst = conn.prepareStatement("insert into daillycollection(purchaseid,rategeneratorid,fat,lacto,snf,totalmilk,rate,totalamount,date,shift,type,remark,milkmanid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pst.setString(1, UUID.randomUUID().toString());
            pst.setString(2, rategeneratorid);
            pst.setDouble(3, enterFat);
            pst.setDouble(4, enterLactose);
            pst.setDouble(5, enterSNF);
            pst.setDouble(6, liter1);
            pst.setDouble(7, rate);
            pst.setDouble(8, totalamount);
            pst.setString(9, date);
            pst.setString(10, shift);
            pst.setString(11, milktype);
            pst.setString(12, remark);
            pst.setString(13, milkmanid);
            int r = pst.executeUpdate();
            if (r > 0) {
                resultJSONObject.put("message", "Record Added Successfully.");
                resultJSONObject.put("success", true);
            } else {
                resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                resultJSONObject.put("success", false);
            }
        }
        else {  
                resultJSONObject.put("message", "MilkmanId  is already used. Please try another.");
                resultJSONObject.put("success", false);
            }
        } catch (Exception e) {

            resultJSONObject.put("success", "false");
            e.printStackTrace();
        }
        return resultJSONObject;
    }

    @Override
    public JSONObject updateMilkPurchaseDetails(HashMap<String, String> params) throws JSONException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        return resultJSONObject;
    }

    public JSONObject deleteMilkPurchaseDetails(String id) throws JSONException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        try {
            Connection conn = DBPool.getConnection();
            PreparedStatement pst;
            pst = conn.prepareStatement("delete from daillycollection where purchaseid= ?");
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

            String sql = "select custid,lacto,fat from daillycollection where code='" + params.get("codeno") + "'";

            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
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
    public JSONObject getMilkmandetailsList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            rs = st.executeQuery("select milkmanid,code,type,fullname from milkmandetails where isdeleted=0 order by fullname");
//            rs = st.executeQuery("select p.id,m.code,m.type,m.fullname from purchase_entry p,milkmandetails m where p.id=m.id ");
            //String query = "Select p.purchaseid,p.id,m.code,m.type from purchase_entry p,milkmandetails m where p.id=m.id ";

            if (null != rs) {

                while (rs.next()) {

                    JSONObject jobj = new JSONObject();

                    jobj.put("milkmanid", rs.getString(1));

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
    public JSONObject getMilkManRecordList(String selectedDate) throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
            String query = "";
            if (selectedDate.equals("")) {
                query = "Select d.purchaseid,d.fat,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code,d.shift from daillycollection d,milkmandetails m where d.milkmanid=m.milkmanid ";
            } else {
                query = "Select d.purchaseid,d.fat,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code,d.shift from daillycollection d,milkmandetails m where d.milkmanid=m.milkmanid and d.date= '" + selectedDate + "'";
            }
            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("purchaseid", null != rs.getString(1) ? rs.getString(1) : "");
                    jobj.put("fat", rs.getDouble(2));
                    jobj.put("lacto", rs.getDouble(3));
                    jobj.put("rate", rs.getDouble(4));
                    jobj.put("totalmilk", rs.getDouble(5));
                    jobj.put("totalamount", rs.getDouble(6));
                    jobj.put("date", null != rs.getString(7) ? rs.getString(7) : "");
                    jobj.put("type", null != rs.getString(8) ? rs.getString(8) : "");
                    jobj.put("milkmanid", null != rs.getString(9) ? rs.getString(9) : "");
                    jobj.put("code", null != rs.getString(10) ? rs.getString(10) : "");
                    jobj.put("shift", null != rs.getString(11) ? rs.getString(11) : "");
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
    public JSONObject getMilkbilldetails(String startDate, String selectedDate, String milkManId) throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
            String query = "";
            if (selectedDate.equals("")) {
                query = "Select d.purchaseid,d.fat,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code from daillycollection d,milkmandetails m where d.milkmanid=m.milkmanid ";
            } else {
                query = "Select d.purchaseid,d.fat,d.snf,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code from daillycollection d,milkmandetails m where d.date BETWEEN '" + startDate + "' AND '" + selectedDate + "' and d.milkmanid='" + milkManId + "' and d.milkmanid=m.milkmanid";
            }
            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("purchaseid", null != rs.getString(1) ? rs.getString(1) : "");
                    jobj.put("fat", rs.getDouble(2));
                    jobj.put("snf", rs.getDouble(3));
                    jobj.put("lacto", rs.getDouble(4));
                    jobj.put("rate", rs.getDouble(5));
                    jobj.put("totalmilk", rs.getDouble(6));
                    jobj.put("totalamount", rs.getDouble(7));
                    jobj.put("date", null != rs.getString(8) ? rs.getString(8) : "");
                    jobj.put("type", null != rs.getString(9) ? rs.getString(9) : "");
                    jobj.put("milkmanid", null != rs.getString(10) ? rs.getString(10) : "");
                    jobj.put("code", null != rs.getString(11) ? rs.getString(11) : "");

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
    public JSONObject getMilkType(String milkmanid) throws Exception {

        JSONObject returnJSONObject = new JSONObject();
        JSONArray jarr = new JSONArray();
        ResultSet rs = null;
        try {

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            String milkmanID = StringUtils.isNullOrEmpty(milkmanid) ? "" : milkmanid;

            String query = "Select type from milkmandetails where milkmanid='" + milkmanID + "'";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("id", null != rs.getString(1) ? rs.getString(1) : "");
                    jobj.put("name", null != rs.getString(1) ? rs.getString(1) : "");
                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);
            returnJSONObject.put("isSuccess", true);

        } catch (Exception ex) {
            ex.printStackTrace();
            returnJSONObject.put("data", "");
            returnJSONObject.put("isSuccess", false);
        } finally {
            conn.close();
        }

        return returnJSONObject;
    }

    @Override
    public JSONObject getNewDate(String milkmanid) throws Exception {

        JSONObject returnJSONObject = new JSONObject();
        JSONArray jarr = new JSONArray();
        ResultSet rs = null;
        try {

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            String milkmanID = StringUtils.isNullOrEmpty(milkmanid) ? "" : milkmanid;

            String query = "Select billgenerateddate from milkmanbillmapping where milkmanid='" + milkmanID + "'";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("billgenerateddate", rs.getLong(1));

                    long Value = rs.getLong(1);
                    Date date = new Date(Value);
                    SimpleDateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
                    String dateText = df2.format(date);

                    Calendar c = Calendar.getInstance();
                    c.setTime(df2.parse(dateText));
                    c.add(Calendar.DATE, 1);
                    dateText = df2.format(c.getTime());

                    jarr.put(dateText);

                }
            }

            returnJSONObject.put("data", jarr);
            returnJSONObject.put("isSuccess", true);

        } catch (Exception ex) {
            ex.printStackTrace();
            returnJSONObject.put("data", "");
            returnJSONObject.put("isSuccess", false);
        } finally {
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
            customId = !StringUtils.isNullOrEmpty(params.get("code")) ? params.get("code") : "";
            date = !StringUtils.isNullOrEmpty(params.get("date")) ? params.get("date") : "";
            companyName = !StringUtils.isNullOrEmpty(params.get("companyname")) ? params.get("companyname") : "";
            foodName = !StringUtils.isNullOrEmpty(params.get("foodname")) ? params.get("foodname") : "";
            quantity = !StringUtils.isNullOrEmpty(params.get("quantity")) ? params.get("quantity") : "";
            purchaseRate = !StringUtils.isNullOrEmpty(params.get("purchaserate")) ? params.get("purchaserate") : "";
            sellRate = !StringUtils.isNullOrEmpty(params.get("sellrate")) ? params.get("sellrate") : "";
            subTotal = !StringUtils.isNullOrEmpty(params.get("subtotal")) ? params.get("subtotal") : "";
            discount = !StringUtils.isNullOrEmpty(params.get("discount")) ? params.get("discount") : "";
            totalAmount = !StringUtils.isNullOrEmpty(params.get("totalamount")) ? params.get("totalamount") : "";
            PreparedStatement pst = null;
            if (!StringUtils.isNullOrEmpty(foodName)) {
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

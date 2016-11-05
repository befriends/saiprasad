/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.SellDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
import org.eclipse.jdt.internal.compiler.lookup.TypeIds;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class SellDaoImpl implements SellDao {

    Connection conn = null;

//    @Override
//    public JSONObject addDairySell(HashMap<String, String> params) throws JSONException, IOException {
//        boolean result = false;
//        String milkmanid = "";
//        JSONObject resultJSONObject = new JSONObject();
//        String code = "", dairyName = "", personName = "", alternateName = "", Address = "", mobile = "", alternateNumber = "", accountNumber = "", branchName = "", tankerNumber = "", amount = "", type = "";
//        long id = 0;
//        try {
//            Connection conn = DBPool.getConnection();
////            PreparedStatement pst = conn.prepareStatement("select id from milkmandetails where code = ?");
////            pst.setString(1, params.get("code"));
////            ResultSet rs = pst.executeQuery();
////            if (rs!=null) {
////                while(rs.next()){
////                    milkmanid = rs.getString(1);
////                }
//            code = StringUtils.isNotEmpty(params.get("code")) ? params.get("code") : "";
//            dairyName = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
//            personName = StringUtils.isNotEmpty(params.get("personname")) ? params.get("personname") : "";
//            alternateName = StringUtils.isNotEmpty(params.get("altername")) ? params.get("altername") : "";
//            Address = StringUtils.isNotEmpty(params.get("address")) ? params.get("address") : "";
//            mobile = StringUtils.isNotEmpty(params.get("mobile")) ? params.get("mobile") : "";
//            alternateNumber = StringUtils.isNotEmpty(params.get("alternumber")) ? params.get("alternumber") : "";
//            accountNumber = StringUtils.isNotEmpty(params.get("account")) ? params.get("account") : "";
//            branchName = StringUtils.isNotEmpty(params.get("accountbranch")) ? params.get("accountbranch") : "";
//            tankerNumber = StringUtils.isNotEmpty(params.get("tankernumber")) ? params.get("tankernumber") : "";
//            amount = StringUtils.isNotEmpty(params.get("amount")) ? params.get("amount") : "";
//            type = StringUtils.isNotBlank(params.get("type")) ? params.get("type") : "";
//
//            PreparedStatement pst = null;
//            Statement st = conn.createStatement();
//            pst = conn.prepareStatement("select count(*) from dairysell where dairyid = ?");
//            pst.setString(1, code);
//            ResultSet rs = pst.executeQuery();
//            rs.next();
//
//            if (rs.getInt(1) == 0) {
//
//                pst = conn.prepareStatement("insert into dairysell(code,dairyname,personname,alternatename,mobile,alternatemobile,accountno,branchname,tankerno,amount,type) values(?,?,?,?,?,?,?,?,?,?,?)");
//                pst.setString(1, code);
//                pst.setString(2, dairyName);
//                pst.setString(3, personName);
//                pst.setString(4, alternateNumber);
//                pst.setString(5, mobile);
//                pst.setString(6, alternateNumber);
//                pst.setString(7, accountNumber);
//                pst.setString(8, branchName);
//                pst.setString(9, tankerNumber);
//                pst.setString(10, amount);
//                pst.setString(11, type);
//
//                int r = pst.executeUpdate();
//                if (r > 0) {
//                    resultJSONObject.put("message", "Record Added Successfully.");
//                    resultJSONObject.put("success", true);
//                } else {
//                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
//                    resultJSONObject.put("success", false);
//                }
//            } else {
//                resultJSONObject.put("success", "false");
//            }
//        } catch (Exception e) {
//
//            resultJSONObject.put("success", "false");
//            e.printStackTrace();
//        }
//        return resultJSONObject;
//    }

    @Override
    public JSONObject addDailySell(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;

        JSONObject resultJSONObject = new JSONObject();
        String date = "", code = "",dairyId="", dairyName = "", milkType = "", driverName = "", liter = "", fat = "", lactose = "", shift = "", remark = "", tankerNumber = "", dairyid = "", type = "", SNF = "", protein = "", totalMilk = "";
         double fatDiff = 0, snfDiff = 0, incrementPerFat = 0, incrementPerSNF = 0, decrementPerFat = 0, decreamentPerSNF = 0, enterProtein=0;
          double fatAmount = 0, snfAmount = 0, enterFat = 0, enterSNF = 0, basicFat = 0, basicSNF = 0, bRate = 0, totalamount = 0, decrementAmount = 0,enterLactose=0;
         String rategeneratorid = "";
        DecimalFormat form = new DecimalFormat("#.##");
        ResultSet rs = null;
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
             dairyId= StringUtils.isNotEmpty(params.get("dairyid")) ? params.get("dairyid") : "";
            dairyName = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
            milkType = StringUtils.isNotEmpty(params.get("milktype")) ? params.get("milktype") : "";
            driverName = StringUtils.isNotEmpty(params.get("drivername")) ? params.get("drivername") : "";
            tankerNumber = StringUtils.isNotEmpty(params.get("tankerno")) ? params.get("tankerno") : "";
            totalMilk = StringUtils.isNotEmpty(params.get("liter")) ? params.get("liter") : "";
            fat = StringUtils.isNotEmpty(params.get("fat")) ? params.get("fat") : "";
            lactose = StringUtils.isNotEmpty(params.get("lactose")) ? params.get("lactose") : "";
            SNF = StringUtils.isNotEmpty(params.get("snf")) ? params.get("snf") : "";
//            protein = StringUtils.isNotEmpty(params.get("protein")) ? params.get("protein") : "";
            if (StringUtils.isNotEmpty(params.get("protein"))) {
                enterProtein = Double.parseDouble(params.get("protein"));
            }
            shift = StringUtils.isNotEmpty(params.get("shift")) ? params.get("shift") : "";
            remark = StringUtils.isNotEmpty(params.get("remark")) ? params.get("remark") : "";
            
             PreparedStatement pst1 = null;
            Statement st = conn.createStatement();
            pst1 = conn.prepareStatement("select count(*) from sellentry where date = ? and dairyid = ? and tankerno=?");
            pst1.setString(1, date);
            pst1.setString(2, dairyId);
            pst1.setString(3, tankerNumber);
             rs = pst1.executeQuery();
            rs.next();

            int isbuffelo = 0, iscow = 0;
            switch (milkType) {
                case "COW":
                    iscow = 1;
                    break;
                case "BUFFALO":
                    isbuffelo = 1;
                    break;
            }
            conn = DBPool.getConnection();

            PreparedStatement pst = null;
             st = conn.createStatement();
            ResultSet rs1 = st.executeQuery("select rategeneratorid,brate,bfat,bsnf,dperfat,aperfat,dpersnf,apersnf from rategenerator where activeflag=1 and iscow=" + iscow + " and isbuffalo=" + isbuffelo +" and sell= 1");

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
//                enterProtein = Double.parseDouble(protein);
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
            double totalMilk1 = Double.parseDouble(totalMilk);
            totalamount = totalMilk1 * rate;

            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into sellentry(sellid,dairyid,drivername,tankerno,fat,lacto,snf,totalmilk,protein,remark,date,shift,dairyname,rategeneratorid,totalamount,type,rate) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, UUID.randomUUID().toString());
                pst.setString(2, dairyId);
                pst.setString(3, driverName);
                pst.setString(4, tankerNumber);
                pst.setDouble(5,enterFat);
                pst.setDouble(6, enterLactose);
                pst.setDouble(7,enterSNF);
                pst.setDouble(8, totalMilk1);
                pst.setDouble(9, enterProtein);
//                pst.setString(9, temprature);
                pst.setString(10, remark);
                pst.setString(11, date);
                pst.setString(12, shift);
                pst.setString(13, dairyName);
                pst.setString(14, rategeneratorid);
                pst.setDouble(15, totalamount);
                pst.setString(16, milkType);
                pst.setDouble(17, rate);
                int r = pst.executeUpdate();
                if (r > 0) {
                    resultJSONObject.put("message", "Record Added Successfully.");
                    resultJSONObject.put("success", true);
                } else {
                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                    resultJSONObject.put("success", false);
                }
            } else {
                resultJSONObject.put("message", "Tanker Number  is already used. Please try another.");
                resultJSONObject.put("success", "false");
            }
        } catch (Exception e) {

            resultJSONObject.put("success", "false");
            e.printStackTrace();
        }
        return resultJSONObject;
    }

    public JSONObject getDairyNameList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            rs = st.executeQuery("select dairyid,dairyname,type,code from dairyregistration ");

            if (null != rs) {

                while (rs.next()) {

                    JSONObject jobj = new JSONObject();

                    jobj.put("dairyid", rs.getString(1));

                    jobj.put("dairyname", null != rs.getString(2) ? rs.getString(2) : "");
                    jobj.put("type", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("code", null != rs.getString(4) ? rs.getString(4) : "");

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
    public JSONObject foodSell(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;
        String milkmanid = "";
        JSONObject resultJSONObject = new JSONObject();
        String code = "", date = "", customerName = "", sellRate = "", quantity = "", subTotal = "", discount = "", totalAmount = "", currentBill = "", foodName = "";
        long id = 0;
        try {
            Connection conn = DBPool.getConnection();

            code = StringUtils.isNotEmpty(params.get("customid")) ? params.get("customid") : "";
            date = StringUtils.isNotEmpty(params.get("date")) ? params.get("date") : "";
            customerName = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            foodName = StringUtils.isNotEmpty(params.get("foodname")) ? params.get("foodname") : "";
            sellRate = StringUtils.isNotEmpty(params.get("sellrate")) ? params.get("sellrate") : "";
            quantity = StringUtils.isNotEmpty(params.get("quantity")) ? params.get("quantity") : "";
            subTotal = StringUtils.isNotEmpty(params.get("subtotal")) ? params.get("subtotal") : "";
            discount = StringUtils.isNotEmpty(params.get("discount")) ? params.get("discount") : "";
            totalAmount = StringUtils.isNotEmpty(params.get("totalamount")) ? params.get("totalamount") : "";
            currentBill = StringUtils.isNotEmpty(params.get("currentbill")) ? params.get("currentbill") : "";
             

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
            pst = conn.prepareStatement("select count(*) from foodsell where code = ?");
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into foodsell(customername,foodname,sellrate,date,quantity,subtotal,discount,totalamount,bill,code) values(?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, customerName);
                pst.setString(2, foodName);
                pst.setString(3, sellRate);
                pst.setString(4, date);
                pst.setString(5, quantity);
                pst.setString(6, subTotal);
                pst.setString(7, discount);
                pst.setString(8, totalAmount);
                pst.setString(9, currentBill);
                pst.setString(10, code);

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
    public JSONObject getCategoryList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            rs = st.executeQuery("select purchaseid,foodname from purchasefood order by foodname");

            if (null != rs) {

                while (rs.next()) {

                    JSONObject jobj = new JSONObject();

                    jobj.put("purchaseid", rs.getLong(1));

                    jobj.put("foodname", null != rs.getString(2) ? rs.getString(2) : "");

                    jarr.put(jobj);
                }
            }

            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (JSONException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (SQLException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }

        return returnJSONObject;
    }

    @Override
    public JSONObject getSellEntryList(String selectedDate) throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();


            String query = "";
            if(selectedDate.equals("")){
                query = "Select s.sellid,s.drivername,s.tankerno,s.totalmilk,s.date,s.type d.code s.dairyid from sellentry s,dairyregistration d where s.dairyid = d.dairyid";
            } else{
                query = "Select s.sellid,s.drivername,s.tankerno,s.totalmilk,s.date,s.type,d.code,s.dairyid from sellentry s,dairyregistration d where s.dairyid = d.dairyid and date='"+ selectedDate +"'";
            }

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("sellid", rs.getString(1));                    
                    jobj.put("drivername", null != rs.getString(2) ? rs.getString(2) : "");
                    jobj.put("tankerno", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("totalmilk", null != rs.getString(4) ? rs.getString(4) : "");
                    jobj.put("date", null != rs.getString(5) ? rs.getString(5) : "");
                    jobj.put("type", null != rs.getString(6) ? rs.getString(6) : "");
                    jobj.put("code", null != rs.getString(7) ? rs.getString(7) : "");
                    jobj.put("dairyid",rs.getString(8));
                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (SQLException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (JSONException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }
        return returnJSONObject;
    }
    @Override
    public JSONObject getMilkTypeListJson(String categoryid) throws Exception {

        JSONObject returnJSONObject = new JSONObject();
        JSONArray jarr = new JSONArray();
        ResultSet rs = null;
        try {

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
             String categoryId = com.mysql.jdbc.StringUtils.isNullOrEmpty(categoryid) ? "" : categoryid;

//            long categoryId = Long.parseLong(id);

            String query = "Select type from dairyregistration where dairyid= '"+ categoryId +"'";

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
    public JSONObject getDairyMilkBillDetailsList(String startDate, String selectedDate, String dairyId) throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();


            String query = "";
            if(selectedDate.equals("")){
                query = "Select s.sellid,s.drivername,s.tankerno,s.totalmilk,s.date,s.type d.code s.dairyid from sellentry s,dairyregistration d where s.dairyid = d.dairyid";
            } else{
                query = "Select s.sellid,s.fat,s.snf,s.lacto,s.rate,s.totalamount, s.drivername,s.tankerno,s.totalmilk,s.date,s.type,d.code,s.dairyid,d.dairyname from sellentry s,dairyregistration d where s.date BETWEEN '" + startDate + "' AND '" + selectedDate + "' and s.dairyid='" + dairyId + "' and s.dairyid = d.dairyid";
            }

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("sellid", rs.getString(1)); 
                    jobj.put("fat", rs.getDouble(2));
                    jobj.put("snf", rs.getDouble(3));
                    jobj.put("lacto", rs.getDouble(4));
                    jobj.put("rate", rs.getDouble(5));
                    jobj.put("totalamount", rs.getDouble(6));
                    jobj.put("drivername", null != rs.getString(7) ? rs.getString(7) : "");
                    jobj.put("tankerno", null != rs.getString(8) ? rs.getString(8) : "");
                    jobj.put("totalmilk",rs.getDouble(9));
                    jobj.put("date", null != rs.getString(10) ? rs.getString(10) : "");
                    jobj.put("type", null != rs.getString(11) ? rs.getString(11) : "");
                    jobj.put("code", null != rs.getString(12) ? rs.getString(12) : "");
                    jobj.put("dairyid",rs.getString(13));
                    jobj.put("dairyname", null != rs.getString(13) ? rs.getString(13) : "");
                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (SQLException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (JSONException e) {
            Logger.getLogger(SellDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }
        return returnJSONObject;
    }
    
     @Override
    public JSONObject getNewDate(String dairyid) throws Exception {

        JSONObject returnJSONObject = new JSONObject();
        JSONArray jarr = new JSONArray();
        ResultSet rs = null;
        try {

            conn = DBPool.getConnection();
            Statement st = conn.createStatement();
            long startdate = 0;
            String dairyID = com.mysql.jdbc.StringUtils.isNullOrEmpty(dairyid) ? "" : dairyid;
            String query = "Select max(billgenerateddate) from milkdairybilldetails where dairyid='" + dairyID + "'";

            rs = st.executeQuery(query);

            if (null != rs) {

                if (rs.next()) {
                    startdate = rs.getLong(1);
                    if(startdate == 0){ //no any record found (in case of first bill)
                        query = "Select registrationdate from dairyregistration where dairyid='" + dairyID + "'";
                        rs = st.executeQuery(query);
                        if (null != rs) {
                            if(rs.next()){
                                startdate = rs.getLong(1);
                            }
                        }
                    }
                }

                Date date = new Date(startdate);
                SimpleDateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
                String dateText = df2.format(date);

                Calendar c = Calendar.getInstance();
                c.setTime(df2.parse(dateText));
                c.add(Calendar.DATE, 1);
                dateText = df2.format(c.getTime());

                jarr.put(dateText);
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



}

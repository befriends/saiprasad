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
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class SellDaoImpl implements SellDao {

    Connection conn = null;

    @Override
    public JSONObject addDairySell(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;
        String milkmanid = "";
        JSONObject resultJSONObject = new JSONObject();
        String code = "", dairyName = "", personName = "", alternateName = "", Address = "", mobile = "", alternateNumber = "", accountNumber = "", branchName = "", tankerNumber = "", amount = "", type = "";
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
            code = StringUtils.isNotEmpty(params.get("code")) ? params.get("code") : "";
            dairyName = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
            personName = StringUtils.isNotEmpty(params.get("personname")) ? params.get("personname") : "";
            alternateName = StringUtils.isNotEmpty(params.get("altername")) ? params.get("altername") : "";
            Address = StringUtils.isNotEmpty(params.get("address")) ? params.get("address") : "";
            mobile = StringUtils.isNotEmpty(params.get("mobile")) ? params.get("mobile") : "";
            alternateNumber = StringUtils.isNotEmpty(params.get("alternumber")) ? params.get("alternumber") : "";
            accountNumber = StringUtils.isNotEmpty(params.get("account")) ? params.get("account") : "";
            branchName = StringUtils.isNotEmpty(params.get("accountbranch")) ? params.get("accountbranch") : "";
            tankerNumber = StringUtils.isNotEmpty(params.get("tankernumber")) ? params.get("tankernumber") : "";
            amount = StringUtils.isNotEmpty(params.get("amount")) ? params.get("amount") : "";
            type = StringUtils.isNotBlank(params.get("type")) ? params.get("type") : "";

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
            pst = conn.prepareStatement("select count(*) from dairysell where dairyid = ?");
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into dairysell(code,dairyname,personname,alternatename,mobile,alternatemobile,accountno,branchname,tankerno,amount,type) values(?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, code);
                pst.setString(2, dairyName);
                pst.setString(3, personName);
                pst.setString(4, alternateNumber);
                pst.setString(5, mobile);
                pst.setString(6, alternateNumber);
                pst.setString(7, accountNumber);
                pst.setString(8, branchName);
                pst.setString(9, tankerNumber);
                pst.setString(10, amount);
                pst.setString(11, type);

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
    public JSONObject addDailySell(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;

        JSONObject resultJSONObject = new JSONObject();
        String date = "", code = "", dairyName = "", milkType = "", driverName = "", liter = "", fat = "", lactose = "", shift = "", remark = "", tankerNumber = "", dairyid = "", type = "", SNF = "", protein = "", totalMilk = "";
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
            code = StringUtils.isNotEmpty(params.get("customid")) ? params.get("customid") : "";
            dairyName = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
            milkType = StringUtils.isNotEmpty(params.get("milktype")) ? params.get("milktype") : "";
            driverName = StringUtils.isNotEmpty(params.get("drivername")) ? params.get("drivername") : "";
            tankerNumber = StringUtils.isNotEmpty(params.get("tankerno")) ? params.get("tankerno") : "";
            totalMilk = StringUtils.isNotEmpty(params.get("liter")) ? params.get("liter") : "";
            fat = StringUtils.isNotEmpty(params.get("fat")) ? params.get("fat") : "";
            lactose = StringUtils.isNotEmpty(params.get("lactose")) ? params.get("lactose") : "";
            SNF = StringUtils.isNotEmpty(params.get("snf")) ? params.get("snf") : "";
            protein = StringUtils.isNotEmpty(params.get("protein")) ? params.get("protein") : "";
//            totalMilk=StringUtils.isNotBlank(params.get("totalmilk"))? params.get("totalmilk") : "";
            shift = StringUtils.isNotEmpty(params.get("shift")) ? params.get("shift") : "";
            remark = StringUtils.isNotEmpty(params.get("remark")) ? params.get("remark") : "";

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
            pst = conn.prepareStatement("select count(*) from sellentry where code = ?");
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into sellentry(code,drivername,tankerno,fat,lacto,snf,totalmilk,protein,remark,date,shift,dairyname,type) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, code);
                pst.setString(2, driverName);
                pst.setString(3, tankerNumber);
                pst.setString(4, fat);
                pst.setString(5, lactose);
                pst.setString(6, SNF);
                pst.setString(7, totalMilk);
                pst.setString(8, protein);
//                pst.setString(9, temprature);
                pst.setString(9, remark);
                pst.setString(10, date);
                pst.setString(11, shift);
                pst.setString(12, dairyName);
                pst.setString(13, milkType);
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

    public JSONObject getDairyNameList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

            rs = st.executeQuery("select dairyid,dairyname from dairysell ");

            if (null != rs) {

                while (rs.next()) {

                    JSONObject jobj = new JSONObject();

                    jobj.put("dairyid", rs.getLong(1));

                    jobj.put("dairyname", null != rs.getString(2) ? rs.getString(2) : "");

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
//            tankerNumber=StringUtils.isNotEmpty(params.get("tankernumber"))? params.get("tankernumber") : "";
//            amount=StringUtils.isNotEmpty(params.get("amount"))? params.get("amount") : "";
//            type=StringUtils.isNotBlank(params.get("type"))? params.get("type") : "";
//             

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
//                pst.setString(11, type);

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
    public JSONObject getSubCategoryList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

//            String query = "Select sc.subcategoryid,sc.categoryid,sc.subcategoryname,sc.customid,c.categoryname from subcategory sc,category c where sc.categoryid=c.categoryid and sc.isdeleted=0 order by c.categoryname";
            String query = "Select sellid,drivername,tankerno,totalmilk,date,type from sellentry";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("sellid", rs.getLong(1));
                    // jobj.put("categoryid", rs.getLong(2));
                    jobj.put("drivername", null != rs.getString(2) ? rs.getString(2) : "");
                    jobj.put("tankerno", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("totalmilk", null != rs.getString(4) ? rs.getString(4) : "");
                    jobj.put("date", null != rs.getString(5) ? rs.getString(5) : "");
                    jobj.put("type", null != rs.getString(6) ? rs.getString(6) : "");

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

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.MilkSupplierDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
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
public class MilkSupplierDaoImpl implements MilkSupplierDao {

    Connection conn = null;

    @Override
    public String addMilkSupplier(HashMap<String, String> params) {
        JSONObject jobj = null;
        String code = "", fname = "", lname = "", accountno = "", accountbank = "", address = "", fullname = "", dairyname = "", type = "";
        long mobile = 0;
        try {
            code = StringUtils.isNotEmpty(params.get("code")) ? params.get("code") : "";
            fname = StringUtils.isNotEmpty(params.get("fname")) ? params.get("fname") : "";
            lname = StringUtils.isNotEmpty(params.get("lname")) ? params.get("lname") : "";
            if (StringUtils.isNotEmpty(params.get("mobile"))) {
                mobile = Long.parseLong(params.get("mobile"));
            }
            accountno = StringUtils.isNotEmpty(params.get("accountno")) ? params.get("accountno") : "";
            accountbank = StringUtils.isNotEmpty(params.get("accountbank")) ? params.get("accountbank") : "";
            address = StringUtils.isNotEmpty(params.get("address")) ? params.get("address") : "";
            dairyname = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
            type = StringUtils.isNotEmpty(params.get("type")) ? params.get("type") : "";

            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            Date date = new Date();
            String adDate = (dateFormat.format(date));

            String year = adDate.substring(adDate.lastIndexOf("/") + 1);
            String month = adDate.substring(adDate.indexOf("/") + 1, adDate.lastIndexOf("/"));
            String day = adDate.substring(0, adDate.indexOf("/"));

            long DateInLong = new Date(year + "/" + month + "/" + day).getTime();

            fullname = fname + " " + lname;
            conn = DBPool.getConnection();

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
//            pst = conn.prepareStatement("select count(*)  milkmandetails where code = ?");
            pst = conn.prepareStatement("select count(*) from milkmandetails where fullname = ?");
            pst.setString(1, fullname);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {
                pst = conn.prepareStatement("insert into milkmandetails(milkmanid, code, fullname,dairyname,mobile,accnumber,accbranch,addr,type,registrationdate) values(?,?,?,?,?,?,?,?,?,?)");
                String milkmanid = UUID.randomUUID().toString();
                pst.setString(1, milkmanid);
                pst.setString(2, code);
                pst.setString(3, fullname);
                pst.setString(4, dairyname);
                pst.setLong(5, mobile);
                pst.setString(6, accountno);
                pst.setString(7, accountbank);
                pst.setString(8, address);
                pst.setString(9, type);
                pst.setLong(10, DateInLong);

                int r = pst.executeUpdate();
//                PreparedStatement pst1 = null;
//                pst1 = conn.prepareStatement("insert into milkmanbilldetails(idmilkmanbillmapping,billgenerateddate,milkmanid,startdate,enddate) values(?,?,?,?,?)");
//                pst1.setString(1, UUID.randomUUID().toString());
//                pst1.setLong(2, DateInLong);
//                pst1.setString(3, milkmanid);
//                pst1.executeUpdate();
                if (r > 0) {
                    jobj = new JSONObject();
                    jobj.put("message", "Milkman Added Successfully.");
                    jobj.put("success", true);
                } else {
                    jobj = new JSONObject();
                    jobj.put("message", "Some error Occurred... Pease try again.");
                    jobj.put("success", false);
                }
            } else {
                jobj = new JSONObject();
                jobj.put("message", "Code is already in use. Please try another.");
                jobj.put("success", false);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobj.toString();
    }

    @Override
    public JSONObject getmilkMandetailsList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();

//            String query = "Select sc.subcategoryid,sc.categoryid,sc.subcategoryname,sc.customid,c.categoryname from subcategory sc,category c where sc.categoryid=c.categoryid and sc.isdeleted=0 order by c.categoryname";
            String query = "Select milkmanid,fullname,code,mobile,type from milkmandetails order by code";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("milkmanid", rs.getString(1));                   
                    jobj.put("fullname", null != rs.getString(2) ? rs.getString(2) : "");
                    jobj.put("code", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("mobile", rs.getLong(4));    
                    jobj.put("type", null != rs.getString(5) ? rs.getString(5) : "");

                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (SQLException e) {
            Logger.getLogger(MilkSupplierDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (JSONException e) {
            Logger.getLogger(MilkSupplierDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }
        return returnJSONObject;
    }

    @Override
    public JSONObject addDairyRegistration(HashMap<String, String> params) throws JSONException, IOException {
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
            pst = conn.prepareStatement("select count(*) from dairyregistration where dairyid = ?");
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            rs.next();
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            Date date = new Date();
            String adDate = (dateFormat.format(date));

            String year = adDate.substring(adDate.lastIndexOf("/") + 1);
            String month = adDate.substring(adDate.indexOf("/") + 1, adDate.lastIndexOf("/"));
            String day = adDate.substring(0, adDate.indexOf("/"));

            long DateInLong = new Date(year + "/" + month + "/" + day).getTime();


            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into dairyregistration(dairyid,code,dairyname,personname,alternatename,mobile,alternatemobile,accountno,branchname,tankerno,amount,type,registrationdate) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, UUID.randomUUID().toString());
                pst.setString(2, code);
                pst.setString(3, dairyName);
                pst.setString(4, personName);
                pst.setString(5, alternateNumber);
                pst.setString(6, mobile);
                pst.setString(7, alternateNumber);
                pst.setString(8, accountNumber);
                pst.setString(9, branchName);
                pst.setString(10, tankerNumber);
                pst.setString(11, amount);
                pst.setString(12, type);
                pst.setLong(13, DateInLong);
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
    public JSONObject getDairyMilkList() throws JSONException, IOException {

        ResultSet rs = null;

        JSONObject returnJSONObject = new JSONObject();

        JSONArray jarr = new JSONArray();

        try {

            returnJSONObject.put("success", "false");

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();


            String query = "Select dairyid,code,type,dairyname,mobile,amount from dairyregistration order by code";

            rs = st.executeQuery(query);

            if (null != rs) {

                while (rs.next()) {
                    JSONObject jobj = new JSONObject();
                    jobj.put("dairyid", rs.getString(1));                   
                    jobj.put("code", null != rs.getString(2) ? rs.getString(2) : "");
                    jobj.put("type", null != rs.getString(3) ? rs.getString(3) : "");
                    jobj.put("dairyname", null != rs.getString(4) ? rs.getString(4) : "");
                    jobj.put("mobile", rs.getLong(5));
                    jobj.put("amount", rs.getDouble(6));

                    jarr.put(jobj);
                }
            }
            returnJSONObject.put("data", jarr);

            returnJSONObject.put("success", "true");

        } catch (SQLException e) {
            Logger.getLogger(MilkSupplierDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        } catch (JSONException e) {
            Logger.getLogger(MilkSupplierDaoImpl.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            returnJSONObject.put("success", "false");
            returnJSONObject.put("message", e.getMessage());
        }
        return returnJSONObject;
    }
    
    @Override
    public JSONObject addAdvancePayment(HashMap<String, String> params) throws JSONException, IOException, SQLException {
        boolean result = false;
        String milkmanid = "";
        JSONObject resultJSONObject = new JSONObject();
        String addDate = "", personName = "", amount = "", reason = "", contactPersonName = "";
        long id = 0;
        try {
            Connection conn = DBPool.getConnection();
            conn.setAutoCommit(false);

            addDate = StringUtils.isNotEmpty(params.get("datepicker")) ? params.get("datepicker") : "";
            personName = StringUtils.isNotEmpty(params.get("personname")) ? params.get("personname") : "";
            amount = StringUtils.isNotEmpty(params.get("amount")) ? params.get("amount") : "";
            reason = StringUtils.isNotEmpty(params.get("reason")) ? params.get("reason") : "";
            contactPersonName = StringUtils.isNotEmpty(params.get("contactpersonname")) ? params.get("contactpersonname") : "";
           
            PreparedStatement pst = null;
//            Statement st = conn.createStatement();
//            pst = conn.prepareStatement("select count(*) from dairyregistration where dairyid = ?");
//            pst.setString(1, code);
//            ResultSet rs = pst.executeQuery();
//            rs.next();
//
//            if (rs.getInt(1) == 0) {

                pst = conn.prepareStatement("insert into advancepayment(idadvancepayment,adddate,name,amount,reason,contactperson) values(?,?,?,?,?,?)");
                pst.setString(1, UUID.randomUUID().toString());
                pst.setString(2, addDate);
                pst.setString(3, personName);
                pst.setDouble(4, Double.parseDouble(amount));
                pst.setString(5, reason);
                pst.setString(6, contactPersonName);
                int r = pst.executeUpdate();
                if (r > 0) {
                    resultJSONObject.put("message", "Record Added Successfully.");
                    resultJSONObject.put("success", true);
                } else {
                    conn.rollback();
                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                    resultJSONObject.put("success", false);
                }
//            } else {
//                resultJSONObject.put("success", "false");
//            }
        } catch (Exception e) {
            conn.rollback();
            resultJSONObject.put("success", "false");
            e.printStackTrace();
        } finally{
            conn.close();
        }
        return resultJSONObject;
    }

}

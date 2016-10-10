/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.ReportDao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class ReportDaoImpl implements ReportDao {

    Connection conn = null;

    @Override
    public String dateSales(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        JSONArray jarr = new JSONArray();
        String selectedDate = "";
        try {
            selectedDate = StringUtils.isNotEmpty(params.get("datepicker")) ? params.get("datepicker") : "";

            conn = DBPool.getConnection();

            // PreparedStatement pst = null;
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("Select s.sellid,s.fat,s.snf,s.lacto,s.drivername,s.tankerno,s.totalmilk,s.date,s.type,s.totalamount,s.rate,s.dairyid,d.code from sellentry s , dairyregistration d where s.dairyid = d.dairyid and s.date='" + selectedDate + "'");
//            Select p.purchaseid,p.fat,p.lacto,p.rate,p.totalmilk,p.totalamount,p.date,p.type,p.milkmanid,m.code from daillycollection p,milkmandetails m where p.milkmanid=m.milkmanid and p.date='" + selectedDate + "'"

            while (rs.next()) {
                jobj = new JSONObject();
                jobj.put("sellid", rs.getString(1));
                jobj.put("fat",rs.getDouble(2));
                jobj.put("snf",rs.getDouble(3));
                jobj.put("lacto",rs.getDouble(4));
                jobj.put("drivername", rs.getString(5));
                jobj.put("tankerno", rs.getString(6));
                jobj.put("totalmilk", rs.getDouble(7));
                jobj.put("date", rs.getString(8));
                jobj.put("type", rs.getString(9));
                jobj.put("totalamount", rs.getDouble(10));
                 jobj.put("rate", rs.getDouble(11));
                 jobj.put("dairyid", rs.getString(12));
                 jobj.put("code", rs.getString(13));

                jarr.put(jobj);
            }
            respoJSONObject.put("date", selectedDate);
            respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }
     @Override
    public String MonthlySales(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        JSONArray jarr = new JSONArray();
        String month = "", year = "", fromDateInString = "", toDateInString;
        try {

            month = StringUtils.isNotEmpty(params.get("month")) ? params.get("month") : "";
            year = StringUtils.isNotEmpty(params.get("year")) ? params.get("year") : "";
            String firstday = "01";
            String lastday = "31";
            fromDateInString = firstday + "/" + month + "/" + year;
            toDateInString = lastday + "/" + month + "/" + year;
            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("select distinct date ,sum(totalamount) as 'totalamount'from sellentry where date BETWEEN '" + fromDateInString + "'  AND  '" + toDateInString + "'  group by date order by date asc");

            while (rs.next()) {
                jobj = new JSONObject();
                jobj.put("date", rs.getString(1));
                jobj.put("totalamount", rs.getDouble(2));
                jarr.put(jobj);
            }

            respoJSONObject.put("month", month);
            respoJSONObject.put("year", year);
            respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }


    @Override
    public String purchaseDate(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        JSONArray jarr = new JSONArray();
        String selectedDate = "";
        try {

            selectedDate = StringUtils.isNotEmpty(params.get("datepicker")) ? params.get("datepicker") : "";

            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("Select p.purchaseid,p.fat,p.lacto,p.rate,p.totalmilk,p.totalamount,p.date,p.type,p.milkmanid,m.code from daillycollection p,milkmandetails m where p.milkmanid=m.milkmanid and p.date='" + selectedDate + "'");

            while (rs.next()) {
                jobj = new JSONObject();

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
                jarr.put(jobj);
            }

            respoJSONObject.put("date", selectedDate);
//            respoJSONObject.put("year", year);
            respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }

    @Override
    public String purchaseMonth(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        JSONArray jarr = new JSONArray();
        String month = "", year = "", fromDateInString = "", toDateInString;
        try {

            month = StringUtils.isNotEmpty(params.get("month")) ? params.get("month") : "";
            year = StringUtils.isNotEmpty(params.get("year")) ? params.get("year") : "";
            String firstday = "01";
            String lastday = "31";
            fromDateInString = firstday + "/" + month + "/" + year;
            toDateInString = lastday + "/" + month + "/" + year;
            conn = DBPool.getConnection();

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("select distinct date ,sum(totalamount) as 'totalamount'from daillycollection where date BETWEEN '" + fromDateInString + "'  AND  '" + toDateInString + "'  group by date order by date asc");

            while (rs.next()) {
                jobj = new JSONObject();
                jobj.put("date", rs.getString(1));
                jobj.put("totalamount", rs.getDouble(2));
                jarr.put(jobj);
            }

            respoJSONObject.put("month", month);
            respoJSONObject.put("year", year);
            respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }

    @Override
    public String purchaseCustomerName(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        JSONArray jarr = new JSONArray();
        String  customerName = "";
        try {

            customerName = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            conn = DBPool.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("Select dc.milkmanid ,dc.fat,dc.lacto,dc.snf,dc.date,dc.shift,dc.totalmilk,dc.rate,dc.totalamount,dc.type,md.fullname from daillycollection dc,milkmandetails md where dc.milkmanid = '"+ customerName + "'and dc.milkmanid=md.milkmanid");
//            "Select dc.totalmilk,dc.rate,dc.totalamount,dc.type,md.fullname dc.milkmanid from daillycollection dc,milkmandetails md where dc.milkmanid=md.milkmanid and fullname = '"+ customerName +"'";
            while (rs.next()) {
                jobj = new JSONObject();
                 jobj.put("milkmanid", rs.getString(1));
                jobj.put("fat", rs.getDouble(2));
                jobj.put("lacto", rs.getDouble(3));
                jobj.put("snf", rs.getDouble(4));
                jobj.put("date", rs.getString(5));
                jobj.put("shift", rs.getString(6));
                jobj.put("totalmilk", rs.getDouble(7));
                jobj.put("rate", rs.getDouble(8));
                jobj.put("totalamount", rs.getDouble(9));
                jobj.put("type", rs.getString(10));
                jobj.put("fullname", rs.getString(11));
                
                
                jarr.put(jobj);
            }

            respoJSONObject.put("customername", customerName);
            respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }

}

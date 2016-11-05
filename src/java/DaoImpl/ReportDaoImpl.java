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
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("Select s.sellid,s.fat,s.snf,s.lacto,s.drivername,s.tankerno,s.totalmilk,s.date,s.type,s.totalamount,s.rate,s.dairyid,d.code from sellentry s , dairyregistration d where s.dairyid = d.dairyid and s.date='" + selectedDate + "'");
            while (rs.next()) {
                jobj = new JSONObject();
                jobj.put("sellid", rs.getString(1));
                jobj.put("fat", rs.getDouble(2));
                jobj.put("snf", rs.getDouble(3));
                jobj.put("lacto", rs.getDouble(4));
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
            ResultSet rs = st.executeQuery("select distinct date ,sum(totalamount) as 'totalamount'from sellentry where 'date' BETWEEN '" + fromDateInString + "'  AND  '" + toDateInString + "' order by date asc");

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
        String customerName = "";
        try {

            customerName = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            conn = DBPool.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("Select dc.milkmanid ,dc.fat,dc.lacto,dc.snf,dc.date,dc.shift,dc.totalmilk,dc.rate,dc.totalamount,dc.type,md.fullname from daillycollection dc,milkmandetails md where dc.milkmanid = '" + customerName + "'and dc.milkmanid=md.milkmanid");
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

    @Override
    public String CustomerNameAndDateWiseList(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        Statement st = null;
        JSONArray jarr = new JSONArray();
        String customerName = "", startDate = "", endDate = "", milkmanid = "";
        long startdate = 0, enddate = 0;
        try {

            customerName = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            startDate = StringUtils.isNotEmpty(params.get("startdate")) ? params.get("startdate") : "";
            endDate = StringUtils.isNotEmpty(params.get("enddate")) ? params.get("enddate") : "";
            conn = DBPool.getConnection();
            st = conn.createStatement();
            ResultSet rs1 = st.executeQuery("select milkmanid,startdate,enddate from milkmanbilldetails where milkmanid = '" + customerName + "'");

            while (rs1.next()) {
                milkmanid = rs1.getString(1);
                startdate = rs1.getLong(2);
                enddate = rs1.getLong(3);

            }
//             long val = 1346524199000l;
            Date date = new Date(startdate);
            SimpleDateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
            String StringStartDate = df2.format(date);

            Date date1 = new Date(enddate);
            SimpleDateFormat df1 = new SimpleDateFormat("dd/MM/yyyy");
            String StringEndDate = df1.format(date1);

            if ((startDate.equals(StringStartDate)) && (endDate.equals(StringEndDate))) {
                ResultSet rs = st.executeQuery("Select d.purchaseid,d.fat,d.snf,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code,m.fullname,d.shift,md.deduction,md.totalcommission,md.totalamnt,md.remark from daillycollection d,milkmandetails m,milkmanbilldetails md where d.date BETWEEN '" + startDate + "' AND '" + endDate + "' and d.milkmanid='" + customerName + "' and billgenerationflag=1 and d.milkmanid=m.milkmanid and d.milkmanid=md.milkmanid");
                while (rs.next()) {
                    jobj = new JSONObject();
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
                    jobj.put("fullname", null != rs.getString(12) ? rs.getString(12) : "");
                    jobj.put("shift", null != rs.getString(13) ? rs.getString(13) : "");
                    jobj.put("deduction", rs.getDouble(14));
                    jobj.put("totalcommission", rs.getDouble(15));
                    jobj.put("totalamnt", rs.getDouble(16));
                    jobj.put("remark", rs.getString(17));
                    
                    jarr.put(jobj);
                }

                respoJSONObject.put("customername", customerName);
                respoJSONObject.put("data", jarr);
                respoJSONObject.put("success", true);
            } else {
                respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);

            }
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }
    @Override
    public String DairyNameAndDateWiseList(HashMap<String, String> params) throws JSONException
    {
        JSONArray jarr =new JSONArray();
        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        Statement st = null;
//         ResultSet rs = null;
        String dairyName = "",startDate ="",endDate ="";
        long startdate = 0,enddate = 0;
        
        try {
            
            dairyName = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname") : "";
            startDate = StringUtils.isNotEmpty(params.get("startdate")) ? params.get("startdate") : "";
            endDate =StringUtils.isNotEmpty(params.get("enddate")) ? params.get("enddate") : "";
            
             conn = DBPool.getConnection();           
            st = conn.createStatement();
          ResultSet   rs1 =st.executeQuery("select dairyid,startdate,enddate from milkdairybilldetails where dairyid ='"+ dairyName +"'");
            while(rs1.next())                
            {
                String dairyID = rs1.getString(1);
                startdate = rs1.getLong(2);
                enddate = rs1.getLong(3);                                                
            }
            Date sdate = new Date(startdate);
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String stringStartDate = sdf.format(sdate);
            
            Date edate = new Date(enddate);
            SimpleDateFormat esdf =new SimpleDateFormat("dd/MM/yyyy");
            String StringEndDate = esdf.format(edate);
            if ((startDate.equals(stringStartDate)) && (endDate.equals(StringEndDate))) {
          ResultSet  rs = st.executeQuery("select s.sellid,s.fat,s.snf,s.lacto,s.rate,s.drivername,s.tankerno,s.totalmilk,s.date,s.type,s.dairyid, d.dairyname,db.deduction,db.totalcommission,db.totalamnt,db.remark,s.type,s.totalamount from sellentry s ,dairyregistration d,milkdairybilldetails db where s.date BETWEEN '"+ startDate +"' AND '"+ endDate +"' and s.dairyid ='"+dairyName+"' and billgenerationflag=1 and s.dairyid = d.dairyid and s.dairyid = db.dairyid ");
            while (rs.next()) {
                     jobj = new JSONObject();
                    jobj.put("sellid", rs.getString(1));                    
                     jobj.put("fat", rs.getDouble(2));
                    jobj.put("snf", rs.getDouble(3));
                    jobj.put("lacto", rs.getDouble(4));
                    jobj.put("rate", rs.getDouble(5));
                    jobj.put("drivername", null != rs.getString(6) ? rs.getString(6) : "");
                    jobj.put("tankerno", null != rs.getString(7) ? rs.getString(7) : "");
                    jobj.put("totalmilk", null != rs.getString(8) ? rs.getString(8) : "");
                    jobj.put("date", null != rs.getString(9) ? rs.getString(9) : "");
                    jobj.put("type", null != rs.getString(10) ? rs.getString(10) : "");
                    jobj.put("dairyname", null != rs.getString(11) ? rs.getString(11) : "");
                    jobj.put("dairyid",rs.getString(12));
                    jobj.put("deduction", rs.getDouble(13));
                    jobj.put("totalcommission", rs.getDouble(14));
                    jobj.put("totalamnt", rs.getDouble(15));
                    jobj.put("remark", rs.getString(16));
                    jobj.put("type", rs.getString(17));
                    jobj.put("totalamount", rs.getString(18));
                    jarr.put(jobj);
            }
               respoJSONObject.put("customername", dairyName);
                respoJSONObject.put("data", jarr);
                respoJSONObject.put("success", true);
            } else {
                respoJSONObject.put("data", jarr);
            respoJSONObject.put("success", true);

            }
            
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }
    @Override
    public String CustomerNameAndDateList(HashMap<String, String> params) throws JSONException {

        JSONObject respoJSONObject = new JSONObject();
        JSONObject jobj = null;
        Statement st = null;
        JSONArray jarr = new JSONArray();
        String customerName = "", startDate = "", endDate = "", milkmanid = "";
        long startdate = 0, enddate = 0;
        try {

            customerName = StringUtils.isNotEmpty(params.get("customername")) ? params.get("customername") : "";
            startDate = StringUtils.isNotEmpty(params.get("startdate")) ? params.get("startdate") : "";
            endDate = StringUtils.isNotEmpty(params.get("enddate")) ? params.get("enddate") : "";
            conn = DBPool.getConnection();
            st = conn.createStatement();
//            ResultSet rs1 = st.executeQuery("select milkmanid,startdate,enddate from milkmanbilldetails where milkmanid = '" + customerName + "'");
//
//            while (rs1.next()) {
//                milkmanid = rs1.getString(1);
//                startdate = rs1.getLong(2);
//                enddate = rs1.getLong(3);
//
//            }
////             long val = 1346524199000l;
//            Date date = new Date(startdate);
//            SimpleDateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
//            String StringStartDate = df2.format(date);
//
//            Date date1 = new Date(enddate);
//            SimpleDateFormat df1 = new SimpleDateFormat("dd/MM/yyyy");
//            String StringEndDate = df1.format(date1);
//
//            if ((startDate.equals(StringStartDate)) && (endDate.equals(StringEndDate))) {
                ResultSet rs = st.executeQuery("Select d.purchaseid,d.fat,d.snf,d.lacto,d.rate,d.totalmilk,d.totalamount,d.date,d.type,d.milkmanid,m.code,m.fullname,d.shift,md.deduction,md.totalcommission,md.totalamnt,md.remark from daillycollection d,milkmandetails m,milkmanbilldetails md where d.date BETWEEN '" + startDate + "' AND '" + endDate + "' and d.milkmanid='" + customerName + "' and billgenerationflag=1 and d.milkmanid=m.milkmanid and d.milkmanid=md.milkmanid");
                while (rs.next()) {
                    jobj = new JSONObject();
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
                    jobj.put("fullname", null != rs.getString(12) ? rs.getString(12) : "");
                    jobj.put("shift", null != rs.getString(13) ? rs.getString(13) : "");
                    jobj.put("deduction", rs.getDouble(14));
                    jobj.put("totalcommission", rs.getDouble(15));
                    jobj.put("totalamnt", rs.getDouble(16));
                    jobj.put("remark", rs.getString(17));
                    
                    jarr.put(jobj);
                }

                respoJSONObject.put("customername", customerName);
                respoJSONObject.put("data", jarr);
                respoJSONObject.put("success", true);
//            } else {
//                respoJSONObject.put("data", jarr);
//            respoJSONObject.put("success", true);
//
//            }
        } catch (Exception e) {
            respoJSONObject.put("data", "");
            respoJSONObject.put("success", false);
            e.printStackTrace();
        }
        return respoJSONObject.toString();
    }
 
}

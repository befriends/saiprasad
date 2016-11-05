/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import DBConnection.DBPool;
import Dao.RateGeneretorDao;
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
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class RateGeneretorDaoImpl implements RateGeneretorDao{
    
    Connection conn = null;
    
     @Override
    public JSONObject addRateGenerator(HashMap< String, String> params) throws JSONException, IOException, SQLException {
        JSONObject resultJSONObject = new JSONObject();
        String fromFat = "", toFat = "", fromSNF = "", toSNF = "", fromRate = "", toRate = "", dFat = "", dSNF = "";
        String aFat = "", aSNF = "",adDate="",milkType="",rateType="",appliedDate="", rate = "";
        boolean isPurchase = false, isSell = false;
        double toFat2=0,toSNF2=0,toRate2=0;
        DecimalFormat form = new DecimalFormat("#.##");
        try {
            conn = DBPool.getConnection();
            conn.setAutoCommit(false);
            
            milkType = !StringUtils.isNullOrEmpty(params.get("milktype")) ? params.get("milktype") : "";
            rateType = !StringUtils.isNullOrEmpty(params.get("ratetype")) ? params.get("ratetype") : "";
            appliedDate = !StringUtils.isNullOrEmpty(params.get("applieddate")) ? params.get("applieddate") : "";
            
            fromFat = !StringUtils.isNullOrEmpty(params.get("fromfat")) ? params.get("fromfat") : "";
            if( !StringUtils.isNullOrEmpty(params.get("tofat")))
            {
                toFat2=Double.parseDouble(params.get("tofat"));
            }

//            toFat = StringUtils.isNotEmpty(params.get("tofat")) ? params.get("tofat") : "";
            fromSNF = !StringUtils.isNullOrEmpty(params.get("fromsnf")) ? params.get("fromsnf") : "";
            if( !StringUtils.isNullOrEmpty(params.get("tosnf")))
            {
                toFat2=Double.parseDouble(params.get("tosnf"));
            }
//            toSNF = StringUtils.isNotEmpty(params.get("tosnf")) ? params.get("tosnf") : "";
            fromRate = !StringUtils.isNullOrEmpty(params.get("fromrate")) ? params.get("fromrate") : "";
             if( !StringUtils.isNullOrEmpty(params.get("torate")))
            {
                toFat2=Double.parseDouble(params.get("torate"));
            }
//            toRate = StringUtils.isNotEmpty(params.get("torate")) ? params.get("torate") : "";
            dFat = !StringUtils.isNullOrEmpty(params.get("dfat")) ? params.get("dfat") : "";
            dSNF = !StringUtils.isNullOrEmpty(params.get("dsnf")) ? params.get("dsnf") : "";
            rate = !StringUtils.isNullOrEmpty(params.get("rate")) ? params.get("rate") : "";
            aFat = !StringUtils.isNullOrEmpty(params.get("afat")) ? params.get("afat") : "";
            aSNF = !StringUtils.isNullOrEmpty(params.get("asnf")) ? params.get("asnf") : "";
            
        
          
             int isbuffelo = 0, iscow = 0;
            switch (milkType) {
                case "COW":
                    iscow = 1;
                    break;
                case "BUFFALO":
                    isbuffelo = 1;
                    break;
            }
            
             int purchase = 0, sell = 0;
            switch (rateType) {
                case "Purchase":
                    purchase = 1;
                    break;
                case "Sell":
                    sell = 1;
                    break;
            }

            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            Date date = new Date();
            adDate=(dateFormat.format(date));

            String sqlQuery = "", condition = "";
            if(iscow == 0 && isbuffelo == 1){
                condition = " where isbuffalo=1 and iscow=0";
            } else if(isbuffelo == 0 && iscow == 1){
                condition = " where isbuffalo=0 and iscow=1";
            }
            
            if(sell == 0 && purchase == 1){
                condition += " and sell=0 and purchase=1 and activeflag=1";
                isPurchase = true;
            } else if(sell == 1 && purchase == 0){
                condition += " and sell=1 and purchase=0 and activeflag=1";
                isSell = true;
            }
            
            Statement st = conn.createStatement();
            int isActiveFlagChanged = 0;
            
            if(!StringUtils.isNullOrEmpty(condition)){
                isActiveFlagChanged = st.executeUpdate("update rategenerator set activeflag=0" + condition);
            }
            
            PreparedStatement pst = null;
//            if (isActiveFlagChanged > 0 ) {
                pst = conn.prepareStatement("insert into rategenerator(rategeneratorid,bfat,addate,bsnf,brate,bfat2,bsnf2,brate2,dperfat,aperfat,dpersnf,apersnf,iscow,isbuffalo,applieddate,purchase,sell) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pst.setString(1, UUID.randomUUID().toString());
                pst.setDouble(2, Double.parseDouble(fromFat));
                pst.setString(3, adDate);
                pst.setDouble(4, Double.parseDouble(fromSNF));
                pst.setDouble(5, Double.parseDouble(fromRate));
                pst.setDouble(6, toFat2);
                pst.setDouble(7, toSNF2);
                pst.setDouble(8, toRate2);
                pst.setDouble(9, Double.parseDouble(dFat));
                pst.setDouble(10,Double.parseDouble(aFat));
                pst.setDouble(11,Double.parseDouble(dSNF));
                pst.setDouble(12,Double.parseDouble(aSNF));
                pst.setInt(13, iscow);
                pst.setInt(14, isbuffelo);
                pst.setString(15, appliedDate);
                pst.setInt(16, purchase);
                pst.setInt(17, sell);
                int r = pst.executeUpdate();
                if (r > 0) {
                    Statement selectRecords = conn.createStatement();
//                    Statement sellEntryRecords = conn.createStatement();
                    ResultSet rs = null;
                    if(isPurchase){
                        rs = selectRecords.executeQuery("select purchaseid, rategeneratorid, fat, lacto, snf, totalmilk, date from daillycollection where billgenerationflag=0 and type='"+ milkType +"' and date>='"+appliedDate+"'");
                    } else if(isSell){
                        rs = selectRecords.executeQuery("select sellid, rategeneratorid, fat, lacto, snf, totalmilk, date from sellentry where billgenerationflag=0 and type='"+ milkType +"' and date>='"+appliedDate+"'");
                    }
                    while(rs.next()){
                        PreparedStatement updatePst = null;
                        if(isPurchase){
                            updatePst = conn.prepareCall("update daillycollection set rate=?, totalamount=? where purchaseid=?");
                        } else if(isSell){
                            updatePst = conn.prepareCall("update sellentry set rate=?, totalamount=? where sellid=?");
                        }
                        
                        String purchaseSellid = rs.getString(1);
                        String rategeneratorid = rs.getString(2);
                        double fat = rs.getDouble(3);
                        double lacto = rs.getDouble(4);
                        double snf = rs.getDouble(5);
                        double totalmilk = rs.getDouble(6);
                        String collectiondate = rs.getString(7);
                        
                        double fatDiff = 0, snfDiff = 0, incrementPerFat = 0, incrementPerSNF = 0, decrementPerFat = 0;
                        double fatAmount = 0, snfAmount = 0, basicFat = 0, basicSNF = 0;
                        double decrementPerSNF = 0, bRate = 0;
                        double newRate = 0;
                        double newTotalAmount = 0;
                        basicFat = Double.parseDouble(fromFat);
                        basicSNF = Double.parseDouble(fromSNF);
                        incrementPerFat = Double.parseDouble(aFat);
                        decrementPerFat = Double.parseDouble(dFat);
                        incrementPerSNF = Double.parseDouble(aSNF);
                        decrementPerSNF = Double.parseDouble(dSNF);
                        bRate = Double.parseDouble(fromRate);
                        if (fat >= basicFat) {
                            fatDiff = Double.valueOf(form.format(fat - basicFat));
                            fatAmount = (fatDiff * incrementPerFat) * 10;
                        } else if (fat < basicFat) {
                            fatDiff = Double.valueOf(form.format(basicFat - fat));
                            fatAmount = (fatDiff * decrementPerFat) * 10;
                            fatAmount = -fatAmount;
                        }

                        if (snf >= basicSNF) {
                            snfDiff = Double.valueOf(form.format(snf - basicSNF));
                            snfAmount = (snfDiff * incrementPerSNF) * 10;
                        } else if (snf < basicSNF) {
                            snfDiff = Double.valueOf(form.format(basicSNF - snf));
                            snfAmount = (snfDiff * decrementPerSNF) * 10;
                            snfAmount = -snfAmount;
                        }
                        newRate = bRate + Double.valueOf(form.format(fatAmount)) + Double.valueOf(form.format(snfAmount));
                        double subTotal = totalmilk * newRate;
                        newTotalAmount = Double.valueOf(form.format(subTotal));
                        
                        updatePst.setDouble(1, newRate);
                        updatePst.setDouble(2, newTotalAmount);
                        updatePst.setString(3, purchaseSellid);
                        
                        int isUpdated = updatePst.executeUpdate();
                        
                        if(isUpdated > 0){
                            //continue
                        } else{
                            conn.rollback();
                            resultJSONObject.put("message", "Error occurred while rate applying in Dailly Collection. Please try again.");
                            resultJSONObject.put("success", false);
                        }
                    }
                    conn.commit();
                    resultJSONObject.put("message", "Record Added Successfully.");
                    resultJSONObject.put("success", true);
                } else {
                    conn.rollback();
                    resultJSONObject.put("message", "Some error Occurred... Pease try again.");
                    resultJSONObject.put("success", false);
                }
//            } else {
//                resultJSONObject.put("message", "Some error Occurred... Pease try again.");
//                resultJSONObject.put("success", false);
//            }
        } catch (Exception e) {
            conn.rollback();
            resultJSONObject.put("success", "false");
            resultJSONObject.put("message", "Some error.....");
            e.printStackTrace();
        } finally{
            conn.close();
        }
        return resultJSONObject;

    }

    @Override
    public JSONObject getChartDetails(HashMap<String, Integer> params) throws JSONException, IOException, SQLException {
        JSONObject respoJSONObject = null;
        try {
            respoJSONObject = new JSONObject();
            conn = DBPool.getConnection();
            
            int iscow = 0, isbuffalo = 0, ispurchase = 0, issell = 0;
            iscow = params.get("iscow");
            isbuffalo = params.get("isbuffalo");
            ispurchase = params.get("ispurchase");
            issell = params.get("issell");
            PreparedStatement pst = conn.prepareStatement("select bsnf,bfat,brate,aperfat,dperfat,apersnf,dpersnf from rategenerator where iscow=? and isbuffalo=? and purchase=? and sell=? and activeflag=1" );
            pst.setInt(1, iscow);
            pst.setInt(2, isbuffalo);
            pst.setInt(3, ispurchase);
            pst.setInt(4, issell);
            
            ResultSet rs = pst.executeQuery();
            
            while(rs.next()){
                respoJSONObject.put("snf", rs.getDouble(1));
                respoJSONObject.put("fat", rs.getDouble(2));
                respoJSONObject.put("brate", rs.getDouble(3));
                respoJSONObject.put("fatIncAmount", rs.getDouble(4));
                respoJSONObject.put("fatDecAmount", rs.getDouble(5));
                respoJSONObject.put("snfIncAmount", rs.getDouble(6));
                respoJSONObject.put("snfDecAmount", rs.getDouble(7));
                respoJSONObject.put("success", true);
            }
            if(respoJSONObject.length() == 0){
                respoJSONObject.put("success", true);
                respoJSONObject.put("message", "No any record found.");
            }
            
        } catch (Exception e) {
            respoJSONObject.put("success", false);
            respoJSONObject.put("message", "Some error occurred. Please try again.");
        } finally{
            conn.close();
        }
        return respoJSONObject;
    }
}

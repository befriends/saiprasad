/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import DBConnection.DBPool;
import Dao.RateGeneretorDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
public class RateGeneretorDaoImpl implements RateGeneretorDao{
    
     @Override
    public JSONObject addRateGenerator(HashMap< String, String> params) throws JSONException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        String fromFat = "", toFat = "", fromSNF = "", toSNF = "", fromRate = "", toRate = "", dFat = "", dSNF = "", rate = "", aFat = "", aSNF = "",adDate="",milkType="",rateType="",appliedDate="";
        double fatDiff = 0, snfDiff = 0, incrementPerFat = 0, incrementPerSNF = 0, decrementPerFat = 0, decreamentPerSNF = 0, fatAmount = 0, snfAmount = 0, enterFat = 0, enterSNF = 0, basicFat = 0, basicSNF = 0, bRate = 0, totalAmount = 0, decrementAmount = 0;
        double toFat2=0,toSNF2=0,toRate2=0;
        DecimalFormat form = new DecimalFormat("#.##");
        try {
            Connection conn = DBPool.getConnection();
            milkType=StringUtils.isNotEmpty(params.get("milktype")) ? params.get("milktype") : "";
            rateType=StringUtils.isNotEmpty(params.get("ratetype")) ? params.get("ratetype") : "";
            appliedDate=StringUtils.isNotEmpty(params.get("applieddate")) ? params.get("applieddate") : "";
            
            fromFat = StringUtils.isNotEmpty(params.get("fromfat")) ? params.get("fromfat") : "";
            if( StringUtils.isNotEmpty(params.get("tofat")))
            {
                toFat2=Double.parseDouble(params.get("tofat"));
            }

//            toFat = StringUtils.isNotEmpty(params.get("tofat")) ? params.get("tofat") : "";
            fromSNF = StringUtils.isNotEmpty(params.get("fromsnf")) ? params.get("fromsnf") : "";
             if( StringUtils.isNotEmpty(params.get("tosnf")))
            {
                toFat2=Double.parseDouble(params.get("tosnf"));
            }
//            toSNF = StringUtils.isNotEmpty(params.get("tosnf")) ? params.get("tosnf") : "";
            fromRate = StringUtils.isNotEmpty(params.get("fromrate")) ? params.get("fromrate") : "";
             if( StringUtils.isNotEmpty(params.get("torate")))
            {
                toFat2=Double.parseDouble(params.get("torate"));
            }
//            toRate = StringUtils.isNotEmpty(params.get("torate")) ? params.get("torate") : "";
            dFat = StringUtils.isNotEmpty(params.get("dfat")) ? params.get("dfat") : "";
            dSNF = StringUtils.isNotEmpty(params.get("dsnf")) ? params.get("dsnf") : "";
            rate = StringUtils.isNotEmpty(params.get("rate")) ? params.get("rate") : "";
            aFat = StringUtils.isNotEmpty(params.get("afat")) ? params.get("afat") : "";
            aSNF = StringUtils.isNotEmpty(params.get("asnf")) ? params.get("asnf") : "";
            
        
          
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

            PreparedStatement pst = null;
            if (StringUtils.isNotEmpty(fromFat)) {
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

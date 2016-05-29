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
        public JSONObject addMilkPurchaseDetails(HashMap<String, String> params) throws JSONException,IOException {
        boolean result = false;
        String milkmanid ="";
        JSONObject resultJSONObject = new JSONObject();
        try {
            Connection conn = DBPool.getConnection();
            PreparedStatement pst = conn.prepareStatement("select id from milkmandetails where code = ?");
            pst.setString(1, params.get("code"));
            ResultSet rs = pst.executeQuery();
            if (rs!=null) {
                while(rs.next()){
                    milkmanid = rs.getString(1);
                }
                PreparedStatement pst1 = conn.prepareStatement("insert into purchase_entry(milkmanid,fat,lacto,snf,subamount,deduction,totalamount,shift,type) values(?,?,?,?,?,?,?,?,?)");
                pst1.setString(1, milkmanid);
                pst1.setString(2, params.get("fat"));
                pst1.setString(3, params.get("lacto"));
                pst1.setString(4, params.get("snf"));
                pst1.setString(5, params.get("subtotal"));
                pst1.setString(6, params.get("deduction"));
                pst1.setString(7, params.get("totalamount"));
                pst1.setString(8, params.get("shift"));
                pst1.setString(9, params.get("type"));
                int r = pst1.executeUpdate();
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
    
}

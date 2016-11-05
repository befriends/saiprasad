/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import DBConnection.DBPool;
import Dao.ExpenseDao;
import com.mysql.jdbc.StringUtils;
import java.io.IOException;
import java.rmi.server.UID;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public class ExpenseDaoImpl implements ExpenseDao{
    
     Connection conn = null;

    @Override
    public JSONObject addExpenseMaterial(HashMap<String, String> params) throws JSONException, IOException {
        boolean result = false;
        JSONObject resultJSONObject = new JSONObject();
        
        String code="",date="",personName="",amount="",reason="";
        
        try {
             Connection conn = DBPool.getConnection();
            
             code = !StringUtils.isNullOrEmpty(params.get("code")) ? params.get("code") : "";
             date = !StringUtils.isNullOrEmpty(params.get("datepicker")) ? params.get("datepicker") : "";
            personName = !StringUtils.isNullOrEmpty(params.get("personname")) ? params.get("personname") : "";
            amount = !StringUtils.isNullOrEmpty(params.get("amount")) ? params.get("amount") : "";
            reason = !StringUtils.isNullOrEmpty(params.get("reason")) ? params.get("reason") : "";
            PreparedStatement pst = null;
            if (!StringUtils.isNullOrEmpty(code)) {
                pst = conn.prepareStatement("insert into expense(expenseid,date,personname,amount,reason,code) values(?,?,?,?,?,?)");
                pst.setString(1, UUID.randomUUID().toString());
                pst.setString(2, date);
                pst.setString(3, personName);
                pst.setString(4, amount);
                pst.setString(5, reason);
                pst.setString(6, code);
//                pst.setString(6, sellRate);
//                pst.setString(7, subTotal);
//                pst.setString(8, discount);
//                pst.setString(9, totalAmount);
//                pst.setString(10, customId);
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
        }
        
        
        return resultJSONObject;
    }
    
    
}

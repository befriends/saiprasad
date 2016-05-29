/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DaoImpl;

import DBConnection.DBPool;
import Dao.MilkSupplierDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;

/**
 *
 * @author vishwas
 */
public class MilkSupplierDaoImpl implements MilkSupplierDao{

    Connection conn = null;    
    
    @Override
    public String addMilkSupplier(HashMap<String, String> params) {
        JSONObject jobj = null;
        String code = "", fname = "", lname = "", accountno ="",accountbank = "",address ="",fullname="",dairyname="";
        long mobile=0;
        try {
            code = StringUtils.isNotEmpty(params.get("code")) ? params.get("code") : "";
            fname = StringUtils.isNotEmpty(params.get("fname")) ? params.get("fname") : "";
            lname = StringUtils.isNotEmpty(params.get("lname")) ? params.get("lname") : "";
            if(StringUtils.isNotEmpty(params.get("mobile")))
            {
                mobile = Long.parseLong(params.get("mobile"));
            }
            accountno = StringUtils.isNotEmpty(params.get("accountno")) ? params.get("accountno") : ""; 
            accountbank = StringUtils.isNotEmpty(params.get("accountbank")) ? params.get("accountbank") : "";
            address = StringUtils.isNotEmpty(params.get("address")) ? params.get("address") : "";
            dairyname = StringUtils.isNotEmpty(params.get("dairyname")) ? params.get("dairyname"):"";
            fullname = fname+" "+lname;
            conn = DBPool.getConnection();

            PreparedStatement pst = null;
            Statement st = conn.createStatement();
            pst = conn.prepareStatement("select count(*) from milkmandetails where code = ?");
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {
                pst = conn.prepareStatement("insert into milkmandetails(code, fullname,dairyname,mobile,accnumber,accbranch,addr) values(?,?,?,?,?,?,?)");
                pst.setString(1, code);
                pst.setString(2, fullname);
                pst.setString(3, dairyname);
                pst.setLong(4, mobile);
                pst.setString(5, accountno);
                pst.setString(6, accountbank);
                pst.setString(7, address);

                int r = pst.executeUpdate();
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
    
}

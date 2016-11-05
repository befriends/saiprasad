/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.CommonDao;
import com.mysql.jdbc.StringUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

/**
 *
 * @author sai
 */
public class CommonDaoImpl implements CommonDao {

    @Override
    public String generateNextID(HashMap<String, String> params) {

        String newCustomId = "";
        Connection con = null;
        try {
            String subModule = params.get("submodule");
            String columnName = params.get("columnname");
            con = DBPool.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("select MAX("+ columnName +") from " + subModule + ";");

            int max = 0;
            String customid = "";

            if (rs.next()) {
                customid = rs.getString(1);
            }
            
            if(!StringUtils.isNullOrEmpty(customid)){
                String prefix = customid.split("-")[0];
                long number = Long.parseLong(customid.split("-")[1]);
                newCustomId = prefix + "-" + (number + 1);
            } else{
                switch (subModule) {
                    case "milkmandetails":
                        newCustomId = "MLK-1";
                        break;
                    case "dairyregistration":
                        newCustomId = "DSL-1";
                        break;
                    case "sellentry":
                        newCustomId = "SL-1";
                        break;
                    case "purchasefood":
                        newCustomId = "FD-1"; //id="PD"+max;
                        break;
                    case "foodsell":
                        newCustomId = "FDS-1";
                        break;
                    case "expense":
                        newCustomId = "EXP-1";
                        break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return newCustomId;
    }
}

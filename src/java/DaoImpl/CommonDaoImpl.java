/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DaoImpl;

import DBConnection.DBPool;
import Dao.CommonDao;
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

        String id = "";
        Connection con = null;
        try {
            String subModule = params.get("submodule");
            String columnName = params.get("columnname");
            con = DBPool.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("select MAX(" + columnName + ") from " + subModule + ";");

            int max = 0;

            if (rs.next()) {

                max = rs.getInt(1) + 1;
            }

            switch (subModule) {
                case "milkmandetails":
                    id = "MLK" + max;
                    break;
                case "dairysell":
                    id = "SL" + max;
                    break;
                case "sellentry":
                    id = "SL" + max;
                    break;
                case "purchasefood":
                    id = "FD" + max; //id="PD"+max;
                    break;
                case "foodsell":
                    id = "FDS" + max;
                    break;
//                            
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }
}


package DaoImpl;

import DBConnection.DBPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Dao.LoginDao;
import java.io.IOException;
import org.json.JSONException;
import org.json.JSONObject;


public class LoginDaoImpl implements LoginDao {
    @Override
    public JSONObject validLogin(String username, String password) throws JSONException,IOException {
        boolean result = false;
            JSONObject resultJSONObject = new JSONObject();
        try {
            Connection conn = DBPool.getConnection();
            PreparedStatement pst = conn.prepareStatement("Select * from userlogin where username =? and password=? and roleid = ?");
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, "1");
            ResultSet rs = pst.executeQuery();
            if (rs!=null && rs.next()) {
                resultJSONObject.put("username", rs.getString("username"));
                resultJSONObject.put("password", rs.getString("password"));
                resultJSONObject.put("roleid", rs.getString("roleid"));
                resultJSONObject.put("success", "true");
                result =  true;
            } else {
                
                resultJSONObject.put("success", "false");
            }
        } catch (Exception e) {
            
            resultJSONObject.put("success", "false");
            e.printStackTrace();
        }
        return resultJSONObject;
    }
}

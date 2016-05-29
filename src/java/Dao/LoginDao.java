

package Dao;

import java.io.IOException;
import org.json.JSONException;
import org.json.JSONObject;


public interface LoginDao {
    
        public JSONObject validLogin(String username, String password) throws JSONException,IOException;
    
}

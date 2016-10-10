/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Dao;

import java.io.IOException;
import java.util.HashMap;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
public interface RateGeneretorDao {
    
     public JSONObject addRateGenerator(HashMap<String, String> params) throws JSONException, IOException;

    
}

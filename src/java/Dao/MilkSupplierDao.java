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
 * @author vishwas
 */
public interface MilkSupplierDao {

    public String addMilkSupplier(HashMap<String, String> params);

    public JSONObject getmilkMandetailsList() throws JSONException, IOException;
    
    public JSONObject addDairyRegistration(HashMap<String, String> params) throws JSONException, IOException;
    
    public JSONObject getDairyMilkList() throws JSONException, IOException;

}

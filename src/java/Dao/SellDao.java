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
public interface SellDao {

//    public JSONObject addDairySell(HashMap<String, String> params) throws JSONException, IOException;

    public JSONObject addDailySell(HashMap<String, String> params) throws JSONException, IOException;

    public JSONObject getDairyNameList() throws JSONException, IOException;

    public JSONObject foodSell(HashMap<String, String> params) throws JSONException, IOException;

    public JSONObject getCategoryList() throws JSONException, IOException;

    public JSONObject getSellEntryList(String selectedDate) throws JSONException, IOException;

    public JSONObject getMilkTypeListJson(String categoryid) throws Exception;

}

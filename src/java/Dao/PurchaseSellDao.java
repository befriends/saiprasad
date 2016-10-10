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
public interface PurchaseSellDao {

    public JSONObject addMilkPurchaseDetails(HashMap<String, String> params) throws JSONException, IOException;

    public JSONObject updateMilkPurchaseDetails(HashMap<String, String> params) throws JSONException, IOException;

    public JSONObject deleteMilkPurchaseDetails(String id) throws JSONException, IOException;

    public JSONObject getCollectionDetails(HashMap<String, String> params);

    public JSONObject getMilkmandetailsList() throws JSONException, IOException;

    public JSONObject getMilkManRecordList(String selectedDate) throws JSONException, IOException;

    public JSONObject getMilkType(String milkmanid) throws Exception;

    public JSONObject getNewDate(String milkmanid) throws Exception;

    public JSONObject addPurchaseFood(HashMap<String, String> params) throws JSONException, IOException;
    
    public JSONObject getMilkbilldetails(String startDate, String selectedDate,String milkManId) throws JSONException, IOException;

}

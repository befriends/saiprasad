/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import java.util.HashMap;
import org.json.JSONException;

/**
 *
 * @author sai
 */
public interface ReportDao {

    public String dateSales(HashMap<String, String> params) throws JSONException;

    public String MonthlySales(HashMap<String, String> params) throws JSONException;

    public String purchaseDate(HashMap<String, String> params) throws JSONException;

    public String purchaseMonth(HashMap<String, String> params) throws JSONException;

    public String purchaseCustomerName(HashMap<String, String> params) throws JSONException;
}

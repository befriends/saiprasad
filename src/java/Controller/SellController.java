/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.SellDao;
import DaoImpl.SellDaoImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author sai
 */
@WebServlet(name = "SellController", urlPatterns = {"/SellController"})
public class SellController extends HttpServlet {

    SellDao sellDAOObj = new SellDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        Boolean booleanResult = false;
        JSONObject jobj = null;
        try {
            jobj = new JSONObject();
//            menuItemDAOObj = new MenuItemDaoImpl();

            int act = Integer.parseInt(request.getParameter("act"));
            String module = request.getParameter("submodule");

            switch (act) {
                case 1: { // Add Methods
                    switch (module) {
//                        case "AddDairySell": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("code", request.getParameter("code"));
//                            params.put("dairyname", request.getParameter("dairyname"));
//                            params.put("personname", request.getParameter("personname"));
//                            params.put("altername", request.getParameter("altername"));
//                            params.put("address", request.getParameter("address"));
//                            params.put("mobile", request.getParameter("mobile"));
//                            params.put("alternumber", request.getParameter("alternumber"));
//                            params.put("account", request.getParameter("account"));
//                            params.put("accountbranch", request.getParameter("accountbranch"));
//                            params.put("tankernumber", request.getParameter("tankernumber"));
//                            params.put("amount", request.getParameter("amount"));
//                            params.put("type", request.getParameter("type"));
//                            resultJSONObject = sellDAOObj.addDairySell(params);
//                            response.sendRedirect("DairySellForm.jsp?result=" + resultJSONObject);
//                        }
//                        break;
                        case "AddDaillySell": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("date", request.getParameter("date"));
                            params.put("dairyid", request.getParameter("dairyid"));
                            params.put("dairyname", request.getParameter("dairyname"));
                            params.put("milktype", request.getParameter("milktype"));
                            params.put("drivername", request.getParameter("drivername"));
                            params.put("tankerno", request.getParameter("tankerno"));
                            params.put("liter", request.getParameter("liter"));
                            params.put("fat", request.getParameter("fat"));
                            params.put("lactose", request.getParameter("lactose"));
                            params.put("snf", request.getParameter("snf"));
                            params.put("protein", request.getParameter("protein"));
//                            params.put("totalmilk", request.getParameter("totamilk"));
                            params.put("shift", request.getParameter("shift"));
                            params.put("remark", request.getParameter("remark"));

                            resultJSONObject = sellDAOObj.addDailySell(params);
                            response.sendRedirect("DaillySell.jsp?result=" + resultJSONObject);
                        }
                        break;
                        case "FoodSell": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("customid", request.getParameter("customid"));
                            params.put("date", request.getParameter("date"));
                            params.put("customername", request.getParameter("customername"));
                            params.put("foodname", request.getParameter("foodname"));
                            params.put("sellrate", request.getParameter("sellrate"));
                            params.put("quantity", request.getParameter("quantity"));
                            params.put("subtotal", request.getParameter("subtotal"));
                            params.put("discount", request.getParameter("discount"));
                            params.put("totalamount", request.getParameter("totalamount"));
//                            params.put("currentbill", request.getParameter("currentbill"));
                            resultJSONObject = sellDAOObj.foodSell(params);
                            response.sendRedirect("FoodSell.jsp?result=" + resultJSONObject);

                        }
                        break;
                    }
                }
                break;
                    case 4: { // getdata
                    switch (module) {
                        case "sell": {
                            JSONObject responseJsonObj = new JSONObject();
                            HashMap<String, String> params = new HashMap<String, String>();
                            String customerid = request.getParameter("dairyid") == null ? request.getParameter("dairyname").toString(): request.getParameter("dairyid").toString();
                            responseJsonObj = sellDAOObj.getMilkTypeListJson(customerid);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
                            response.getWriter().write(responseJsonObj.toString());
                        }
                        break;
                        case "subcategory": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("subcategoryid", request.getParameter("subcategoryid"));
//                            params.put("subcategoryname", request.getParameter("subcategoryname"));
//                            result = menuItemDAOObj.updateSubCategory(params);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);

                        }
                        break;
                        case "menuitem": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("id", request.getParameter("id"));
//                            params.put("categoryid", request.getParameter("categoryid"));
//                            params.put("subcategoryid", request.getParameter("subcategoryid"));
//                            params.put("itemName", request.getParameter("itemname"));
//                            params.put("rate", request.getParameter("rate"));
//                            result = menuItemDAOObj.updateMenuItem(params);
//                            response.sendRedirect("AddMenuItem.jsp?result=" + result);

                        }
                        break;
                    }
                }
                break;
//                case 3: { // Delete Methods
//                    switch (submodule) {
//                        case "Purchase": {
////                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            resultJSONObject = PurchaseSellDaoObj.deleteMilkPurchaseDetails(id);
////                            response.sendRedirect("AddCategory.jsp?result=" + result);
//
//                        }
//                        break;
//                        case "subcategory": {
////                            HashMap<String, String> params = new HashMap<String, String>();
////                            String id = request.getParameter("id").toString();
////                            result = menuItemDAOObj.deleteSubCategory(id);
////                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
//
//                        }
//                        break;
//                        case "menuitem": {
////                            HashMap<String, String> params = new HashMap<String, String>();
////                            String id = request.getParameter("id").toString();
////                            result = menuItemDAOObj.deleteMenuItem(id);
////                            response.sendRedirect("AddMenuItem.jsp?result=" + result);
//                        }
//                        break;
//                    }
//                }
//                case 4: { // get data
//                    switch (submodule) {
//                        case "category": {
////                            HashMap<String, String> params = new HashMap<String, String>();
////                            String id = request.getParameter("id").toString();
////                            result = menuItemDAOObj.deleteCategory(id);
////                            response.sendRedirect("AddCategory.jsp?result=" + result);
//
//                        }
//                        break;
//                        case "collection": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String codeno = request.getParameter("codeno").toString();
//                            params.put("codeno", codeno);
//                            JSONObject jsonObj = PurchaseSellDaoObj.getCollectionDetails(params);
//                            response.getWriter().write(jsonObj.toString());
//                        }
//                        break;
//                        case "sell": {
//                            JSONObject responseJsonObj = new JSONObject();
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String customerid = request.getParameter("customerid") == null ? request.getParameter("customername").toString(): request.getParameter("customerid").toString();
//                            responseJsonObj = PurchaseSellDaoObj.getSubCategoryListJson(customerid);
////                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
//                            response.getWriter().write(responseJsonObj.toString());
//                        }
//                        break;
//                        case "menuitem": {
////                            HashMap<String, String> params = new HashMap<String, String>();
////                            String id = request.getParameter("id").toString();
////                            result = menuItemDAOObj.deleteMenuItem(id);
////                            response.sendRedirect("AddMenuItem.jsp?result=" + result);
//                        }
//                        break;
                    
                
               
            }
            

        } catch (Exception e) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

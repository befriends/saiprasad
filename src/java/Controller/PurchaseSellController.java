/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.PurchaseSellDao;
import DaoImpl.PurchaseSellDaoImpl;
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
 * @author vishwas
 */
@WebServlet(name = "dailyCollection", urlPatterns = {"/dailyCollection"})
public class PurchaseSellController extends HttpServlet {

    PurchaseSellDao PurchaseSellDaoObj = new PurchaseSellDaoImpl();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject resultJSONObject = new JSONObject();
        Boolean booleanResult = false;
        JSONObject jobj = null;
        try {
            jobj = new JSONObject();
//            menuItemDAOObj = new MenuItemDaoImpl();

            int act = Integer.parseInt(request.getParameter("act"));
            String submodule = request.getParameter("submodule");

            switch (act) {
                case 1: { // Add Methods
                    switch (submodule) {
                        case "AddDailyMilk": {
                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("code", request.getParameter("code"));
                            params.put("date", request.getParameter("date"));
                            params.put("milkmanid", request.getParameter("milkmanid"));
                            params.put("milkmanname", request.getParameter("milkmanname"));
                            params.put("milktype", request.getParameter("milktype"));
                            params.put("liter", request.getParameter("liter"));
                            params.put("fat", request.getParameter("fat"));
                            params.put("lactose", request.getParameter("lactose"));
                            params.put("snf", request.getParameter("snf"));
                            params.put("shift", request.getParameter("shift"));
                            params.put("remark", request.getParameter("remark"));
                            resultJSONObject = PurchaseSellDaoObj.addMilkPurchaseDetails(params);
                            response.sendRedirect("getDaillyCollection.jsp?result=" + resultJSONObject);
                        }
                        break;
                        case "PurchaseFood": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("code", request.getParameter("code"));
                            params.put("date", request.getParameter("date"));
                            params.put("companyname", request.getParameter("companyname"));
                            params.put("foodname", request.getParameter("foodname"));
                            params.put("quantity", request.getParameter("quantity"));
                            params.put("purchaserate", request.getParameter("purchaserate"));
                            params.put("sellrate", request.getParameter("sellrate"));
                            params.put("subtotal", request.getParameter("subtotal"));
                            params.put("discount", request.getParameter("discount"));
                            params.put("totalamount", request.getParameter("totalamount"));
                            resultJSONObject = PurchaseSellDaoObj.addPurchaseFood(params);
                            response.sendRedirect("PurchaseFood.jsp?result=" + resultJSONObject);
                        }
                        break;
                        case "AddRate": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("fromfat", request.getParameter("fromfat"));
//                            params.put("tofat", request.getParameter("tofat"));
//                            params.put("fromsnf", request.getParameter("fromsnf"));
//                            params.put("tosnf", request.getParameter("tosnf"));
//                            params.put("fromrate", request.getParameter("fromrate"));
//                            params.put("torate", request.getParameter("torate"));
//                            params.put("dfat", request.getParameter("dfat"));
//                            params.put("dsnf", request.getParameter("dsnf"));
//                            params.put("rate", request.getParameter("rate"));
//                            params.put("asnf", request.getParameter("asnf"));
//                            params.put("afat", request.getParameter("afat"));
//                            resultJSONObject = PurchaseSellDaoObj.addRateGenerator(params);
                            response.sendRedirect("MilkRateGenerator.jsp?result=" + resultJSONObject);

                        }
                        break;
                    }
                }
                break;
                case 2: { // Edit/Update Methods
                    switch (submodule) {
                        case "Purchase": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String snf = 
//                            params.put("code", request.getParameter("code"));
//                            params.put("type", request.getParameter("type"));
//                            params.put("liter", request.getParameter("liter"));
//                            params.put("fat", request.getParameter("fat"));
//                            params.put("lacto", request.getParameter("lacto"));
//                            params.put("remark", request.getParameter("remark"));
//                            params.put("shift", request.getParameter("shift"));
//                            params.put("date", request.getParameter("date"));
//                            resultJSONObject = PurchaseSellDaoObj.updateMilkPurchaseDetails(params);
//                            response.sendRedirect("DailyCollection.jsp?result=" + resultJSONObject);
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
                case 3: { // Delete Methods
                    switch (submodule) {
                        case "Purchase": {
//                            HashMap<String, String> params = new HashMap<String, String>();
                            String id = request.getParameter("id").toString();
                            resultJSONObject = PurchaseSellDaoObj.deleteMilkPurchaseDetails(id);
//                            response.sendRedirect("AddCategory.jsp?result=" + result);

                        }
                        break;
                        case "subcategory": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            result = menuItemDAOObj.deleteSubCategory(id);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);

                        }
                        break;
                        case "menuitem": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            result = menuItemDAOObj.deleteMenuItem(id);
//                            response.sendRedirect("AddMenuItem.jsp?result=" + result);
                        }
                        break;
                    }
                }
                case 4: { // get data
                    switch (submodule) {
                        case "category": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            result = menuItemDAOObj.deleteCategory(id);
//                            response.sendRedirect("AddCategory.jsp?result=" + result);

                        }
                        break;
                        case "collection": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            String codeno = request.getParameter("codeno").toString();
                            params.put("codeno", codeno);
                            JSONObject jsonObj = PurchaseSellDaoObj.getCollectionDetails(params);
                            response.getWriter().write(jsonObj.toString());
                        }
                        break;
                        case "Purchase": {
                            JSONObject responseJsonObj = new JSONObject();
                            HashMap<String, String> params = new HashMap<String, String>();
                            String milkmanid = request.getParameter("milkmanid") == null ? request.getParameter("milkmanname").toString(): request.getParameter("milkmanid").toString();
                            responseJsonObj = PurchaseSellDaoObj.getMilkType(milkmanid);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
                            response.getWriter().write(responseJsonObj.toString());
                        }
                        break;
                        case "StartDate": {
                            JSONObject responseJsonObj = new JSONObject();
                            HashMap<String, String> params = new HashMap<String, String>();
                            String milkmanid = request.getParameter("milkmanid") == null ? request.getParameter("milkmanname").toString(): request.getParameter("milkmanid").toString();
                            responseJsonObj = PurchaseSellDaoObj.getNewDate(milkmanid);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
                            response.getWriter().write(responseJsonObj.toString());
                        }
                        break;
                        case "billdetails": {
                            JSONObject responseJsonObj = new JSONObject();
                            String startDate = request.getParameter("startdate");
                            String endDate = request.getParameter("enddate");
                            String milkManId = request.getParameter("milkmanid");
                            responseJsonObj = PurchaseSellDaoObj.getMilkbilldetails(startDate, endDate, milkManId);
                            response.getWriter().write(responseJsonObj.toString());
                        }
                        break;
                    }
                }
                break;
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

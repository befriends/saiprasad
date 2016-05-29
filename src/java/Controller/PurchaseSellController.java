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
            String module = request.getParameter("module");

            switch (act) {
                case 1: { // Add Methods
                    switch (module) {
                        case "Purchase": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            String snf = 
                            params.put("code", request.getParameter("code"));
                            params.put("type", request.getParameter("type"));
                            params.put("liter", request.getParameter("liter"));
                            params.put("fat", request.getParameter("fat"));
                            params.put("lacto", request.getParameter("lacto"));
                            params.put("remark", request.getParameter("remark"));
                            params.put("shift", request.getParameter("shift"));
                            params.put("date", request.getParameter("date"));
                            resultJSONObject = PurchaseSellDaoObj.addMilkPurchaseDetails(params);
                            response.sendRedirect("DailyCollection.jsp?result=" + resultJSONObject);
                        }
                        break;
                        case "subcategory": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("customid", request.getParameter("customid"));
//                            params.put("categoryid", request.getParameter("categoryid"));
//                            params.put("subcategoryname", request.getParameter("subcategoryname"));
//                            result = menuItemDAOObj.addSubCategory(params);
//                            response.sendRedirect("AddSubCategory.jsp?result=" + result);
                        }
                        break;
                        case "menuitem": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("customid", request.getParameter("customid"));
//                            params.put("categoryid", request.getParameter("categoryid"));
//                            params.put("subcategoryid", request.getParameter("subcategoryid"));
//                            params.put("itemName", request.getParameter("itemName"));
//                            params.put("rate", request.getParameter("rate"));
//                            result = menuItemDAOObj.addMenuItem(params);
//                            response.sendRedirect("AddMenuItem.jsp?result=" + result);

                        }
                        break;
                    }
                }
                break;
                case 2: { // Edit/Update Methods
                    switch (module) {
                        case "Purchase": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            String snf = 
                            params.put("code", request.getParameter("code"));
                            params.put("type", request.getParameter("type"));
                            params.put("liter", request.getParameter("liter"));
                            params.put("fat", request.getParameter("fat"));
                            params.put("lacto", request.getParameter("lacto"));
                            params.put("remark", request.getParameter("remark"));
                            params.put("shift", request.getParameter("shift"));
                            params.put("date", request.getParameter("date"));
                            resultJSONObject = PurchaseSellDaoObj.updateMilkPurchaseDetails(params);
                            response.sendRedirect("DailyCollection.jsp?result=" + resultJSONObject);
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
                    switch (module) {
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
                    switch (module) {
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
                        case "menuitem": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            result = menuItemDAOObj.deleteMenuItem(id);
//                            response.sendRedirect("AddMenuItem.jsp?result=" + result);
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

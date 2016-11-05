/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Controller;

import Dao.BillingDAO;
import DaoImpl.BillingDAOImpl;
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
@WebServlet(name = "BillingController", urlPatterns = {"/BillingController"})
public class BillingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        JSONObject responseJSONObj = null;
        try (PrintWriter out = response.getWriter()) {
            int act = Integer.parseInt(request.getParameter("act"));
            String submodule = request.getParameter("submodule");

            BillingDAO billingDaoObj =  new BillingDAOImpl();
            
            switch (act) {
                case 1: { // Add Methods
                    switch (submodule) {
                        case "customerbill": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("milkmanid", request.getParameter("milkmanid"));
                            params.put("milkmanname", request.getParameter("milkmanname"));
                            params.put("startdate", request.getParameter("startdate"));
                            params.put("enddate", request.getParameter("enddate"));
                            params.put("commission", request.getParameter("commission"));
                            params.put("deduction", request.getParameter("deduction"));
                            params.put("remarks", request.getParameter("remarks"));
                            params.put("subtotal", request.getParameter("subtotal"));
                            params.put("totalamount", request.getParameter("totalamount"));
                            params.put("totalcommission", request.getParameter("totalcommission"));
                            params.put("totaldeduction", request.getParameter("totaldeduction"));
                            params.put("totalmillk", request.getParameter("totalmillk"));
                            responseJSONObj = billingDaoObj.generateCustomerBill(params);
//                            out.print(responseJSONObj.toString());
                            
                        }
                        break;
                         case "dairybill": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("dairyid", request.getParameter("dairyid"));
                            params.put("dairyname", request.getParameter("dairyname"));
                            params.put("startdate", request.getParameter("startdate"));
                            params.put("enddate", request.getParameter("enddate"));
                            params.put("commission", request.getParameter("commission"));
                            params.put("deduction", request.getParameter("deduction"));
                            params.put("remarks", request.getParameter("remarks"));
                            params.put("subtotal", request.getParameter("subtotal"));
                            params.put("totalamount", request.getParameter("totalamount"));
                            params.put("totalcommission", request.getParameter("totalcommission"));
                            params.put("totaldeduction", request.getParameter("totaldeduction"));
                            params.put("totalmillk", request.getParameter("totalmillk"));
                            responseJSONObj = billingDaoObj.generateDairyBill(params);
//                            out.print(responseJSONObj.toString());
                            
                        }
                        break;   
                    }
                }
                break;
                case 2: { // Edit/Update Methods
                    switch (submodule) {
                        case "customerbill": {
                        }
                        break;
                    }
                }
                break;
                case 3: { // Delete Methods
                    switch (submodule) {
                        case "customerbill": {
                        }
                        break;
                    }
                }
                case 4: { // get data
                    switch (submodule) {
                        case "customerbill": {
                        }
                        break;
                    }
                }
                break;
            }
            
            out.print(responseJSONObj.toString());
            
        } catch(Exception e){
            e.printStackTrace();
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

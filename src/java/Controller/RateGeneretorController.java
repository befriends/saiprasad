/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Controller;

import Dao.RateGeneretorDao;
import DaoImpl.RateGeneretorDaoImpl;
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
@WebServlet(name = "RateGeneretorController", urlPatterns = {"/RateGeneretorController"})
public class RateGeneretorController extends HttpServlet {

    RateGeneretorDao rateGeneretorDaoObj = new RateGeneretorDaoImpl();

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
                 case "AddRate": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("milktype", request.getParameter("milktype"));
                            params.put("fromfat", request.getParameter("fromfat"));
                            params.put("tofat", request.getParameter("tofat"));
                            params.put("fromsnf", request.getParameter("fromsnf"));
                            params.put("tosnf", request.getParameter("tosnf"));
                            params.put("fromrate", request.getParameter("fromrate"));
                            params.put("torate", request.getParameter("torate"));
                            params.put("dfat", request.getParameter("decreaseratefat"));
                            params.put("dsnf", request.getParameter("decreaseratesnf"));
                            params.put("rate", request.getParameter("rate"));
                            params.put("asnf", request.getParameter("increaseratesnf"));
                            params.put("afat", request.getParameter("increaseratefat"));
                            params.put("ratetype", request.getParameter("ratetype"));
                            params.put("applieddate", request.getParameter("applieddate"));
                            
                            resultJSONObject = rateGeneretorDaoObj.addRateGenerator(params);
                            response.sendRedirect("MilkRateGenerator.jsp?result=" + resultJSONObject);
//                            response.sendRedirect("ratechart.jsp?result=" + params);

                        }
                        break;
                    }
                }
                break;
            }
        }
        catch (Exception e) {

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
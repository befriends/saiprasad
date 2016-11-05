/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.ReportDao;
import DaoImpl.ReportDaoImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "ReportController", urlPatterns = {"/ReportController"})
public class ReportController extends HttpServlet {

    ReportDao recDao = new ReportDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String result = "";
        Boolean booleanResult = false;
        JSONObject jobj = null;
        try {
            jobj = new JSONObject();
            ReportDao recDao = new ReportDaoImpl();

            int act = Integer.parseInt(request.getParameter("act"));
            String submodule = request.getParameter("submodule");
            switch (act) {
                case 1: { // Add Methods
                    switch (submodule) {
//                        case "datewise": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String datestring= (null == request.getParameter("datepicker1") ? "" : request.getParameter("datepicker1"));
//                            if(datestring.length()==0){
//                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//                                Date date = new Date();
//                                datestring = dateFormat.format(date);
//                                //params.put("datepicker1", request.getParameter("datepicker1").length()>0 ? request.getParameter("datepicker1"): new Date());
//                            }
//                            params.put("datepicker1", datestring);
//                            result = recDao.dateSales(params);
//                            response.sendRedirect("DateWiseReport.jsp?result=" + result);
//                        }
//                        break;
                        case "datewise": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("datepicker", request.getParameter("datepicker"));
//                            params.put("year", request.getParameter("year"));
                            result = recDao.dateSales(params);
                            response.sendRedirect("DateWiseReport.jsp?result=" + result);
                        }
                        break;
                            case "monthlySales": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("month", request.getParameter("month"));
                            params.put("year", request.getParameter("year"));
                            result = recDao.MonthlySales(params);
                            response.sendRedirect("MonthWiseReport.jsp?result=" + result);
                        }
                        break;
                        case "purchasedatewise": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("datepicker", request.getParameter("datepicker"));
//                            params.put("year", request.getParameter("year"));
                            result = recDao.purchaseDate(params);
                            response.sendRedirect("PurchaseDateWiseReport.jsp?result=" + result);
                        }
                        break;
                        case "monthlypurchase": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("month", request.getParameter("month"));
                            params.put("year", request.getParameter("year"));
                            result = recDao.purchaseMonth(params);
                            response.sendRedirect("PurchaseMonthWiseReport.jsp?result=" + result);
                        }
                        break;
                        case "purchaseCustomerName": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("customername", request.getParameter("customername"));
                            params.put("year", request.getParameter("year"));
                            result = recDao.purchaseCustomerName(params);
                            response.sendRedirect("CustomerNameWiseReport.jsp?result=" + result);
                        }
                        break;
                        case "CustomerNameAndDateWise":
                        {
                         HashMap<String , String> params  = new HashMap<String ,String>();
                         params.put("customername", request.getParameter("customername"));
                         params.put("startdate",request.getParameter("startdate"));
                         params.put("enddate", request.getParameter("enddate"));
                         result = recDao.CustomerNameAndDateWiseList(params);
                         response.sendRedirect("CustomerNameAndDateWiseReport.jsp?result=" +result);
                        }
                        break;
                        case "DairyNameAndDateWise":
                        {
                            HashMap<String , String> params = new HashMap<String,String>();
                            params.put("dairyname", request.getParameter("dairyname"));
                            params.put("startdate", request.getParameter("startdate"));
                            params.put("enddate",request.getParameter("enddate"));
                            result = recDao.DairyNameAndDateWiseList(params);
                            response.sendRedirect("DairyNameAndDateWiseReport.jsp?result=" + result);
                            
                        }
                        break;
                             case "SelectCustomerNameAndDateWise":
                        {
                         HashMap<String , String> params  = new HashMap<String ,String>();
                         params.put("customername", request.getParameter("customername"));
                         params.put("startdate",request.getParameter("startdate"));
                         params.put("enddate", request.getParameter("enddate"));
                         result = recDao.CustomerNameAndDateList(params);
                         response.sendRedirect("CustomerNameAndDatesWiseReport.jsp?result=" +result);
                        }
                    }
                    break;
                }
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

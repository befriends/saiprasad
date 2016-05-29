package Controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import Dao.MilkSupplierDao;
import DaoImpl.MilkSupplierDaoImpl;
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
@WebServlet(name = "addMilkman", urlPatterns = {"/addMilkman"})
public class MilkSupplierController extends HttpServlet {
    MilkSupplierDao MilkSupplierDaoObj = new MilkSupplierDaoImpl();

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
        String result = "";
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
                        case "Milksupplier": {
                            HashMap<String, String> params = new HashMap<String, String>();
                            params.put("code", request.getParameter("milkmancode"));
                            params.put("fname", request.getParameter("fname"));
                            params.put("lname", request.getParameter("lname"));
                            params.put("mobile", request.getParameter("mobile"));
                            params.put("accountno", request.getParameter("accountno"));
                            params.put("accountbank", request.getParameter("accountbank"));
                            params.put("address", request.getParameter("address"));
                            params.put("dairyname", request.getParameter("dairyname"));
                            result = MilkSupplierDaoObj.addMilkSupplier(params);
                            response.sendRedirect("AddSupplier.jsp?result=" + result);
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
                        case "category": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            params.put("categoryid", request.getParameter("categoryid"));
//                            params.put("categoryname", request.getParameter("categoryname"));
//                            result = menuItemDAOObj.updateCategory(params);
//                            response.sendRedirect("AddCategory.jsp?result=" + result);

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
                        case "category": {
//                            HashMap<String, String> params = new HashMap<String, String>();
//                            String id = request.getParameter("id").toString();
//                            result = menuItemDAOObj.deleteCategory(id);
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

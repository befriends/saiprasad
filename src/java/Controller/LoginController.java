package Controller;

import Dao.LoginDao;
import DaoImpl.LoginDaoImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet(name = "validateLogin", urlPatterns = {"/validateLogin"})
public class LoginController extends HttpServlet {

    LoginDao loginDaoObj = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            doService(request, response);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (request.getParameter("isAndroid") != null) {
                JSONObject resultJSONObject = validLogin(request.getParameter("uname"), request.getParameter("password"));
                response.getWriter().print(resultJSONObject);
            } else {
                JSONObject resultJSONObject = validLogin(request.getParameter("uname"), request.getParameter("password"));
                if (resultJSONObject != null && resultJSONObject.has("success") && resultJSONObject.getBoolean("success")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("UserName", resultJSONObject.get("username"));
                    session.setAttribute("UserID", resultJSONObject.get("username"));
                    session.setMaxInactiveInterval(1200);
                    response.sendRedirect("Home.jsp");
                } else {
                    response.sendRedirect("Login.jsp");
                }
            }
        }
    } 

    public JSONObject validLogin(String user, String pwd) throws JSONException {
        JSONObject loginJSONObject = new JSONObject();
        try {
            loginJSONObject.put("success", false);
            loginDaoObj = new LoginDaoImpl();
            loginJSONObject = loginDaoObj.validLogin(user, pwd);
        } catch (Exception e) {
            loginJSONObject.put("success", false);
            e.printStackTrace();
        }
        return loginJSONObject;
    }
}

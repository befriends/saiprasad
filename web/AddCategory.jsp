<%-- 
    Document   : AddCategory
    Created on : 20 Mar, 2016, 2:24:35 PM
    Author     : vishwas
--%>

<%@page import="DaoImpl.MenuItemDaoImpl"%>
<%@page import="Dao.MenuItemDao"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String message = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" lang="javascript">
            function submitUpdateForm(cnt) {
                var f = "form" + cnt;
                document.getElementById(f).action = "UpdateCategory.jsp?act=2";
                document.getElementById(f).submit();
            }

            function submitDeleteForm(cnt) {
                var f = "form" + cnt;
                document.getElementById(f).action = "MenuItemController?act=3";
                document.getElementById(f).submit();
            }

        </script>
    </head>
    <body>
        <div style="margin-left: auto; margin-right: auto; width: 80%; background-color: antiquewhite;">
            <%
                if (request.getParameter("result") != "" && request.getParameter("result") != null) {
                    JSONObject jobj = new JSONObject(request.getParameter("result"));
                    message = jobj.getString("message");
                    if (jobj.getBoolean("success")) {
            %><span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: crimson;"><%=message%></h3></span><br /><%
                        } else {
                %><span style="width: 100%;margin-left: auto;margin-right: auto;"><h3 style="color: red;"><%=message%></h3></span><br /><%
                                }
                            }
                            MenuItemDao menuItemDaoObj = new MenuItemDaoImpl();

                %>
                <%!
                    JSONObject jobj = null;
                %>


            <h1>Add Category</h1>
            <div>
                <fieldset title="addCategory" style="width: 50%;height: 200px;text-align: center;">
                    <form action="MenuItemController" method="post">
                        <label>Category Code:</label> CAT<input type="text" name="customid" /><br />
                        <label>Category Name:</label> <input type="text" name="categoryname" /><br />
                        <input type="submit" name="submit" value="Add" />
                        <a href="home.jsp"><input type="button" name="cancel" value="Cancel" /></a>
                        <input type="hidden" name="act" value="1" />
                        <input type="hidden" name="submodule" value="category" />
                    </form>
                </fieldset>
                <table border="1px" style="margin-left: auto;margin-right: auto;">
                    <tr>
                        <th style="display: none;">ID</th>
                        <th>Category</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <%                            
                            String categoryList = menuItemDaoObj.getCategoryList();
                            JSONArray itemarr = new JSONArray(categoryList);
                            int cnt = 0;
                            while (cnt < itemarr.length()) {
                                JSONObject obj = itemarr.getJSONObject(cnt);
                        %>
                    <form id="form<%=cnt%>" name="form<%=cnt%>" action="" method="POST">
                        <td style="display: none;">
                            <input type="hidden" name="id" value="<%=obj.getLong("categoryid")%>" readonly />
                            <input type="hidden" name="submodule" value="category" readonly />
                        </td>

                        <td>
                            <input type="hidden" name="categoryid" value="<%=obj.getLong("categoryid")%>" readonly />
                            <input type="text" name="categoryname" hidden="true" value="<%=obj.get("categoryname")%>" readonly /><%=obj.get("categoryname")%>
                        </td>
                        <td>
                            <input type="button" name="Update" onclick="submitUpdateForm(<%=cnt%>);" value="Update"> / <input type="button" name="Delete" onclick="submitDeleteForm(<%=cnt%>);" value="Delete">
                        </td>
                        </tr>
                    </form>
                    <%
                            cnt++;
                        }
                    %>
                </table>
            </div>
        </div>
    </body>
</html>

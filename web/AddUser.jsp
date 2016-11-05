<%@page import="org.json.JSONArray"%>
<%@page import="DaoImpl.UserDaoImpl"%>
<%@page import="Dao.UserDao"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String message = "";
%>
<%
if(session.getAttribute("UserName") == null){
    response.sendRedirect("Login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
        <title>Add User</title>
            <script type="text/javascript" lang="javascript">
            function submitUpdateForm(cnt) {
                var f = "form" + cnt;
                document.getElementById(f).action = "UpdateUser.jsp?act=2";
                document.getElementById(f).submit();
            }

            function submitDeleteForm(cnt) {
                var f = "form" + cnt;
                document.getElementById(f).action = "UserController?act=3";
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
                            UserDao userDAOObj = new UserDaoImpl();

                %>
                <%!
                    JSONObject jobj = null;
                %>


            <h1>User Form</h1><br>
            <div>
                <fieldset title="addUser" style="width: 50%;height: auto;text-align: center;">
                    <form action="UserController" method="Post" name="addUser_form" style="color: orangered;">
                        ID :USE<input type="text" name="customid" style="color: red;"/><br>
                        Full Name : <input type="text" name="fullname" style="color: red;"/><br>
                        Address : <textarea type="text" name="address" style="color: red;" ></textarea><br>
                        Mob no : <input type="text" name="mobile" style="color: red;"/><br>
                        Gender :
                        <input type="radio" name="gender" value="m"/> Male
                        <input type="radio" name="gender" value="f"/> Female
                        <input type="radio" name="gender" value="o"/> Other<br> 
                        D.O.B.:<br>
                        User Name : <input type="text" name="username" style="color: red;"/><br>
                        Password  : <input type="password" name="password" style="color: red;"/><br>
                        <input type="submit" name="submit" value="Add"/>
                        <a href="home.jsp"> <input type="button" name="cancel" value="Exit"/></a>
                        <input type="hidden" name="act" value="1" />
                        <input type="hidden" name="submodule" value="user" />
                   
                    </form>
                </fieldset>
                <table border="1px" style="margin-left: auto;margin-right: auto;">
                    <tr>
                        <th style="display: none;">ID</th>
                        <th>Full Name</th>
                        <th>User Name</th>
                        <th>Address</th>
                        <th>Mobile No</th>
                        <th>Gender</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <%  String userList = userDAOObj.getUserList();
                            JSONArray userarr = new JSONArray(userList);
                            int cnt = 0;
                            while (cnt < userarr.length()) {
                                JSONObject obj = userarr.getJSONObject(cnt);
                        %>
                    <form id="form<%=cnt%>" name="form<%=cnt%>" action="" method="POST">
                        <td style="display: none;">
                            <input type="hidden" name="userid" value="<%=obj.getLong("userid")%>" readonly />
                            <input type="hidden" name="submodule" value="user" readonly />
                        </td>
                        <td>
                            <input type="text" name="fullname" hidden="true" value="<%=obj.get("fullname")%>" readonly /><%=obj.get("fullname")%>
                        </td>
                        <td>
                            <input type="text" name="username" hidden="true" value="<%=obj.get("username")%>" readonly /><%=obj.get("username")%>
                        </td>
                        <td>
                            <input type="text" name="address" hidden="true" value="<%=obj.get("address")%>" readonly /><%=obj.get("address")%>
                        </td>
                        <td>
                            <input type="text" name="mobile" hidden="true" value="<%=obj.get("mobile")%>" readonly /><%=obj.get("mobile")%>
                        </td>
                        <td>
                            <input type="text" name="gender" hidden="true" value="<%=obj.get("gender")%>" readonly />
                             <% if(obj.get("gender").equals("m")){%><%="Male" %><%} 
                            else if(obj.get("gender").equals("f")){%><%="Female" %><%}
                            else {%><%="Other" %><%} %>
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

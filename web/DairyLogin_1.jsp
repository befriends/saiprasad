<%-- 
    Document   : DairyLogin
    Created on : 3 Apr, 2016, 12:06:50 PM
    Author     : vishwas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            input.ng-invalid.ng-dirty{border: 1px solid red;}
        </style>
    </head>
    <body> <%-- For start any code --%>
        <form name="dairylogin">
            <div>
                
                User Name<input type="email" name="email" ng-model="user.email" required>
                <span ng-show="dairylogin.email.$dirty && dairylogin.email.$error.required">Required!</span>
                <span ng-show="dairylogin.email.$dirty && dairylogin.email.$error.email">not an email</span>
            </div>
            <div>
                Password<input
                    type="password"
                    name="password"
                    ng-model="user.password"
                    required
                    ng-minlength="3"
                    />
                <span ng-show="dairylogin.password.$dirty && dairylogin.password.$error.required">Required!</span>
                <span ng-show="dairylogin.password.$dirty && dairylogin.password.$error.minlenght">To short</span>

            </div>
            <input type="submit" name="submit" value="Sign in"/><input type="button" name="cancel" value="Exit"/>
        </form>
        
        <script src="http://code.angularjs.org/1.2.3/angular.min.js">
        </script>
    </body>
</html>

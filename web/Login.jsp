<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <title>Random Login Form</title>
    
    
    
    
        <style>
      /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
      @import url(http://fonts.googleapis.com/css?family=Exo:100,200,400);
      @import url(http://fonts.googleapis.com/css?family=Source+Sans+Pro:700,400,300);




    </style>

    
        <script src="js/prefixfree.min.js"></script>

    
  </head>
  <body>

    <div class="body"></div>
		<div class="grad"></div>
		<div class="header">
		</div>
		<br>
		<div class="login">
                    <form action="validateLogin" method="Post" name="login_form" style="color: orangered;">
				<input type="text" placeholder="username" name="uname" style="color: red;"><br>
				<input type="password" placeholder="password" name="password" style="color: red;"><br>
                                <input type="submit" name="submit" value="Login" style="color: white; background:blueviolet"/>
                                <input type="button" name="cancel" value="Exit"/>
                    </form>
		</div>
  </body>
</html>
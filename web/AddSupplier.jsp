<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd"
    >
<html lang="en">
    <link href="css/style.css" rel="stylesheet">
<head>
    <title>Register form with HTML5 using placeholder and CSS3</title>
</head>
<script>
    function validateForm() {
    var x = document.forms["addMilkman_form"]["milkmancode"].value;
    if (x == null || x == "") {
        alert("Code must be filled out");
        return false;
    }
}
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>
<style type="text/css">	
</style>
<body style="background:url(images/milk_1.jpg) fixed;background-size:cover;">
<div id="backgrnd" align="center" style="";>
    <div id="wrapper">
        <form action="addMilkman" name="addMilkman_form" onsubmit="return validateForm()" method="Post" style="color: orangered;">
        <!--<form action method="post">-->
            <fieldset>
                <legend>Milkman Registration Form</legend>
                <div >
                    <input type="hidden" name="act" value="1" />
                    <input type="hidden" name="module" value="Milksupplier" />
                    <input type="text" name="milkmancode" placeholder="Code Number"/>
                </div>
                <div >
                    <input type="text" name="fname" placeholder="First Name"/>
                </div>
                <div>
                    <input type="text" name="lname" placeholder="Last Name"/>
                </div>
                <div>
                    <input type="text" name="dairyname" placeholder="Dairy Name"/>
                </div>
                <div>
                    <input type="text" name="mobile" placeholder="Mobile No" onkeypress="return isNumber(event)"/>
                </div>
                <div>
                    <input type="text" name="accountno" placeholder="Account No"/>
                </div>
                <div>
                    <input type="text" name="accountbank" placeholder="Account Branch"/>
                </div>
                <div>
                    <textarea name="address" placeholder="Address"></textarea>
                </div>
                <input type="submit" name="submit" value="Submit"/>
            </fieldset>    
        </form>
    </div>
</div>

</body>
</html>
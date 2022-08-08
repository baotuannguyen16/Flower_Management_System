<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/loginutil.css">
        <link rel="stylesheet" type="text/css" href="css/logincss.css">
        <!--===============================================================================================-->
    </head>
    <body>

        <div class="limiter">
            <div class="container-login100" style="background-image: url('images/bg-01.jpg');">
                <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
                    <form class="login100-form validate-form" action="mainController" method="post">
                        <span class="login100-form-title p-b-49">
                            Sign Up
                        </span>

                        <div> <font style='color:red'><%= (request.getAttribute("checkExist") == null) ? "" : (String) request.getAttribute("checkExist")%> </font>
                        </div>

                        <div class="wrap-input100 m-b-23" >
                            <span class="label-input100">Email</span>
                            <input class="input100" type="text" name="txtemail" placeholder="Email: ai_do@example.com">
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>

                        <div><font style='color:red;'> <%=(request.getAttribute("messMail") == null) ? "" : (String) request.getAttribute("messMail")%></font>
                        </div>

                        <div class="wrap-input100 m-b-23" >
                            <span class="label-input100">Full name</span>
                            <input class="input100" type="text" name="txtfullname" placeholder="Type your name">
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>

                        <div><font style='color:red;'> <%=(request.getAttribute("messName") == null) ? "" : (String) request.getAttribute("messName")%></font>
                        </div>

                        <div class="wrap-input100 m-b-23" >
                            <span class="label-input100">Phone</span>
                            <input class="input100" type="text" name="txtphone" placeholder="Type your phone">
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>

                        <div><font style='color:red;'> <%=(request.getAttribute("messPhone") == null) ? "" : (String) request.getAttribute("messPhone")%></font>
                        </div>

                        <div class="wrap-input100 m-b-23" >
                            <span class="label-input100">Password</span>
                            <input class="input100" type="password" name="txtpassword" placeholder="Type your password">
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>

                        <div><font style='color:red;'> <%=(request.getAttribute("messPass") == null) ? "" : (String) request.getAttribute("messPass")%></font>                           
                        </div>

                        <div style="margin-bottom: 16px; margin-top: -12px">

                            <font style='color:red'><%= (request.getAttribute("messLog") == null) ? "" : (String) request.getAttribute("messLog")%> </font>
                            <font style='color:red;'><%= (request.getAttribute("WARNING") == null) ? "" : (String) request.getAttribute("WARNING")%> </font>

                        </div>



                        <div class="container-login100-form-btn" style="margin-top: 32px">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" type="submit" name="action" value="register">
                                    Register Now
                                </button>
                            </div>
                        </div>

                        <div class="flex-col-c p-t-155" style="margin-top: -108px">
                            <span class="txt1 p-b-17">
                                You Already Have an Account
                            </span>

                            <a href="login.jsp" class="txt2">
                                Login
                            </a>

                            <div style="margin-top: 16px">
                                <a href="index.jsp" class="txt2">
                                    Back to home
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/loginjs.js"></script>

    </body>
</html>
<%-- 
    Document   : login
    Created on : Jul 19, 2014, 6:05:02 PM
    Author     : menjiang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html ng-app="InhouseMap">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <base href="<c:url value="/"/>">
        <title>登录</title>
        <!-- Bootstrap core CSS -->
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/angular-busy.min.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="resources/css/dashboard.css" rel="stylesheet">
    </head>
    <body ng-controller="AccountController">
        <!-- Modal -->
        <div class="modal-dialog" style="width: 500px">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="form-signin">
                        <form class="form-horizontal" role="form"
                              id="loginForm" action="login_check" method="post">
                            <h2 style="text-align: center" class="form-signin-heading">登录</h2>
                            <div ng-show="loginError" class="alert alert-danger">用户名或密码不正确</div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" name="username" class="form-control"
                                           placeholder="输入用户名" autofocus>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" name="password"
                                           placeholder="输入密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <a href="#" style="float: right;">忘记密码?</a>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
        <!-- /.modal -->
        <!-- Bootstrap core JavaScript ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript" src="resources/js/jquery.min.js"></script>
        <script type="text/javascript" src="resources/js/bootstrap.js"></script>
        <script type="text/javascript" src="resources/js/angular.min.js"></script>
        <script type="text/javascript" src="resources/js/bindonce.min.js"></script>
        <script type="text/javascript" src="resources/js/angular-busy.min.js"></script>
        <script type="text/javascript" src="resources/js/ng-flow-standalone.min.js"></script>
        <script type="text/javascript" src="resources/js/fusty-flow.js"></script>
        <script type="text/javascript" src="resources/js/fusty-flow-factory.js"></script>
        <script type="text/javascript" src="resources/js/pagination.min.js"></script>
        <script type="text/javascript" src="resources/js/home.js"></script>
    </body>
</html>

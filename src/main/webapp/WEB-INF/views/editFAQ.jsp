<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html lang="en" ng-app="ChatBot">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<base href="<c:url value="/"/>">

<title>ChatBot管理页面</title>

<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/angular-busy.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="resources/css/dashboard.css" rel="stylesheet">
<link href="resources/css/themes/default/css/umeditor.css"
	type="text/css" rel="stylesheet">
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href=".">bot</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/admin">全部问题</a></li>
					<li class="active"><a href="/admin/editFAQ">编辑问题</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/logout">退出登录</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid" ng-controller="BotMngmtCtrl">
		<div class="row">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<input type="hidden" id="sId" value="${sId }"> <label>问题</label>
						<input type="hidden" id="question" value="${question }"> <input
							type="text" style="margin-bottom: 10px" ng-model="question"
							class="form-control"></input>
					</div>
					<div class="modal-body" style="min-height: 400px">

						<label>答案</label>
						<script type="text/plain" id="myEditor"
							style="width: 100%; height: 240px;">${answer}</script>
						<button ng-click="submit()" class="btn btn-default">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.js"></script>
	<script type="text/javascript" src="resources/js/angular.min.js"></script>
	<script type="text/javascript"
		src="resources/js/angular-sanitize.min.js"></script>
	<script type="text/javascript" src="resources/js/pagination.min.js"></script>
	<script type="text/javascript" src="resources/js/home.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="resources/js/umeditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="resources/js/umeditor.min.js"></script>
	<script type="text/javascript" src="resources/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript">
		var um = UM.getEditor('myEditor');
	</script>
</body>
</html>
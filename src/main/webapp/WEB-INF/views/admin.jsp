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
				<a class="" href="."><img alt="自在客" style="width:45px;height:45px;margin:3px 10px 0 0" src="http://pages.zizaike.com/a/img/newhomepages/Logo.png"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="./admin">全部问题</a></li>
					<li><a href="./admin/editFAQ">添加问题</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./logout">退出登录</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid" ng-controller="BotMngmtCtrl">
		<div class="row">
			<table class="table table-hover" style="margin:20px">
				<thead>
					<tr>
						<th>操作</th>
						<th>问题</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="item in items">
						<td><a href="/admin/editFAQ?id={{item.id}}"> <span
								class="glyphicon glyphicon-edit"></span>
						</a> <a ng-click="deleteFaq($index, item.id)"> <span
								class="glyphicon glyphicon-trash"></span>
						</a></td>
						<td>{{item.question|cut:false:150}}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<pagination ng-show="totalItemsCount" total-items="totalItemsCount"
			items-per-page="pageSize" ng-model="currentPage"
			ng-change="pageChanged()" max-size="10" previous-text="后退"
			next-text="前进" first-text="首页" last-text="末页" rotate="false"
			class="pagination-sm" boundary-links="true"></pagination>
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
</body>
</html>
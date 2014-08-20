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
<base href="<c:url value="/"/>">

<title>自在客客服</title>

<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/angular-busy.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="resources/css/dashboard.css" rel="stylesheet">
</head>
<body ng-controller="ChatCtrl">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">
					<span class="label label-default">自在客</span>自动问答机器人
				</h4>
			</div>
			<div class="modal-body bubble" id="scroll" style="height: 400px;overflow: scroll;">
				<div ng-repeat="dialog in dialogs.slice(dialogs.length-5<0?0:dialogs.length-30, dialogs.length)" on-last-repeat>
					<div ng-show="dialog.owner == 'bot'">
						<img src="http://pages.zizaike.com/a/img/newhomepages/Logo.png">
					</div>
					<div ng-show="dialog.owner != 'bot'"  style="text-align:right">
						<img src="./resources/img/avatar.jpg" style="width:60px;height:60px">
					</div>
					<div class="demo clearfix"
						ng-class="{false:'fr'}[dialog.owner=='bot']">
						<span class="triangle"
							ng-class="{false:'right'}[dialog.owner=='bot']"></span>
						<p class="article" style="margin-top: 5px;">
							<span ng-bind-html-unsafe="dialog.content"></span> 
							<span ng-show="dialog.faqs"> 
								<br /> <br /> <b>其他相关问题:</b> <a
								href="#" ng-repeat="faq in dialog.faqs"
								ng-click="refine(faq.id)"><br /> {{faq.question}}</a>
							</span>
						</p>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<div class="col-sm-11">
							<textarea class="form-control" style="height:80px"  ng-model="question" ng-keypress="enter($event)"></textarea>
						</div>
						<button type="button" style="height:80px;" class="btn btn-primary col-sm-1" ng-click="ask()">发送</button>
					</div>
				</form>
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
	<script>
		$('.modal-body').scrollspy({ target: '#chat_container' })
	</script>
</body>
</html>
angular.module('ChatBot', [ 'ngSanitize', 'ui.bootstrap.pagination' ]).config(
		[ '$compileProvider', function($compileProvider) {
			$compileProvider.directive({
				ngBindHtmlUnsafe : function() {
					return function(scope, element, attr) {
						element.addClass('ng-binding').data('$binding', attr.ngBindHtmlUnsafe);
						scope.$watch(attr.ngBindHtmlUnsafe, function ngBindHtmlUnsafeWatchAction(value) {
							element.html(value || '');
						});
					}
				}
			});
		} ]).controller('ChatCtrl', function($scope, $http) {
	$scope.dialogs = [];
	$scope.question = '';

	$scope.enter = function(ev) {
		if (ev.keyCode !== 13)
			return;
		$scope.ask();
	}
	$scope.ask = function() {
		$scope.dialogs.push({
			'owner' : 'human',
			'content' : $scope.question
		});
		if ($scope.question != '') {
			$http.get('./bot/ask?page=0&pageSize=5&q=' + encodeURIComponent("question:"+$scope.question+" or answer:"+$scope.question)).success(function(data) {
				$scope.dialogs.push({
					'owner' : 'bot',
					'content' : data[0].answer,
					'faqs' : data.slice(1, data.length)
				})
				$scope.question = '';
			});
		}
	};
	$scope.refine = function(id) {
		$http.get('./bot/ask?q=' + encodeURIComponent("id:" + id) + '&pageSize=5&page=0').success(function(data) {
			$scope.dialogs.push({
				'owner' : 'bot',
				'content' : data[0].answer,
				'faqs' : data.slice(1, data.length)
			});
			$scope.question = '';
		});
	}
}).controller(
		'BotMngmtCtrl',
		function($scope, $http) {
			$scope.keyword = "";
			$scope.question = document.getElementById("question") ? document.getElementById("question").value:"";
			$scope.sId = document.getElementById("sId") ? document.getElementById("sId").value : "";
			$scope.currentPage = 1;

			$scope.deleteFaq=function(index, sId){
				if(confirm('确定要删除 #'+index+' 吗？')){
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					var headers = JSON.parse('{"'+header+'": "'+token+'"}')
					$http.delete('./admin/faq?id='+encodeURIComponent(sId), {headers: headers}).success(function(data){
						console.log(data);
						window.location="./admin";
					});
				}
			};
			$scope.pageChanged = function() {
				$http.get(
						'./bot/ask?q=' + encodeURIComponent($scope.keyword) + '&pageSize=20&page=' + ($scope.currentPage - 1))
						.success(function(data, status, headers, config) {
							$scope.items = data;
							$scope.totalItemsCount = headers('TotalItemsCount');
							$scope.totalPageCount = headers('TotalPageCount');
							$scope.pageSize = headers('PageSize');
						});
			};
			
			$scope.pageChanged();
			$scope.submit = function() {
				$scope.answer = UM.getEditor('myEditor').getContent();
				if ($scope.question.trim().length > 0 && $scope.answer.trim().length > 0) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					var headers = JSON.parse('{"'+header+'": "'+token+'"}')
					$http.post("./admin/faq", {
						id : $scope.sId,
						question : $scope.question,
						answer : $scope.answer
					},{headers: headers}).success(function(data) {
						$scope.id="";
						$scope.question = "";
						$scope.answer = "";
						UM.getEditor('myEditor').setContent('');
					})
				}
			}
		});
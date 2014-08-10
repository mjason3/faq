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
	$scope.refine = function(question) {
		$http.get('./bot/ask?q=' + encodeURIComponent("question:" + question + " or answer:" + question) + '&pageSize=5&page=0').success(function(data) {
			$scope.dialogs.push({
				'owner' : 'bot',
				'content' : data[0].answer,
				'faqs' : data.slice(1, data.length)
			})
			$scope.question = ''
		});
	}
}).controller(
		'BotMngmtCtrl',
		function($scope, $http) {
			$scope.keyword = "";
			$scope.currentPage = 1;
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
					$http.post("./bot", {
						question : $scope.question,
						answer : $scope.answer
					}).success(function(data) {
						$scope.question = "";
						$scope.answer = "";
						UM.getEditor('myEditor').setContent('');
					})
				}
			}
		});
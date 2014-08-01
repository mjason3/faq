angular.module('ChatBot', [ 'ngSanitize' ]).config([ '$compileProvider', function($compileProvider) {
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
			$http.get('./bot/ask?q=' + encodeURIComponent($scope.question)).success(function(data) {
				$scope.dialogs.push({
					'owner' : 'bot',
					'content' : data[0].answer,
					'faqs' : data.slice(1, data.length)
				})
				$scope.question = ''
			});
		}
	};
	$scope.refine = function(question) {
		$http.get('./bot/ask?q=' + encodeURIComponent(question)).success(function(data) {
			$scope.dialogs.push({
				'owner' : 'bot',
				'content' : data[0].answer,
				'faqs' : data.slice(1, data.length)
			})
			$scope.question = ''
		});
	}
}).controller('BotMngmtCtrl', function($scope, $http) {
	$scope.question = "";
	$scope.answer = "";

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
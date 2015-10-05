app = angular.module 'app', ['OODLib']

app.controller 'appCtrl', ['$scope', ($scope) ->
  $scope.accounts = [
    userName: 'prince'
    email: 'prince@trantect.com'
    phone: '12345678'
  ,
    userName: 'Steven Jobs'
    email: 'steven.jobs@trantect.com'
    phone: '13579872'
  ]
]


app = angular.module "OODlib", []

ctableConfig =
  restrict: 'E'
  templateUrl: 'build/table/table.html'
  scope:
    storage: '=info'
  link: (scope, element, attr) ->
    events =
      'click': () ->
        alert 'click event fired'
    EventRegister.register element, events


Directive.register app, 'ctable', ctableConfig


app.controller 'envCtrl', ['$scope', ($scope) ->
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


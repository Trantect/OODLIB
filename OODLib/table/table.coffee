app = angular.module "OODlib", []


app.controller 'envCtrl', ['$scope', ($scope) ->
  $scope.books = [
    title: 'A Little Prince'
    price: '20'
  ,
    title: 'The stored life'
    price: '35'
  ]
]

app.directive 'ctable', () ->
  restrict: 'E'
  templateUrl: 'build/table/table.html'
  scope:
    storage: '=info'


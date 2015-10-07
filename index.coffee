config =
  events:
    tr:
      'click': 'displayDetail'
      'mouseover': 'displayOptionButtons'
    th:
      'click': 'sorting'

d = new TableDirective
DirectiveSchool.register OOD, 'ctable', d

###
d.handlers['displayDetail'] = () ->
  table = d.scope.model
  table.setCurrentPage 2
  d.scope.storage = table.currentData
  d.scope.$apply()
  d.scope.storage = [
    company: 'trantect'
    age: '3'
  ,
    company: 'shanbay'
    age: '2'
  ]
  d.scope.$digest()
  console.log table.data
  console.log "hello world"
###



app = angular.module 'app', ['OODLib']

app.controller 'appCtrl', ['$scope', ($scope) ->
  $scope.accounts = [
    userName: 'prince'
    email: 'prince@trantect.com'
    phone: '12345678'
    age:'22'
  ,
    userName: 'Steven Jobs'
    email: 'steven.jobs@trantect.com'
    phone: '13579872'
    age:'24'
  ]

  $scope.accounts[0].age =78
]


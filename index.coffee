config = [
  selector: 'tr'
  action: 'click'
  handlerName: 'displayDetails'
,
  selector: 'tr'
  action: 'mouseover'
  handlerName: 'displayOptionButtons'
,
  selector: 'th'
  action: 'click'
  handlerName: 'sorting'
,
  selector: 'ul#pagination>li'
  action: 'click'
  handlerName: 'getDataByPage'
]

d = new TableDirective {}, config
DirectiveSchool.register OOD, 'ctable', d

d.setHandler 'getDataByPage', (element, model, scope, event) ->
  model.setCurrentPage event.currentTarget.id

f = new FooterDirective()
DirectiveSchool.register OOD, 'cfooter', f


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
  ,
    userName: 'sella'
    email: 'sella@trantect.com'
    phone: '123657922'
  ,
    userName: 'dash front'
    email: 'dash@trantect.com'
    phone: '135568126'
  ]
  $scope.fruits = [
    name: 'apple'
    season: 'fall'
    price: '3'
  ,
    name: 'orange'
    season: 'fall'
    price: '1'
  ,
    name: 'banana'
    season: 'sprint'
    price: '2'
  ,
    name: 'kiwi'
    season: 'winter'
    price: '10'
  ]

  $scope.company =
    name: '启明星辰'
    version: '10.0.13980.1'
    status: 'alpha'
    year: '2015'
    website: 'http://alpha.nj.trantect.com/'
    websiteName: '云子可信官网'

]


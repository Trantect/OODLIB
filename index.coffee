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
  $scope.accountDetails = ['email', 'phone']
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

  $scope.fruitDetails = ['season', 'price']

  $scope.company =
    name: '启明星辰'
    version: '10.0.13980.1'
    status: 'alpha'
    year: '2015'
    website: 'http://alpha.nj.trantect.com/'
    websiteName: '云子可信官网'

  $scope.firstClassMenu = [
  	name: '首页'
  	haveSecondClass: 'no'
  	link: '/'
    icon: 'fa.fa-home'
	,
  	name: '终端管理'
  	haveSecondClass: 'yes'
  	link: ''
    icon: 'fa.fa-laptop'
	,
  	name: '软件管理'
  	haveSecondClass: 'no'
  	link: ''
    icon: ''
	,
  	name: '统计报表'
  	haveSecondClass: 'no'
  	link: ''
    icon: ''
	,
	name: '安全日志'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '服务日志'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '当前任务'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '历史任务'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '帐号管理'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '分组管理'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '定时体检'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '设置中心'
	haveSecondClass: 'no'
	link: ''
icon: ''
	,
	name: '下载终端'
	haveSecondClass: 'no'
	link: ''
icon: ''
	]
	$scope.secondClassMenu = [
		name: '首页'
		link: ''
icon: ''
	,
	name: '首页'
	link: ''
icon: ''
	,
	name: '首页'
	link: ''
icon: ''
	,
	name: '首页'
	link: ''
icon: ''
	,
	name: '首页'
	link: ''
icon: ''
	,
	name: '首页'
	link: ''
icon: ''
	,
	]


]

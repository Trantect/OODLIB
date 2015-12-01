app = angular.module 'app', ['OODLib']

app.controller 'appCtrl', ['$scope', '$location', ($scope, $location) ->

  $scope.$watch () ->
    $location.path()[1..]
  , (nV, oV) ->
    $scope.activeItem = nV
    console.log nV

  $scope.displayTitles =
    "clientId":"用户号"
    "nickname":"用户名"
    "MACAddr":"Mac地址"
    "groupName":"组名"
    "clientName":"用户名称"
    "diskSN":"硬盘号"
    "os":"操作系统"
    "pcSN":"计算机序列号"
    "cpuType":"cpu 型号"
    "ip":"IP 地址"
    "pcType":"计算机类型"

  $scope.username = 'Trantect'
  $scope.title = "Hardware Management"
  $scope.hardwareDetail = ['clientName', 'cpuType', 'diskSN', 'pcSN']
  $scope.hardwareBrief = ['nickname', 'ip', 'MACAddr', 'groupName', 'os', 'pcType']
  $scope.hardware = [
    "clientId":"b1TJVRqo_e"
    "nickname":"viola_desktop"
    "MACAddr":"00:E0:4C:4D:EF:17"
    "groupName":"未分组"
    "clientName":"Viola-PC"
    "diskSN":"SV300S37A12"
    "os":"Windows 7"
    "pcSN":"03000200-0400-0500-0006-000700080009"
    "cpuType":"Intel(R) Celeron(R) CPU G530 @ 2.40GHz"
    "ip":"192.168.0.249"
    "pcType":"台式机"
  ,
    "clientId":"byB5Ikioug"
    "nickname":"lynx_virtual machine"
    "MACAddr":"08:00:27:78:62:89"
    "groupName":"未分组"
    "clientName":"lynx-PC"
    "diskSN":"VBOX HARDDISK"
    "os":"Windows 7"
    "pcSN":"CA754EAE-6301-CF40-8908-EBC44BF55EE4"
    "cpuType":"Intel(R) Celeron(R) CPU G1840 @ 2.80GHz"
    "ip":"10.0.2.15"
    "pcType":"其他"
  ,
    "clientId":"bJeGNC9s_e"
    "nickname":"brown_laptop"
    "MACAddr":"1C:87:2C:3C:E6:F6"
    "groupName":"未分组"
    "clientName":"supporter-pc"
    "diskSN":"ST500LT012-1DG142"
    "os":"Windows 10"
    "pcSN":"9B150812-DEE0-5E40-AFFF-636C4C398B6A"
    "cpuType":"Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz"
    "ip":"192.168.0.246"
    "pcType":"笔记本"
  ,
    "clientId":"WyxTJE0qi_e"
    "nickname":"zita-PC"
    "MACAddr":"--:--:--:--:--:--"
    "groupName":"未分组"
    "clientName":"zita-PC"
    "diskSN":"--"
    "os":"--"
    "pcSN":"--"
    "cpuType":"--"
    "ip":"--"
    "pcType":"--"
  ,
    "clientId":"bykgNA9j_g"
    "nickname":"emily-PC"
    "MACAddr":"--:--:--:--:--:--"
    "groupName":"未分组"
    "clientName":"emily-PC"
    "diskSN":"--"
    "os":"--"
    "pcSN":"--"
    "cpuType":"--"
    "ip":"--"
    "pcType":"--"
  ]


  $scope.company =
    copyright: '2015 Demo'
    version: '0.0.1 alpha'
    websites: [
      'our site':'http://www.trantect.com'
    ,
      'our site':'http://www.trantect.com'
    ,
      'help': 'http://help.trantect.com'
    ,
      'link': '#'
    ,
      '世界': "http://www.sina.com"
    ]




  $scope.aside1 =
    frontpage:
      name: '首页'
      URL: '/'
      icon: 'fa fa-home'
    terminalManagement:
      name: '终端管理'
      URL: '#'
      icon: 'fa fa-laptop'
      arrowIcon: 'fa fa-angle-down'
      subnodes:
        monitor:
          name: '安全监控'
          URL: '#monitor'
          icon: 'fa fa-circle-thin fa-1'
        terminalSpeedUp:
          name: '终端加速'
          URL: '#terminalSpeedUp'
          icon: 'fa fa-circle-thin fa-1'
        powerUpSpeedUp:
          name: '开机加速'
          URL: '#powerUpSpeedUp'
          icon: 'fa fa-circle-thin fa-1'
        hardware:
          name: '硬件资产'
          URL: '#hardware'
          icon: 'fa fa-circle-thin fa-1'
    softwareManagement:
      name: '软件管理'
      URL: '#softwareManagement'
      icon: 'fa fa-laptop'
    statisticsChart:
      name: '统计报表'
      URL: '#statisticsChart'
      icon: ''
    safeLog:
      name: '安全日志'
      URL: '#safeLog'
      icon: ''
    serveLog:
      name: '服务日志'
      URL: '#serveLog'
      icon: ''



  $scope.what = {}

  $scope.aside2 =
    currentTask:
      name: '当前任务'
      URL: '#currentTask'
      icon: ''
    taskHistory:
      name: '历史任务'
      URL: '#taskHistory'
      icon: ''



  $scope.aside3 =
     accountManagement:
       name: '帐号管理'
       URL: '#accountManagement'
       icon: ''
     groupManagement:
       name: '分组管理'
       URL: '#groupManagement'
       icon: ''
     scanTimer:
       name: '定时体检'
       URL: '#scanTimer'
       icon: ''
  ### 
  $scope.aside4 =
    setting:
      name: '设置中心'
      URL: '#setting'
      icon: ''
      subnodes:
        serverConfig:
          name: '控制中心相关设置'
          URL: '#serverConfig'
          icon: ''
        clientConfig:
          name: '终端相关设置'
          URL: '#clientConfig'
          icon: ''
  ###
  
  $scope.aside5 =
    download:
      name: '下载终端'
      URL: '#download'
      icon: ''
  

]

###
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/', {templateUrl: 'index.html'})
    .otherwise('index.html')

]
###

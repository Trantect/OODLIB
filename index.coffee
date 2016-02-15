#app = angular.module 'app', ['OOD_topBar', 'OOD_dropdownMenu', 'OOD_footer', 'OOD_sidebar', 'OOD_table']
app = angular.module 'app', ['OOD_topBar', 'OOD_sidebar']

app.controller 'appCtrl', ['$scope', '$location', '$timeout', '$window', '$rootScope', ($scope, $location, $timeout, $window, $rootScope) ->

  $scope.activeItem = $location.path()[1..]


  $scope.style = class TableCss
    @cellIcon: (key, vaule) ->
      icon = switch key
        when 'nickname' then 'fa fa-desktop'
        when 'groupName' then 'fa fa-client-group'
        else 'hide'

    @cell: (key, value) ->
      bg = switch
        when key=='nickname' or key=='groupName' then 'td-icon'

    @detail: (item) ->
      'bcolor'
  $scope.user = 'phoenix'
  $scope.ddmBody =
    one:'111'
    two:'222'
    three:'333'
    four:'444'

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

  $scope.ipToString = (_ip) ->
    m = _ip.split "."
    x = ""
    _.each m, (item) ->
      t = switch item.length
        when 1 then "00" + item
        when 2 then "0" + item
        else item
      x += t

  $scope.sortings =
    ip: $scope.ipToString
  setTable = () ->
    $scope.title = "Hardware Management"
    $scope.hardwareDetail = ['clientName', 'cpuType', 'diskSN', 'pcSN']
    $scope.hardwareBrief = ['nickname', 'ip', 'MACAddr', 'groupName', 'os', 'pcType']
    

    $scope.hardware = []
    ###
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
  $scope.getTable = () ->
    $timeout setTable, 1000
 
  $scope.getTable()
  ###
  $scope.getFooter = () ->
    $timeout setFooter, 3000
    #setFooter()

  setFooter = () ->
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

  $scope.getFooter()


  $scope.topbarMultiCenter =
    name: '多级中心'
    URL: '#dropdown-ctl-1'
    klass: 'dropdown dropdown3'
    icon: 'fa fa-sitemap'
    fatherCenter:
      name:'父控中心'
      info:
        name:'云子可信_581b2a'
        info:[
          {
            name:'IP地址'
            icon:'fa fa-map-marker fa-icon-mapmark fa-left-icon'
            value:['192.168.2.160:3621']
          }
          {
            name:'控制中心版本'
            icon:'fa fa-sliders fa-icon-mapmark fa-left-icon'
            value:['10.0.0.0000 alpha']
          }
          {
            name:'病毒库版本'
            icon:'icon icon-virus fa-icon-virus fa-left-icon'
            value:['2015.12.21.230(TVL000)']
          }
          {
            name:'主防版本'
            icon:'icon icon-hips fa-icon-hips fa-left-icon'
            value:['2015.12.21.230(TVL000)']
          }
          {
            name:'补丁库版本'
            icon:'icon icon-vul fa-icon-vul fa-left-icon'
            value:['2015.12.21.230(TVL000)','2015.12.21.230(TVL010)','2015.12.21.230(TVL001)']
          }
        ]

    childCenter:
      name:'子控中心'
      info:
        name:'在线状态'
        value:'2/5'
        url:'##'



  $scope.topbarServiceStatus =
    name: '服务状态'
    URL: '#dropdown-ctl-2'
    klass: 'dropdown dropdown3'
    icon: 'fa fa-database'
    subNodes:[
      {
        name: 'elasticsearch'
        icon: 'icon fa-left-icon icon-ture fa-icon-check-circle'
      }
      {
        name: 'redis'
        icon: 'icon fa-left-icon icon-ture fa-icon-check-circle'
      }
      {
        name: 'redisCache'
        icon: 'icon fa-left-icon icon-ture fa-icon-check-circle'
      }
      {
        name: 'web'
        icon: 'icon fa-left-icon icon-ture fa-icon-check-circle'
      }
    ]
    privateCloud:
      name: 'Private Cloud'
      icon: 'icon fa-left-icon icon-ture fa-icon-check-circle'
      info: [
        {
          name:'病毒库版本'
          icon:'icon icon-virus fa-icon-virus fa-left-icon'
          value:['2015.12.21.230(TVL000)']
        }
        {
          name:'主防版本'
          icon:'icon icon-hips fa-icon-hips fa-left-icon'
          value:['2015.12.21.230(TVL000)']
        }
        {
          name:'补丁库版本'
          icon:'icon icon-vul fa-icon-vul fa-left-icon'
          value:['2015.12.21.230(TVL000)','2015.12.21.230(TVL010)','2015.12.21.230(TVL001)']
        }
      ]
    footer:
      info:['控制中心版本:  10.0.15770.0 alpha','终端版本:  10.4.3740.3001']



  $scope.topBarTask =
    name: '任务'
    URL: '#dropdown-ctl-3'
    icon: 'fa fa-tasks'
    klass: 'dropdown dropdown3'
    subnodes:[
      {
        name: '体检'
        URL: '#'
        icon: 'fa fa-bolt fa-icon-bolt fa-left-icon'
        value:10
      }
      {
        name: '升级'
        URL: '#'
        icon: 'fa fa-laptop fa-icon-laptop2 fa-left-icon'
        value:2
      }
      {
        name: '卸载'
        URL: '#'
        icon: 'fa fa-times-circle fa-icon-laptop2 fa-left-icon'
        value:4
      }
    ]

  $scope.topBarVirus =
    name: '病毒'
    URL: '#dropdown-ctl-3'
    icon: 'icon-virus'
    klass: 'dropdown dropdown3'
    subnodes:[
      {
        name: '危险数'
        URL: '#'
        icon: 'fa fa-bolt fa-icon-bolt fa-left-icon'
        value:22
      }
      {
        name: '被感染终端数'
        URL: '#'
        icon: 'fa fa-laptop fa-icon-laptop2 fa-left-icon'
        value:2
      }
    ]

  $scope.topbarItem = [
    user:
      name: 'Edisonqt'
      icon: 'fa fa-user'
      style:
        one: 'user-info'
    logout:
      name: 'LOGOUT'
      icon: 'fa fa-sign-out'
      URL: '#'
      style:
        one: 'header-nav'
        two: 'user-exit'
  ]

  $scope.aside1 =
    frontpage:
      name: '首页'
      URL: '#frontpage'
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

  $scope.aside5 =
    download:
      name: '下载终端'
      URL: '#download'
      icon: ''

  $scope.sidebar = [$scope.aside1, $scope.aside2, $scope.aside3, $scope.aside4, $scope.aside5]

  $scope.wewe =
    xxx:
      name: '你好'
      URL: '#xxx'
      icon: ''
]



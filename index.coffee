app = angular.module 'app', ['OODLib']

app.controller 'appCtrl', ['$scope', ($scope) ->
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
    name: '启明星辰'
    version: '10.0.13980.1'
    status: 'alpha'
    year: '2015'
    website: 'http://alpha.nj.trantect.com/'
    websiteName: '云子可信官网'

]


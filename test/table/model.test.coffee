describe "Create Table model without data", () ->
  m = undefined
  beforeEach () ->
    m = new Table()

  it "init table states", (done) ->
    (expect m).toBeDefined()
    (expect m.rawData).toEqual []
    (expect m.fieldsSample).toEqual {}
    (expect m.fields).toEqual []
    (expect m.detailFields).toEqual []
    (expect m.columnFields).toEqual []
    (expect m.sort).toEqual {}
    (expect m.data).toEqual []
    (expect m.numPerPage).toEqual 2
    (expect m.numPages).toEqual 0
    (expect m.currentPage).toEqual 1
    (expect m.pageRange).toEqual []
    (expect m.from).toEqual 0
    (expect m.to).toEqual 1
    (expect m.currentData).toEqual []
    (expect m.activeDetailIndex).toEqual -1
    done()


  it "toggle detail", (done) ->
    m.toggleDetail 0
    (expect m.activeDetailIndex).toEqual 0
    (expect m.detailDisplayed 0).toBe true
    m.toggleDetail 0
    (expect m.activeDetailIndex).toEqual -1
    (expect m.detailDisplayed 0).toBe false
    done()

describe "Create Table model with data", () ->
  m = data = fieldsSample = fields = undefined
  beforeEach () ->
    data = [
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

    m = new Table data

    fieldsSample = data[0]
    fields = _.keys fieldsSample

  it "init table states", (done) ->
    (expect m.rawData).toEqual data
    (expect m.fieldsSample).toEqual fieldsSample
    (expect m.fields).toEqual fields
    (expect m.columnFields).toEqual fields
    (expect m.detailFields).toEqual fields

    _.each m.sort, (v) ->
      (expect v.fn).toEqual _.identity
      (expect v.order).toEqual 0

    (expect m.numPerPage).toEqual 2
    (expect m.numPages).toEqual 3
    (expect m.currentPage).toEqual 1
    (expect m.pageRange).toEqual [1..3]

    _.each m.data, (v, i) ->
      (expect v.columnData).toEqual m.rawData[i]
      (expect v.detailData).toEqual m.rawData[i]

    (expect m.from).toEqual 0
    (expect m.to).toEqual 1
    _.each m.currentData, (v, i) ->
      (expect v.columnData).toEqual data[i]
      (expect v.detailData).toEqual data[i]
    (expect m.activeDetailIndex).toEqual -1
    done()

  describe "set Titles", () ->
    it "set title replacement", (done) ->
      displayTitles =
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

      m.setTitles displayTitles
      (expect m.titles).toEqual displayTitles
      done()

  describe "set page normal case", () ->
    it "set page", (done) ->
      page = 2
      base = m.numPerPage*(page-1)
      m.setCurrentPage page
      _.each m.currentData, (v, i) ->
        (expect v.columnData).toEqual data[base+i]
        (expect v.detailData).toEqual data[base+i]
      done()


    it "set invalid page: 0", (done) ->
      page = 0
      m.setCurrentPage page
      base = 0
      _.each m.currentData, (v, i) ->
        (expect v.columnData).toEqual data[base+i]
        (expect v.detailData).toEqual data[base+i]
      done()

    it "set invalid page: -1", (done) ->
      page = -1
      m.setCurrentPage page
      base = 0
      _.each m.currentData, (v, i) ->
        (expect v.columnData).toEqual data[base+i]
        (expect v.detailData).toEqual data[base+i]
      done()

    it "set invalid page: 3", (done) ->
      page = 3
      m.setCurrentPage page
      base = 4
      _.each m.currentData, (v, i) ->
        (expect v.columnData).toEqual data[base+i]
        (expect v.detailData).toEqual data[base+i]
      done()

    it "set invalid page: 4", (done) ->
      page = 4
      m.setCurrentPage page
      base = 4
      _.each m.currentData, (v, i) ->
        (expect v.columnData).toEqual data[base+i]
        (expect v.detailData).toEqual data[base+i]
      done()


  describe "set fields", () ->
    it "set Fields", (done) ->
      cfs = ['clientId', 'os']
      dfs = ['ip', 'MACAddr']
      m.setFields cfs, dfs
      (expect m.columnFields).toEqual cfs
      (expect m.detailFields).toEqual dfs

      _.each m.data, (v, i) ->
        (expect v.columnData).toEqual _.pick m.rawData[i], cfs
        (expect v.detailData).toEqual _.pick m.rawData[i], dfs

      done()

  describe "customerize sorting", () ->
    it "setFieldSorting", (done) ->
      (expect m.sort['ip'].fn).toBe _.identity
      mock = (_ip) ->
      m.setFieldSorting 'ip', mock
      (expect m.sort['ip'].fn).toBe mock
      done()

    it "setSortings", (done) ->
      (expect m.sort['ip'].fn).toBe _.identity
      (expect m.sort['os'].fn).toBe _.identity

      mockIp = (_ip) ->
      mockOs = (_os) ->
      o =
        'ip': mockIp
        'os': mockOs
      m.setSortings o
      (expect m.sort['ip'].fn).toBe mockIp
      (expect m.sort['os'].fn).toBe mockOs
      done()



  describe "sorting", () ->
    it "sort", (done) ->
      (expect m.data[0].columnData).toEqual data[0]
      (expect m.data[4].columnData).toEqual data[4]

      m.sortBy 'nickname'
      (expect m.data[0].columnData).toEqual data[3]
      (expect m.data[4].columnData).toEqual data[2]

      m.sortBy 'nickname'
      (expect m.data[0].columnData).toEqual data[2]
      (expect m.data[4].columnData).toEqual data[3]

      done()

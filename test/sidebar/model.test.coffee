describe "Create Sidebar model without data", () ->
  m = undefined
  beforeEach () ->
    m = new Sidebar()

  it "init Sidebar states", (done) ->
    (expect m).toBeDefined()
#    (expect m.val).toEqual() {}
#    (expect m.sectionNodes).toEqual() []
#    (expect m.nodeContent).toEqual() {}
#    (expect m.nodeId).toEqual() ""
#    (expect m.subnodes).toEqual() {}
#    (expect m.nodes).toEqual() {}
    (expect m.states).toEqual {}
    (expect m.expandedKey).toEqual null
    (expect m.activatedKey).toEqual null
    done()
  it "set activeItem",(done) ->
    (expect m.expandedKey).toEqual null
    (expect m.activatedKey).toEqual null
    done()



describe "Create Sidebar model with data", () ->
  m = undefined
  beforeEach () ->
    data = [
      {
      frontpage:
        name: '首页'
        URL: '/'
        icon: 'fa fa-home'
      ,
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
          ,
          terminalSpeedUp:
            name: '终端加速'
            URL: '#terminalSpeedUp'
            icon: 'fa fa-circle-thin fa-1'
        ,
      softwareManagement:
        name: '软件管理'
        URL: '#softwareManagement'
        icon: ''
      }
    ]
    m = new Sidebar data

  it "init Sidebar states", (done) ->
    (expect m.states.frontpage.activation).toEqual INACTIVE
    (expect m.states.terminalManagement.activation).toEqual INACTIVE
    (expect m.states.monitor.activation).toEqual INACTIVE
    (expect m.states.terminalSpeedUp.activation).toEqual INACTIVE
    (expect m.states.softwareManagement.activation).toEqual INACTIVE

    (expect m.states.frontpage.expansion).toEqual undefined
    (expect m.states.terminalManagement.expansion).toEqual 0
    (expect m.states.monitor.expansion).toEqual undefined
    (expect m.states.terminalSpeedUp.expansion).toEqual undefined
    (expect m.states.softwareManagement.expansion).toEqual undefined

    (expect m.states.frontpage.hasChildren).toEqual false
    (expect m.states.terminalManagement.hasChildren).toEqual true
    (expect m.states.monitor.hasChildren).toEqual false
    (expect m.states.terminalSpeedUp.hasChildren).toEqual false
    (expect m.states.softwareManagement.hasChildren).toEqual false

    (expect m.states.frontpage.hasFather).toEqual false
    (expect m.states.terminalManagement.hasFather).toEqual false
    (expect m.states.monitor.hasFather).toEqual "terminalManagement"
    (expect m.states.terminalSpeedUp.hasFather).toEqual "terminalManagement"
    (expect m.states.softwareManagement.hasFather).toEqual false

    (expect m.states.frontpage.id).toEqual "frontpage"
    (expect m.states.terminalManagement.id).toEqual "terminalManagement"
    (expect m.states.monitor.id).toEqual "monitor"
    (expect m.states.terminalSpeedUp.id).toEqual "terminalSpeedUp"
    (expect m.states.softwareManagement.id).toEqual "softwareManagement"

    (expect m.expandedKey).toEqual null
    (expect m.activatedKey).toEqual null
    done()

  it "set activeItem", (done) ->
    m.setStates "softwareManagement"
    (expect m.expandedKey).toEqual null
    (expect m.activatedKey).toEqual "softwareManagement"
    done()



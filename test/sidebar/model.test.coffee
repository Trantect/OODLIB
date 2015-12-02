ACTIVE = 0
INACTIVE = 1

COLLAPSED = 0
EXPANDED = 1


describe "NodeState without data", () ->
  ns = undefined
  beforeEach () ->
    ns = new NodeState()

  it "node state is created", (done) ->
    (expect ns).toBeDefined()
    (expect ns.activate).toBeDefined()
    (expect ns.expand).toBeDefined()
    (expect ns.toggle).toBeDefined()
    (expect ns.id).toBeUndefined()
    (expect ns.hasChildren).toBeUndefined()
    (expect ns.hasFather).toBe false
    (expect ns.expansion).toBeUndefined()
    (expect ns.activation).toBe INACTIVE
    done()

describe "NodeState of no father or children", () ->
  ns = undefined

  it "create one only with id", (done) ->
    ns = new NodeState 'frontend'
    (expect ns).toBeDefined()
    (expect ns.activate).toBeDefined()
    (expect ns.expand).toBeDefined()
    (expect ns.toggle).toBeDefined()
    (expect ns.id).toBe 'frontend'
    (expect ns.hasChildren).toBeUndefined()
    (expect ns.hasFather).toBe false
    (expect ns.expansion).toBeUndefined()
    (expect ns.activation).toBe INACTIVE
    done()

  it "create one with id and empty content", (done) ->
    ns = new NodeState 'frontend', {}
    (expect ns).toBeDefined()
    (expect ns.activate).toBeDefined()
    (expect ns.expand).toBeDefined()
    (expect ns.toggle).toBeDefined()
    (expect ns.id).toBe 'frontend'
    (expect ns.hasChildren).toBe false
    (expect ns.hasFather).toBe false
    (expect ns.expansion).toBeUndefined
    (expect ns.activation).toBe INACTIVE
    done()

  it "activate", (done) ->
    ns = new NodeState 'virus', {}
    (expect ns.expansion).toBeUndefined
    (expect ns.activation).toBe INACTIVE
    [AK, EK] = ns.activate()
    (expect ns.activation).toBe ACTIVE
    (expect ns.expansion).toBeUndefined
    (expect AK).toBe ns.id
    (expect EK).toBeUndefined
    done()

  it "expand", (done) ->
    ns = new NodeState 'virus', {}
    (expect ns.expansion).toBeUndefined
    ns.expand()
    (expect ns.expansion).toBeUndefined
    done()

  it "toggle", (done) ->
    ns = new NodeState 'virus', {}
    (expect ns.expansion).toBeUndefined
    ns.toggle()
    (expect ns.expansion).toBeUndefined
    done()


describe "NodeState which has no father but children", () ->
  ns = undefined
  beforeEach () ->
    ns = new NodeState "security", {subnodes:{}}

  it "create with id and content with subnodes", (done) ->
    (expect ns).toBeDefined()
    (expect ns.id).toBe 'security'
    (expect ns.hasChildren).toBe true
    (expect ns.hasFather).toBe false
    (expect ns.expansion).toBe COLLAPSED
    (expect ns.activation).toBe INACTIVE
    done()

  it "activate", (done) ->
    (expect ns.expansion).toBeUndefined
    (expect ns.activation).toBe INACTIVE
    [AK, EK] = ns.activate()
    (expect ns.activation).toBe INACTIVE
    (expect ns.expansion).toBe EXPANDED
    (expect EK).toBe ns.id
    (expect AK).toBeUndefined
    [AK, EK] = ns.activate()
    (expect ns.activation).toBe INACTIVE
    (expect ns.expansion).toBe COLLAPSED
    (expect EK).toBeUndefined
    (expect AK).toBeUndefined

    done()

  it "expand", (done) ->
    (expect ns.expansion).toBe COLLAPSED
    ns.expand()
    (expect ns.expansion).toBe EXPANDED
    done()

  it "toggle", (done) ->
    (expect ns.expansion).toBe COLLAPSED
    ns.toggle()
    (expect ns.expansion).toBe EXPANDED
    ns.toggle()
    (expect ns.expansion).toBe COLLAPSED
    done()

describe "NodeState which has father but no children", () ->
  ns = undefined
  beforeEach () ->
    ns = new NodeState "virus", {}, "security"

  it "create with id, content, and father id", (done) ->
    (expect ns).toBeDefined()
    (expect ns.id).toBe 'virus'
    (expect ns.hasChildren).toBe false
    (expect ns.hasFather).toBe 'security'
    (expect ns.expansion).toBeUndefined
    (expect ns.activation).toBe INACTIVE
    done()

  it "activate", (done) ->
    (expect ns.expansion).toBeUndefined
    (expect ns.activation).toBe INACTIVE
    [AK, EK] = ns.activate()
    (expect ns.activation).toBe ACTIVE
    (expect ns.expansion).toBeUndefined
    (expect EK).toBe ns.hasFather
    (expect AK).toBe ns.id
    [AK, EK] = ns.activate()
    (expect ns.activation).toBe ACTIVE
    (expect ns.expansion).toBeUndefined
    (expect EK).toBe ns.hasFather
    (expect AK).toBe ns.id

    done()

  it "expand", (done) ->
    (expect ns.expansion).toBeUndefined
    ns.expand()
    (expect ns.expansion).toBeUndefined
    done()

  it "toggle", (done) ->
    (expect ns.expansion).toBeUndefined
    ns.toggle()
    (expect ns.expansion).toBeUndefined
    ns.toggle()
    (expect ns.expansion).toBeUndefined
    done()

describe "merge", () ->
  _L = undefined

  it "The array is undefined", (done) ->
    r = merge _L
    (expect r).toEqual {}
    done()

  it "The array is an empty", (done) ->
    _L = []
    r = merge _L
    (expect r).toEqual {}
    done()

  it "The array is an empty", (done) ->
    _L = [
      name: 'phoenix'
      age: 22
    ,
      university: 'TU Dresden'
      degree: 'Master'
    ,
      hobby: 'paragliding'
    ,
      occupation: 'Engineer'
    ]
    expectR =
      name: 'phoenix'
      age: 22
      university: 'TU Dresden'
      degree: 'Master'
      hobby: 'paragliding'
      occupation: 'Engineer'

    r = merge _L
    (expect r).toEqual expectR
    done()


describe "Create Sidebar model without data", () ->
  m = undefined
  beforeEach () ->
    m = new Sidebar()

  it "init Sidebar states", (done) ->
    (expect m).toBeDefined()
    (expect m.states).toEqual {}
    (expect m.setStates).toBeDefined()
    done()

  it "setStates", (done) ->
    (expect () ->
      m.setStates()
    ).not.toThrowError()
    done()
      
  it "set user", (done) ->
    (expect m.user).toBeUndefined()
    m.setUser()
    (expect m.user).toBe 'anonymous'
    done()

  it "set user", (done) ->
    (expect m.user).toBeUndefined()
    m.setUser 'Jane Don'
    (expect m.user).toBe 'Jane Don'
    done()



describe "Create Sidebar model with data", () ->
  m = undefined
  beforeEach () ->
    data = [
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
    ]
    m = new Sidebar data
    

  it "init Sidebar states", (done) ->
    frontpageState = m.states.frontpage
    terminalState = m.states.terminalManagement
    monitorState = m.states.monitor
    speedUpState = m.states.terminalSpeedUp
    softwareState = m.states.softwareManagement
    (expect frontpageState.activation).toEqual INACTIVE
    (expect terminalState.activation).toEqual INACTIVE
    (expect monitorState.activation).toEqual INACTIVE
    (expect speedUpState.activation).toEqual INACTIVE
    (expect softwareState.activation).toEqual INACTIVE

    (expect frontpageState.expansion).toEqual undefined
    (expect terminalState.expansion).toEqual COLLAPSED
    (expect monitorState.expansion).toEqual undefined
    (expect speedUpState.expansion).toEqual undefined
    (expect softwareState.expansion).toEqual undefined

    (expect frontpageState.hasChildren).toEqual false
    (expect terminalState.hasChildren).toEqual true
    (expect monitorState.hasChildren).toEqual false
    (expect speedUpState.hasChildren).toEqual false
    (expect softwareState.hasChildren).toEqual false

    (expect frontpageState.hasFather).toEqual false
    (expect terminalState.hasFather).toEqual false
    (expect monitorState.hasFather).toEqual "terminalManagement"
    (expect speedUpState.hasFather).toEqual "terminalManagement"
    (expect softwareState.hasFather).toEqual false

    (expect frontpageState.id).toEqual "frontpage"
    (expect terminalState.id).toEqual "terminalManagement"
    (expect monitorState.id).toEqual "monitor"
    (expect speedUpState.id).toEqual "terminalSpeedUp"
    (expect softwareState.id).toEqual "softwareManagement"

    done()

  it "set state on a node, which has no children or father", (done) ->
    m.setStates "softwareManagement"
    softwareState = m.states.softwareManagement
    (expect softwareState.activation).toBe ACTIVE
    (expect softwareState.expansion).toBeUndefined()


    m.setStates "frontpage"
    frontpageState = m.states.frontpage
    (expect frontpageState.activation).toBe ACTIVE
    (expect frontpageState.expansion).toBeUndefined

    done()


  it "toggle on a node, which has children but no father", (done) ->
    terminalState = m.states.terminalManagement
    (expect terminalState.activation).toBe INACTIVE
    (expect terminalState.expansion).toBe COLLAPSED
    m.toggle "terminalManagement"
    (expect terminalState.activation).toBe INACTIVE
    (expect terminalState.expansion).toBe EXPANDED
    done()

  it "set state on a node, which has no children but father", (done) ->
    monitorState = m.states.monitor
    terminalState = m.states.terminalManagement
    (expect monitorState.activation).toBe INACTIVE
    (expect monitorState.expansion).toBeUndefined()
    (expect terminalState.activation).toBe INACTIVE
    (expect terminalState.expansion).toBe COLLAPSED
    m.setStates "monitor"
    (expect monitorState.activation).toBe ACTIVE
    (expect monitorState.expansion).toBeUndefined()
    done()

  it "set user", (done) ->
    (expect m.user).toBeUndefined()
    m.setUser()
    (expect m.user).toBe 'anonymous'
    done()

  it "set user", (done) ->
    (expect m.user).toBeUndefined()
    m.setUser 'Jane Don'
    (expect m.user).toBe 'Jane Don'
    done()



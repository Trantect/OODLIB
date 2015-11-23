describe "Sidebar Css Manager Test", () ->

  ACTIVE = 0
  INACTIVE = 1

  COLLAPSED = 0
  EXPANDED = 1

  it "With defined methods", (done) ->
    (expect SidebarCssManager.getState).toBeDefined()
    (expect SidebarCssManager.getExpansion).toBeDefined()
    (expect SidebarCssManager.expanded).toBeDefined()
    done()
    
  it "getState", (done) ->
    state = SidebarCssManager.getState ACTIVE
    (expect state).toEqual 'is-active'

    state = SidebarCssManager.getState INACTIVE
    (expect state).toEqual ''
    done()


  it "getExpansion", (done) ->
    state = SidebarCssManager.getExpansion COLLAPSED
    (expect state).toEqual 'fa fa-angle-down'

    state = SidebarCssManager.getExpansion EXPANDED
    (expect state).toEqual 'fa fa-angle-up'

    state = SidebarCssManager.getExpansion 'abc'
    (expect state).toEqual ''

    done()

  it "expanded", (done) ->
    state = SidebarCssManager.expanded COLLAPSED
    (expect state).toEqual false

    state = SidebarCssManager.expanded EXPANDED
    (expect state).toEqual true

    state = SidebarCssManager.expanded 'abc'
    (expect state).toEqual ''

    done()



describe "Table Css Manager Test", () ->

  it "With defined methods", (done) ->
    (expect TableCssManager.brief).toBeDefined()
    (expect TableCssManager.detail).toBeDefined()
    (expect TableCssManager.td).toBeDefined()
    (expect TableCssManager.cell).toBeDefined()
    (expect TableCssManager.pageState).toBeDefined()
    (expect TableCssManager.prevPageState).toBeDefined()
    (expect TableCssManager.nextPageState).toBeDefined()
    done()
    
  it "pageState", (done) ->
    state = TableCssManager.pageState 2, 2
    (expect state).toEqual 'is-active'

    state = TableCssManager.pageState 2, 1
    (expect state).toEqual undefined
    done()


  it "prevPageState", (done) ->
    state = TableCssManager.prevPageState 1
    (expect state).toEqual 'is-disabled'

    state = TableCssManager.prevPageState 10
    (expect state).toEqual undefined
    done()

  it "pageState", (done) ->
    state = TableCssManager.nextPageState 10, 10
    (expect state).toEqual 'is-disabled'

    state = TableCssManager.nextPageState 3, 10
    (expect state).toEqual undefined
    done()



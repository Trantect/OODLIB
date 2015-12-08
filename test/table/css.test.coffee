describe "Table Css Manager Test", () ->
  TCM = TableCssManager
  it "can be instantiated", (done) ->
    tcm = new TCM()
    (expect tcm).toBeDefined()
    done()

  it "With defined methods", (done) ->
    (expect TCM.brief).toBeDefined()
    (expect TCM.detail).toBeDefined()
    (expect TCM.td).toBeDefined()
    (expect TCM.cell).toBeDefined()
    (expect TCM.cellIcon).toBeDefined()
    (expect TCM.cellContent).toBeDefined()
    (expect TCM.sortState).toBeDefined()

    (expect TCM.pageState).toBeDefined()
    (expect TCM.prevPageState).toBeDefined()
    (expect TCM.nextPageState).toBeDefined()
    done()
    
  it "empty functions", (done) ->
    (expect TCM.brief).not.toThrowError()
    (expect TCM.detail).not.toThrowError()
    (expect TCM.td).not.toThrowError()
    (expect TCM.cell).not.toThrowError()
    (expect TCM.cellIcon).not.toThrowError()
    (expect TCM.cellContent).not.toThrowError()
    done()


  it "sortState", (done) ->
    state = TCM.sortState -1
    (expect state).toEqual 'fa fa-sort-up'

    state = TCM.sortState 1
    (expect state).toEqual 'fa fa-sort-down'

    state = TCM.sortState 0
    (expect state).toEqual 'fa fa-sort'

    state = TCM.sortState()
    (expect state).toEqual ''

    done()


  it "pageState", (done) ->
    state = TCM.pageState 2, 2
    (expect state).toEqual 'is-active'

    state = TCM.pageState 2, 1
    (expect state).toEqual undefined
    done()


  it "prevPageState", (done) ->
    state = TCM.prevPageState 1
    (expect state).toEqual 'is-disabled'

    state = TCM.prevPageState 10
    (expect state).toEqual undefined
    done()

  it "pageState", (done) ->
    state = TCM.nextPageState 10, 10
    (expect state).toEqual 'is-disabled'

    state = TCM.nextPageState 3, 10
    (expect state).toEqual undefined
    done()



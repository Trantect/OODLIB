describe "Create Sidebar model without data", () ->
  m = undefined
  beforeEach () ->
    m = new Sidebar()

  it "init Sidebar states", (done) ->
    (expect m).toBeDefined()
    done()



describe "Create Sidebar model with data", () ->
  beforeEach () ->
    data = []

    m = new Sidebar data


  it "init Sidebar states", (done) ->
    done()

  it "set activeItem", (done) ->
    done()



describe "Table model Test", () ->
  it "Create Table Model", (done) ->
    tm = new Table()
    (expect tm).toBeDefined()
    done()
    


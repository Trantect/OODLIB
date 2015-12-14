describe "CssManager Test", () ->
  it "Create CssManager instance without arguments", (done) ->
    d = new CssManager()
    (expect d).toBeDefined()
    done()
    


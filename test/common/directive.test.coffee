describe "Directive Test", () ->
  it "Create Directive instance without arguments", (done) ->
    d = new Directive()
    (expect d).toBeDefined()
    (expect d.modelKlass).toBe Model

    params =
      restrict: 'E'
      templateUrl: ''
      scope:
        storage: "=info"
    (expect d.params).toBeDefined()
    (expect d.params).toEqual jasmine.objectContaining params
    done()
    

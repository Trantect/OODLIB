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


    (expect d.ui instanceof UI).toBe true
    (expect d.ui.config).toEqual {}
    (expect d.ui.handlers).toEqual {}
    done()
    

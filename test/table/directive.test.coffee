describe "Directive Test", () ->
  it "Create Directive instance without arguments", (done) ->
    d = new TableDirective()
    (expect d).toBeDefined()
    (expect d.modelKlass).toBe Table
    (expect d.cssKlass).toBe TableCssManager

    params =
      restrict: 'E'
      templateUrl: 'lib/components/table/table.html'
      scope:
        cFields: '=cFields'
        dFields: '=dFields'
        numPerPage: '=numPerPage'
        storage: "=info"
        titles: '=titles'
        cssManager: '='
        sortings: '='
    (expect d.params).toBeDefined()
    (expect d.params).toEqual jasmine.objectContaining params
    (expect d.params.link).toBeDefined()
    done()

  it "Create Directive instance with arguments", (done) ->
    d = new TableDirective {}, TableCssManager
    (expect d).toBeDefined()
    (expect d.modelKlass).toBe Table
    (expect d.cssKlass).toBe TableCssManager

    params =
      restrict: 'E'
      templateUrl: 'lib/components/table/table.html'
      scope:
        cFields: '=cFields'
        dFields: '=dFields'
        numPerPage: '=numPerPage'
        storage: "=info"
        titles: '=titles'
        cssManager: '='
        sortings: '='
    (expect d.params).toBeDefined()
    (expect d.params).toEqual jasmine.objectContaining params
    (expect d.params.link).toBeDefined()
    done()

describe 'footer directive', () ->
  it 'create footer directive instance without arguments', (done) ->
      f = new FooterDirective()
      (expect f).toBeDefined()
      (expect f.modelKlass).toBe Footer
      (expect f.cssKlass).toBe FooterCssManager

      params =
        restrict: 'E'
        templateUrl: 'lib/components/footer/footer.html'
        scope:
          storage: '=info'
          cssManager: '='

      (expect f.params).toBeDefined
      (expect f.params).toEqual jasmine.objectContaining params
      done()

    it 'create footer directive instance with arguments', (done) ->
      params =
        restrict: 'E'
        templateUrl: 'lib/footer/footer.html'
        scope:
          storage: '=info'
          cssManager: '='
      f = new FooterDirective(params)
      (expect f).toBeDefined()
      (expect f.modelKlass).toBe Footer
      (expect f.cssKlass).toBe FooterCssManager
      (expect f.params).toEqual jasmine.objectContaining params
      done()

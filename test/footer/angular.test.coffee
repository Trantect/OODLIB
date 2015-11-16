describe 'footer directive without args', () ->
  tester = angular.module 'tester', []
  f = new FooterDirective()
  DirectiveSchool.register tester, 'cfooter', f

  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach module 'lib/footer/footer.html'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  it 'is used without info', (done) ->
    element = ($compile '<cfooter></cfooter>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeUndefined()
    done()

  it 'is used with info', (done) ->
    $scope.company =
      name: 'Demo'
      version: '0.0.1'
      status: 'alpha'
      year: '2015'
      website: 'http://www.trantect.com/'
      websiteName: 'our site'
    element = ($compile '<cfooter info="company"></cfooter>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeDefined()
    (expect eScope.storage).toEqual $scope.company
    (expect element.html()).toContain '<footer>'
    done()

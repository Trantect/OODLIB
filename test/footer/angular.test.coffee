describe 'use footer directive without info', () ->
  tester = angular.module 'tester', []
  f = new FooterDirective()
  DirectiveSchool.register tester, 'cfooter', f

  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach module 'lib/footer/footer.html'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  it 'should not get the info', (done) ->
    $scope.company = {}
    element = ($compile '<cfooter></cfooter>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeUndefined()
    contents = element.find('span')
    #(expect contents.eq(0).text()).toBe 'Copyright © EMPTY copyright|Version: EMPTY version'
    #(expect contents.eq(1).text()).toBe ''
    done()

describe 'use footer directive with info', () ->
  tester = angular.module 'tester', []
  f = new FooterDirective()
  DirectiveSchool.register tester, 'cfooter', f

  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach module 'lib/footer/footer.html'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  beforeEach () ->
    $scope.company =
      copyright: '2015 Demo'
      version: '0.0.1 alpha'
      websites: [
        'our site':'http://www.trantect.com'
      ,
        'our site':'http://www.trantect.com'
      ,
        'help': 'http://help.trantect.com'
      ,
        'link': '#'
      ,
        '世界': "http://www.sina.com"
      ]
    element = ($compile '<cfooter info="company"></cfooter>') $scope
    $scope.$digest()
    eScope = element.isolateScope()

    it 'should get the info', (done) ->
      (expect _.has eScope, 'storage').toBe true
      (expect eScope.storage).toBeDefined()
      (expect eScope.storage).toEqual $scope.company
      done()

    it 'should show the info', (done) ->
      contents = element.find('span')
      (expect contents.eq(0).text()).toBe 'Copyright © 2015 Demo | Version: 0.0.1 alpha'
      anotherContents = element.find('a')
      (expect anotherContents.length).toEqual 5
      (expect anotherContents.eq(0).text().trim()).toBe 'our site'
      (expect anotherContents.eq(1).text().trim()).toBe 'our site'
      (expect anotherContents.eq(2).text().trim()).toBe 'help'
      (expect anotherContents.eq(3).text().trim()).toBe 'link'
      (expect anotherContents.eq(4).text().trim()).toBe '世界'
      done()

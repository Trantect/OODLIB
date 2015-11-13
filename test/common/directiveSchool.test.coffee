describe "DirectiveSchool Test", () ->
  it "DirectiveSchool is defined", (done) ->
    (expect DirectiveSchool.register).toBeDefined()
    done()

  it "DirectiveSchool can be inited", (done) ->
    ds = new DirectiveSchool()
    (expect ds).toBeDefined()
    done()

describe "Test angular directive without args", () ->
  tester = angular.module 'tester', []
  d = new Directive()
  DirectiveSchool.register tester, 'testdirective', d
    
  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  it "directive is used without info", (done) ->
    element = ($compile '<testdirective></testdirective>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeUndefined()
    done()

  it "directive is used with info", (done) ->
    $scope.student =
      name: 'Billy'
      age: '21'
    element = ($compile '<testdirective info="student"></testdirective>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeDefined()
    (expect eScope.storage).toEqual $scope.student
    done()

describe "Test angular directive with args: template", () ->
  tester = angular.module 'tester', []
  params =
    template: '<p ng-bind="model.data.name"></p><p ng-bind="model.data.age"></p>'
  d = new Directive params
  DirectiveSchool.register tester, 'testdirective', d
    
  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  it "directive is used without info", (done) ->
    element = ($compile '<testdirective></testdirective>') $scope
    $scope.$digest()
    (expect element.html()).toContain '</p>'
    done()

  it "directive is used with info", (done) ->
    $scope.student =
      name: 'Billy'
      age: '21'
    element = ($compile '<testdirective info="student"></testdirective>') $scope
    $scope.$digest()
    (expect element.html()).toContain 'Billy'
    (expect element.html()).toContain '21'
    done()

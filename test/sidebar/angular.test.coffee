describe "Test Sidebar directive without args", () ->
  tester = angular.module 'tester', []
  d = new SidebarDirective()
  DirectiveSchool.register tester, 'csidebar', d

  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach module 'lib/components/sidebar/sidebar.html'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  
  it "directive is used without info", (done) ->
    element = ($compile '<csidebar></csidebar>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeUndefined()
    done()

  ###
  it "directive is used with info", (done) ->
    $scope.students = [
      name: 'Billy'
      age: '21'
    ,
      name: 'Alex'
      age: '19'
    ]

    element = ($compile '<csidebar info="students"></csidebar>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeDefined()
    (expect eScope.storage).toEqual $scope.students
    (expect element.html()).toContain '</sidebar>'
    done()
  ###

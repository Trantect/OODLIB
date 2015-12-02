describe "Test table directive without args", () ->
  tester = angular.module 'tester', []
  d = new TableDirective()
  DirectiveSchool.register tester, 'ctable', d

  $compile = $scope = undefined

  beforeEach module 'tester'

  beforeEach module 'lib/table/table.html'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $scope = _$rootScope_.$new()

  
  it "directive is used without info", (done) ->
    element = ($compile '<ctable></ctable>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeUndefined()
    done()


  it "directive is used with info", (done) ->
    $scope.students = [
      name: 'Billy'
      age: '21'
    ,
      name: 'Alex'
      age: '19'
    ]

    element = ($compile '<ctable info="students"></ctable>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeDefined()
    (expect eScope.storage).toEqual $scope.students
    (expect element.html()).toContain '</table>'
    done()

  it "directive is used with info and cField, dField", (done) ->
    $scope.persons = [
      name: 'Billy'
      age: '21'
      occupation: 'Teacher'
      hobby: 'talking'
    ,
      name: 'Alex'
      age: '19'
      occupation: 'Student'
      hobby: 'sleeping'
    ]

    $scope.col = ['name', 'age']
    $scope.detail = ['occupation', 'hobby']

    element = ($compile '<ctable info="persons" c-fields="col" d-fields="detail"></ctable>') $scope
    $scope.$digest()
    eScope = element.isolateScope()
    (expect _.has eScope, 'storage').toBe true
    (expect eScope.storage).toBeDefined()
    (expect eScope.storage).toEqual $scope.persons
    (expect element.html()).toContain '</table>'
    done()

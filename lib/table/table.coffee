lib = angular.module "OODLib", []

class Table
  constructor: (data) ->
    @updateTable data
    @

  updateTable: (data) ->
    @data = data
    @fileds = _.keys @data[0]||[]
    @sort = _.mapObject @data[0]||{}, (_f) ->
      _.identity
    @numPerPage = 10
    @numPages = Math.ceil @data.length / @numPerPage
    @currentPage = 1
    @pageRange = if @numPages == 0 then [] else [1..@numPages]
    @getCurrentData()

  getCurrentData: () ->
    @from = (@currentPage-1) * @numPerPage
    @to = @from + @numPerPage - 1
    @currentData = @data[@from..@to]

  setCurrentPage: (page) ->
    @currentPage = page
    @getCurrentData()


  
tableConfig =
  templateUrl: 'build/table/table.html'
  scope:
    storage: '=info'
  events:
    tr:
      'click': 'displayDetail'
      'mouseover': 'displayOptionButtons'
    th:
      'click': 'sorting'

d = new Directive tableConfig, Table
DirectiveSchool.register lib, 'ctable', d
d.handlers['displayDetail'] = () ->
  table = d.scope.model
  table.setCurrentPage 2
  d.scope.storage = table.currentData
  d.scope.$apply()
  d.scope.storage = [
    company: 'trantect'
    age: '3'
  ,
    company: 'shanbay'
    age: '2'
  ]
  d.scope.$apply()
  console.log table.data
  console.log "hello world"
 



    

    


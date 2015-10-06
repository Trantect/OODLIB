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
  console.log "hello world"
 



    

    


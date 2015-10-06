lib = angular.module "OODLib", []

   
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
  options:
    caption: 'admin'
    pagination: false

d = new Directive tableConfig
DirectiveSchool.register lib, 'ctable', d
   


class Table
  constructor: (@data) ->
    @fileds = _.keys @data[0]
    @sort = _.mapObject @data[0], (_f) ->
      _.identity
    @numPerPage = 10
    @numPages = @data.length / @numPerPage
    @currentPage = 1
    @getCurrentData()

  getCurrentData: () ->
    @from = (@currentPage-1) * @numPerPage
    @to = @from + @numPerPage - 1
    @currentData = @data[@from..@to]



    

    


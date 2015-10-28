getScriptDir = () ->
  scripts = document.getElementsByTagName("script")
  csp = scripts[scripts.length-1].src
  csp = csp.substring(0, csp.lastIndexOf('/') + 1)
  csp

directiveDir = getScriptDir()

###
To define a table model
@extend Model
###
class Table extends Model
  ###
  To construct an instance of table model
  @param data [Array<Dict>] data to be displayed in table
  ###
  constructor: (data) ->
    @updateTable data
    @

  ###
  To update table model by data
  @param data [Array<Dict>] data to be displayed in table
  ###
  updateTable: (data) ->
    @data = data
    @fields = _.keys @data[0]||[]
    @sort = _.mapObject @data[0]||{}, (_f) ->
      _.identity
    @numPerPage = 2
    @numPages = Math.ceil @data.length / @numPerPage
    @currentPage = 1
    @pageRange = if @numPages == 0 then [] else [1..@numPages]
    @getCurrentData()

  ###
  To get data by current page
  ###
  getCurrentData: () ->
    @from = (@currentPage-1) * @numPerPage
    @to = @from + @numPerPage - 1
    @currentData = @data[@from..@to]

  ###
  To set current page and update data by current page
  ###
  setCurrentPage: (page) ->
    @currentPage = page
    @getCurrentData()

###
To define table directive
@extend Directive
###
class TableDirective extends Directive
  ###
  Construct an instance of TableDirective
  @param params [Dict] parameters of angular directive
  @param uiConfig [Array<Dict>] configuration of ui service
  ###
  constructor: (params, uiConfig) ->
    params = params ? {}
    tableParams =
      templateUrl: directiveDir + 'table.html'
      scope:
        storage: '=info'
    _.extend params, tableParams
    super params, Table, new UI uiConfig

this.TableDirective = TableDirective

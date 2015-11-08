directiveDir = 'build/table/'


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
    @rawData = data
    @initFields()
    @initSorting()

    @setTableData()
    @setPagination()
    @getCurrentData()

  initSorting: () ->
    @sort = _.mapObject @rawData[0]||{}, (_f) ->
      s =
        fn: _.identity
        order: 0

  setPagination: (currentPage, numberPerPage) ->
    @numPerPage = numberPerPage ? 2
    @numPages = Math.ceil @data.length / @numPerPage
    @currentPage = currentPage ? 1
    @pageRange = if @numPages == 0 then [] else [1..@numPages]


  initFields: () ->
    @fields = @detailFields = @columnFields = _.keys @rawData[0]||[]

  ###
  To get data by current page
  ###
  getCurrentData: () ->
    @from = (@currentPage-1) * @numPerPage
    @to = @from + @numPerPage - 1
    @currentData = @data[@from..@to]
    @activeIndex = -1

  setCaption: (caption) ->
    @caption = caption ? "Table"

  setTableData: () ->
    @data = _.map @rawData, (d) =>
      tmp = {}
      tmp.columnData = _.pick d, @columnFields
      tmp.detailData = _.pick d, @detailFields
      tmp

  resetOrder: (field) ->
    _.each @sort, (v, k) ->
      console.log v, k
      if k!=field
        v.order = 0
  ###
  To sort table data
  ###
  sortBy: (field) ->
    currentOrder = @sort[field].order
    order = if currentOrder==0 then -1 else -currentOrder
    console.log "order", order
    @rawData = _.sortBy @rawData, (d) =>
      (@sort[field].fn d[field])
    @rawData.reverse() if order == -1
    @sort[field].order = order
    @resetOrder field
    @setTableData()
    @getCurrentData()

  ###
  To set current page and update data by current page
  ###
  setCurrentPage: (page) ->
    @setPagination page, @numPerPage
    @getCurrentData()

  setFields: (cFields, dFields) ->
    @columnFields = _.intersection cFields, @fields
    @detailFields = _.intersection dFields, @fields
    @setTableData()
    @getCurrentData()


  ###
  To verify whether displaying detail
  ###
  detailDisplayed: (_index) ->
    _index == @activeIndex

  toggleActive: (_index) ->
    @activeIndex = if @activeIndex!=_index then _index else -1

###
To define table css manager
@extend CssManager
###
class TableCssManager extends CssManager

  @brief: (item) ->

  @detail: (item) ->

  @td: (item) ->

  @cell: (key, value) ->

  @pageState: (actived, i) ->
    v = if actived==i then 'is-active'

  @prevPageState: (actived) ->
    v = if actived==1 then 'is-disabled'

  @nextPageState: (actived, last) ->
    v = if actived==last then 'is-disabled'


###
To define table directive
@extend Directive
###
class TableDirective extends Directive
  ###
  Construct an instance of TableDirective
  @param params [Dict] parameters of angular directive
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? TableCssManager
    tableParams =
      templateUrl: directiveDir + 'table.html'
      scope:
        cFields: '=cFields'
        dFields: '=dFields'
        numPerPage: '=numPerPage'
        caption: '=caption'
    _.extend params, tableParams
    super params, Table, cssKlass


  linkFn: (scope, element, attr) ->
    super scope, element, attr
    scope.model.setPagination 1, scope.numPerPage
    console.log "caption", scope.caption
    scope.model.setCaption scope.caption
    scope.cFields = scope.cFields ? scope.model.fields
    scope.dFields = scope.dFields ? scope.model.fields
    scope.model.setFields scope.cFields, scope.dFields

this.TableDirective = TableDirective
this.TableCssManager = TableCssManager

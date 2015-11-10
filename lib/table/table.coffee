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
  constructor: (rawData) ->
    @rawData = rawData ? []
    @initTable()

  ###
  To update table model by data
  @param data [Array<Dict>] data to be displayed in table
  ###
  initTable: () ->
    @initFields()
    @initSorting()

    @setPagination()
    @updateTableData()
    @updateCurrentPage()

  ###
  To initialize table fields, including all fields, fields displayed in column, displayed in detail
  ###
  initFields: () ->
    @fieldsSample = if _.has @rawData, '0' then @rawData[0] else {}
    @fields = @detailFields = @columnFields = _.keys @fieldsSample


  ###
  To initialize sorting statuses and functions
  ###
  initSorting: () ->
    @sort = _.mapObject @fieldsSample, (_f) ->
      s =
        fn: _.identity
        order: 0

  ###
  To set table data by columnFields and detailFields
  ###
  updateTableData: () ->
    @data = _.map @rawData, (d) =>
      tmp = {}
      tmp.columnData = _.pick d, @columnFields
      tmp.detailData = _.pick d, @detailFields
      tmp


  ###
  To set pagination
  @param currentPage [number]
  @param numberPerPage [number] number of records per page
  ###
  setPagination: (currentPage, numberPerPage) ->
    @numPerPage = numberPerPage ? 2
    @numPages = Math.ceil @rawData.length / @numPerPage
    @currentPage = currentPage ? 1
    @pageRange = if @numPages == 0 then [] else [1..@numPages]


  ###
  To get data by current page
  ###
  updateCurrentPage: () ->
    @from = (@currentPage-1) * @numPerPage
    @to = @from + @numPerPage - 1
    @currentData = @data[@from..@to]
    @activeDetailIndex = -1

  ###
  To set table caption
  @param caption [string] default 'Table'
  ###
  setCaption: (caption) ->
    @caption = caption ? "Table"

  ###
  To reset order status by field
  @param field [string] field the data is sorted by
  @param order [number] enum: -1(des), 0(no ordered), 1(asc)
  ###
  resetOrder: (field, order) ->
    _.each @sort, (v, k) ->
      if k!=field
        v.order = 0
      else
        v.order = order

  ###
  To sort table data by field
  @param field [string] field the data is sorted by
  ###
  sortBy: (field) ->
    currentOrder = @sort[field].order
    order = if currentOrder==0 then -1 else -currentOrder
    @rawData = _.sortBy @rawData, (d) =>
      (@sort[field].fn d[field])
    @rawData.reverse() if order == -1
    @resetOrder field, order
    @updateTableData()
    @updateCurrentPage()

  ###
  To set current page and update data by current page
  @param page [number] current page
  ###
  setCurrentPage: (page) ->
    if page <= 0
      page = 1
    else if page >= @numPages
      page = @numPages
    @setPagination page, @numPerPage
    @updateCurrentPage()

  ###
  To set column fields, detail fields
  @param cFields [Array<string>] column fields
  @param dFields [Array<string>] detail fields
  ###
  setFields: (cFields, dFields) ->
    @columnFields = _.intersection cFields, @fields
    @detailFields = _.intersection dFields, @fields
    @updateTableData()
    @updateCurrentPage()


  ###
  To toggle detail
  @param _index [number] index of record whose detail is to be displayed
  ###
  toggleDetail: (_index) ->
    @activeDetailIndex = if @activeDetailIndex!=_index then _index else -1


  ###
  Check whether detail of record by index should be displayed
  @param _index [number] index of record to be judged
  ###
  detailDisplayed: (_index) ->
    _index == @activeDetailIndex


###
To define table css manager
@extend CssManager
###
class TableCssManager extends CssManager

  ###
  table tr style 
  ###
  @brief: (item) ->

  ###
  row detail style
  ###
  @detail: (item) ->

  ###
  table td style 
  ###
  @td: (item) ->

  ###
  table cell style
  ###
  @cellContent: (key, value) ->

  ###
  cell icon
  ###
  @cellIcon: (key, vaule) ->
    icon = switch key
      when 'nickname' then 'fa fa-desktop'
      when 'groupName' then 'fa fa-client-group'
      else 'hide'
  
  ###
  td with background
  ###
  @cell: (key, value) ->
    bg = switch
      when key=='nickname' or key=='groupName' then 'td-icon'
      else ''

  ###
  sort order
  ###
  @sortState: (sortMap, sortedField) ->
    switch sortMap[sortedField].order
      when -1 then "fa-sort-up"
      when 1 then "fa-sort-down"
      else "fa-sort"
  
  ###
  page index style
  ###
  @pageState: (actived, i) ->
    v = switch
      when actived==i then 'is-active'
      else ''

  ###
  pagination prev style
  ###
  @prevPageState: (actived) ->
    v = switch
      when actived==1 then 'is-disabled'
      else ''

  ###
  #pagination next style
  ###
  @nextPageState: (actived, last) ->
    v = switch
      when actived==last then 'is-disabled'
      else ''


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


  ###
  To initialize link function of table directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr
    scope.model.setPagination 1, scope.numPerPage
    scope.model.setCaption scope.caption
    scope.cFields = scope.cFields ? scope.model.fields
    scope.dFields = scope.dFields ? scope.model.fields
    scope.model.setFields scope.cFields, scope.dFields

this.TableDirective = TableDirective
this.TableCssManager = TableCssManager

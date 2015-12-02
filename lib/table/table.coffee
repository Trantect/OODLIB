directiveDir = 'lib/table/'

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
  Set Title Display
  @param titles [Object] title representation
  ###
  setTitles: (titles) ->
    @titles = _.mapObject @fieldsSample, (v, k) ->
      t = (titles and titles[k]) ? k

  ###
  get Title Display
  @param t [String] title key
  ###
  getTitle: (t) ->
    @titles[t]

  ###
  get sort order by sorting key
  @param _f [String] sorting key
  ###
  getSortOrder: (_f) ->
    @sort[_f].order

  ###
  To toggle detail
  @param _index [number] index of record whose detail is to be displayed
  ###
  toggleDetail: (_index) ->
    @activeDetailIndex = if @activeDetailIndex!=_index then _index else -1

  ###
  To set sorting methods
  @param key [String] field
  @param fn [function] sorting function
  ###
  setFieldSorting: (key, fn) ->
    @sort[key] =
      fn: fn
      order: 0

  ###
  To set sorting methods by an object
  @param sort [Dict] sorting functions dict
  ###
  setSortings: (sort) ->
    _.mapObject sort, (fn, key) =>
      @setFieldSorting key, fn

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
class TableCssManager

  ###
  table tr style
  @param item [Object] a record in the table
  ###
  @brief: (item) ->

  ###
  row detail style
  @param item [Object] a record in the table
  ###
  @detail: (item) ->

  ###
  table td style
  @param item [Object] brief data in a record of the table 
  ###
  @td: (item) ->

  ###
  table cell style
  @param key [String] field of table
  @param value [Object] cell content 
  ###
  @cellContent: (key, value) ->

  ###
  cell icon style
  @param key [String] field of table
  @param value [Object] cell content 
  ###
  @cellIcon: (key, vaule) ->

  ###
  cell style
  @param key [String] field of table
  @param value [Object] cell content 
  ###
  @cell: (key, value) ->

  ###
  sort order
  @param order [enum] -1, 1, others 
  ###
  @sortState: (order) ->
    switch order
      when -1 then "fa-sort-up"
      when 1 then "fa-sort-down"
      else "fa-sort"

  ###
  page index style
  @param actived [number] actived page num
  @param i [number] current page num
  ###
  @pageState: (actived, i) ->
    v = switch
      when actived==i then 'is-active'

  ###
  pagination prev style
  @param actived [number] actived page num
  ###
  @prevPageState: (actived) ->
    v = switch
      when actived==1 then 'is-disabled'

  ###
  pagination next style
  @param actived [number] actived page num
  @param last [number] last page num
  ###
  @nextPageState: (actived, last) ->
    v = switch
      when actived==last then 'is-disabled'


###
To define table directive
@extend Directive
###
class TableDirective extends Directive
  ###
  Construct an instance of TableDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for TableDirective
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
        titles: '=titles'
        sortings: '='
    _.extend params, tableParams
    super params, Table, cssKlass


  ###
  To initialize link function of table directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr
    scope.model.setPagination 1, scope.numPerPage
    scope.cFields = scope.cFields ? scope.model.fields
    scope.dFields = scope.dFields ? scope.model.fields
    scope.model.setFields scope.cFields, scope.dFields
    scope.model.setTitles scope.titles
    scope.model.setSortings scope.sortings
  

this.TableDirective = TableDirective
this.TableCssManager = TableCssManager

(function() {
  var Table, TableCssManager, TableDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = fetch();

  console.log(directiveDir);


  /*
  To define a table model
  @extend Model
   */

  Table = (function(superClass) {
    extend(Table, superClass);


    /*
    To construct an instance of table model
    @param data [Array<Dict>] data to be displayed in table
     */

    function Table(rawData) {
      this.rawData = rawData != null ? rawData : [];
      this.initTable();
    }


    /*
    To update table model by data
    @param data [Array<Dict>] data to be displayed in table
     */

    Table.prototype.initTable = function() {
      this.initFields();
      this.initSorting();
      this.setPagination();
      this.updateTableData();
      return this.updateCurrentPage();
    };


    /*
    To initialize table fields, including all fields, fields displayed in column, displayed in detail
     */

    Table.prototype.initFields = function() {
      this.fieldsSample = _.has(this.rawData, '0') ? this.rawData[0] : {};
      return this.fields = this.detailFields = this.columnFields = _.keys(this.fieldsSample);
    };


    /*
    To initialize sorting statuses and functions
     */

    Table.prototype.initSorting = function() {
      return this.sort = _.mapObject(this.fieldsSample, function(_f) {
        var s;
        return s = {
          fn: _.identity,
          order: 0
        };
      });
    };


    /*
    To set table data by columnFields and detailFields
     */

    Table.prototype.updateTableData = function() {
      return this.data = _.map(this.rawData, (function(_this) {
        return function(d) {
          var tmp;
          tmp = {};
          tmp.columnData = _.pick(d, _this.columnFields);
          tmp.detailData = _.pick(d, _this.detailFields);
          return tmp;
        };
      })(this));
    };


    /*
    To set pagination
    @param currentPage [number]
    @param numberPerPage [number] number of records per page
     */

    Table.prototype.setPagination = function(currentPage, numberPerPage) {
      var j, ref, results;
      this.numPerPage = numberPerPage != null ? numberPerPage : 2;
      this.numPages = Math.ceil(this.rawData.length / this.numPerPage);
      this.currentPage = currentPage != null ? currentPage : 1;
      return this.pageRange = this.numPages === 0 ? [] : (function() {
        results = [];
        for (var j = 1, ref = this.numPages; 1 <= ref ? j <= ref : j >= ref; 1 <= ref ? j++ : j--){ results.push(j); }
        return results;
      }).apply(this);
    };


    /*
    To get data by current page
     */

    Table.prototype.updateCurrentPage = function() {
      this.from = (this.currentPage - 1) * this.numPerPage;
      this.to = this.from + this.numPerPage - 1;
      this.currentData = this.data.slice(this.from, +this.to + 1 || 9e9);
      return this.activeDetailIndex = -1;
    };


    /*
    To set table caption
    @param caption [string] default 'Table'
     */

    Table.prototype.setCaption = function(caption) {
      return this.caption = caption != null ? caption : "Table";
    };


    /*
    To reset order status by field
    @param field [string] field the data is sorted by
    @param order [number] enum: -1(des), 0(no ordered), 1(asc)
     */

    Table.prototype.resetOrder = function(field, order) {
      return _.each(this.sort, function(v, k) {
        if (k !== field) {
          return v.order = 0;
        } else {
          return v.order = order;
        }
      });
    };


    /*
    To sort table data by field
    @param field [string] field the data is sorted by
     */

    Table.prototype.sortBy = function(field) {
      var currentOrder, order;
      currentOrder = this.sort[field].order;
      order = currentOrder === 0 ? -1 : -currentOrder;
      this.rawData = _.sortBy(this.rawData, (function(_this) {
        return function(d) {
          return _this.sort[field].fn(d[field]);
        };
      })(this));
      if (order === -1) {
        this.rawData.reverse();
      }
      this.resetOrder(field, order);
      this.updateTableData();
      return this.updateCurrentPage();
    };


    /*
    To set current page and update data by current page
    @param page [number] current page
     */

    Table.prototype.setCurrentPage = function(page) {
      if (page <= 0) {
        page = 1;
      } else if (page >= this.numPages) {
        page = this.numPages;
      }
      this.setPagination(page, this.numPerPage);
      return this.updateCurrentPage();
    };


    /*
    To set column fields, detail fields
    @param cFields [Array<string>] column fields
    @param dFields [Array<string>] detail fields
     */

    Table.prototype.setFields = function(cFields, dFields) {
      this.columnFields = _.intersection(cFields, this.fields);
      this.detailFields = _.intersection(dFields, this.fields);
      this.updateTableData();
      return this.updateCurrentPage();
    };


    /*
    To toggle detail
    @param _index [number] index of record whose detail is to be displayed
     */

    Table.prototype.toggleDetail = function(_index) {
      return this.activeDetailIndex = this.activeDetailIndex !== _index ? _index : -1;
    };


    /*
    Check whether detail of record by index should be displayed
    @param _index [number] index of record to be judged
     */

    Table.prototype.detailDisplayed = function(_index) {
      return _index === this.activeDetailIndex;
    };

    return Table;

  })(Model);


  /*
  To define table css manager
  @extend CssManager
   */

  TableCssManager = (function(superClass) {
    extend(TableCssManager, superClass);

    function TableCssManager() {
      return TableCssManager.__super__.constructor.apply(this, arguments);
    }


    /*
    table tr style
     */

    TableCssManager.brief = function(item) {};


    /*
    row detail style
     */

    TableCssManager.detail = function(item) {};


    /*
    table td style
     */

    TableCssManager.td = function(item) {};


    /*
    table cell style
     */

    TableCssManager.cellContent = function(key, value) {};


    /*
    cell icon
     */

    TableCssManager.cellIcon = function(key, vaule) {
      var icon;
      return icon = (function() {
        switch (key) {
          case 'nickname':
            return 'fa fa-desktop';
          case 'groupName':
            return 'fa fa-client-group';
          default:
            return 'hide';
        }
      })();
    };


    /*
    td with background
     */

    TableCssManager.cell = function(key, value) {
      var bg;
      return bg = (function() {
        switch (false) {
          case !(key === 'nickname' || key === 'groupName'):
            return 'td-icon';
        }
      })();
    };


    /*
    sort order
     */

    TableCssManager.sortState = function(sortMap, sortedField) {
      switch (sortMap[sortedField].order) {
        case -1:
          return "fa-sort-up";
        case 1:
          return "fa-sort-down";
        default:
          return "fa-sort";
      }
    };


    /*
    page index style
     */

    TableCssManager.pageState = function(actived, i) {
      var v;
      return v = (function() {
        switch (false) {
          case actived !== i:
            return 'is-active';
        }
      })();
    };


    /*
    pagination prev style
     */

    TableCssManager.prevPageState = function(actived) {
      var v;
      return v = (function() {
        switch (false) {
          case actived !== 1:
            return 'is-disabled';
        }
      })();
    };


    /*
    #pagination next style
     */

    TableCssManager.nextPageState = function(actived, last) {
      var v;
      return v = (function() {
        switch (false) {
          case actived !== last:
            return 'is-disabled';
        }
      })();
    };

    return TableCssManager;

  })(CssManager);


  /*
  To define table directive
  @extend Directive
   */

  TableDirective = (function(superClass) {
    extend(TableDirective, superClass);


    /*
    Construct an instance of TableDirective
    @param params [Dict] parameters of angular directive
     */

    function TableDirective(params, cssKlass) {
      var tableParams;
      params = params != null ? params : {};
      cssKlass = cssKlass != null ? cssKlass : TableCssManager;
      tableParams = {
        templateUrl: directiveDir + 'table.html',
        scope: {
          cFields: '=cFields',
          dFields: '=dFields',
          numPerPage: '=numPerPage',
          caption: '=caption'
        }
      };
      _.extend(params, tableParams);
      TableDirective.__super__.constructor.call(this, params, Table, cssKlass);
    }


    /*
    To initialize link function of table directive
     */

    TableDirective.prototype.linkFn = function(scope, element, attr) {
      var ref, ref1;
      TableDirective.__super__.linkFn.call(this, scope, element, attr);
      scope.model.setPagination(1, scope.numPerPage);
      scope.model.setCaption(scope.caption);
      scope.cFields = (ref = scope.cFields) != null ? ref : scope.model.fields;
      scope.dFields = (ref1 = scope.dFields) != null ? ref1 : scope.model.fields;
      return scope.model.setFields(scope.cFields, scope.dFields);
    };

    return TableDirective;

  })(Directive);

  this.TableDirective = TableDirective;

  this.TableCssManager = TableCssManager;

}).call(this);

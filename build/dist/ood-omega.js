
/*
To define a model
@author Phoenix Grey
 */

(function() {
  var CssManager, Directive, DirectiveSchool, Model;

  Model = (function() {

    /*
    Construct a model
     */
    function Model(data) {
      this.data = data;
    }

    return Model;

  })();


  /*
  To define a css manager
  @author Phoenix Grey
   */

  CssManager = (function() {
    function CssManager() {}

    return CssManager;

  })();


  /*
  To define a directive
  @author Phoenix Grey
   */

  Directive = (function() {

    /*
    Construct a directive by config, model, and events
    @param params [dict] Parameters of angular directive
    @param modelKlass [subclass of Model] Model class the directive uses to manipulate data 
    @param cssKlass [subClass of cssManager] CssManager class the directive uses to control css
     */
    function Directive(params, modelKlass, cssKlass) {
      var scope;
      this.modelKlass = modelKlass || Model;
      this.cssKlass = cssKlass || CssManager;
      this.params = {
        restrict: 'E',
        templateUrl: '',
        scope: {
          storage: "=info"
        }
      };
      scope = this.params.scope;
      if (params && params.scope) {
        scope = _.extend(this.params.scope, params.scope);
      }
      _.extend(this.params, params);
      this.params.scope = scope;
      this.initLink();
    }


    /*
    Called when directive is initiated, which is used to be extended by sub classes
     */

    Directive.prototype.linkFn = function(scope, element, attr) {
      this.scope = scope;
      return _.extend(scope, {
        model: new this.modelKlass(scope.storage),
        css: this.cssKlass
      });
    };


    /*
    Initialize link function of angular directive
    @private
     */

    Directive.prototype.initLink = function() {
      return this.params['link'] = (function(_this) {
        return function(scope, element, attr) {
          return _this.linkFn(scope, element, attr);
        };
      })(this);
    };

    return Directive;

  })();


  /*
  To register directives in app
  @author Phoenix Grey
   */

  DirectiveSchool = (function() {
    function DirectiveSchool() {}


    /*
    @param app [angular.module] The angular module the directive is registered to
    @param directiveName [string] The directive name
    @param directive [angular.directive] The directive to be registered
     */

    DirectiveSchool.register = function(app, directiveName, directive) {
      return app.directive(directiveName, function() {
        return directive.params;
      });
    };

    return DirectiveSchool;

  })();

  this.Model = Model;

  this.CssManager = CssManager;

  this.DirectiveSchool = DirectiveSchool;

  this.Directive = Directive;

}).call(this);

(function() {
  var Table, TableCssManager, TableDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/table/';


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
    Set Title Display
     */

    Table.prototype.setTitles = function(titles) {
      return this.titles = _.mapObject(this.fieldsSample, function(v, k) {
        var ref, t;
        return t = (ref = titles && titles[k]) != null ? ref : k;
      });
    };


    /*
    get Title Display
     */

    Table.prototype.getTitle = function(t) {
      return this.titles[t];
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
          titles: '=titles'
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
      scope.cFields = (ref = scope.cFields) != null ? ref : scope.model.fields;
      scope.dFields = (ref1 = scope.dFields) != null ? ref1 : scope.model.fields;
      scope.model.setFields(scope.cFields, scope.dFields);
      return scope.model.setTitles(scope.titles);
    };

    return TableDirective;

  })(Directive);

  this.TableDirective = TableDirective;

  this.TableCssManager = TableCssManager;

}).call(this);

(function() {
  var Footer, FooterCssManager, FooterDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/footer/';

  FooterCssManager = (function() {
    function FooterCssManager() {}

    return FooterCssManager;

  })();

  Footer = (function(superClass) {
    extend(Footer, superClass);

    function Footer(data) {
      this.data = data;
      this;
    }

    return Footer;

  })(Model);

  FooterDirective = (function(superClass) {
    extend(FooterDirective, superClass);

    function FooterDirective(params) {
      var footerParams;
      params = params != null ? params : {};
      footerParams = {
        templateUrl: directiveDir + 'footer.html'
      };
      _.extend(params, footerParams);
      FooterDirective.__super__.constructor.call(this, params, Footer, FooterCssManager);
    }

    return FooterDirective;

  })(Directive);

  this.FooterDirective = FooterDirective;

}).call(this);

(function() {
  var Aside, AsideCssManager, AsideDirective, COLLAPSED, DISABLED, EXPANDED, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'build/aside/';

  EXPANDED = 0;

  COLLAPSED = 1;

  DISABLED = 2;

  AsideCssManager = (function() {
    function AsideCssManager() {}

    AsideCssManager.arrowIcon = function(expansion, k) {
      switch (expansion[k]) {
        case EXPANDED:
          return 'fa fa-angle-up';
        case COLLAPSED:
          return 'fa fa-angle-down';
        default:
          return '';
      }
    };

    return AsideCssManager;

  })();

  Aside = (function(superClass) {
    extend(Aside, superClass);

    function Aside(data) {
      this.data = data;
      this.initExpansion();
      this;
    }

    Aside.prototype.initExpansion = function() {
      return this.expansion = _.mapObject(this.data, function(v, k) {
        var state;
        console.log("k", k);
        console.log("v", v);
        return state = !v.subnodes ? DISABLED : COLLAPSED;
      });
    };

    Aside.prototype.toggle = function(k) {
      return this.expansion[k] = (function() {
        switch (this.expansion[k]) {
          case EXPANDED:
            return COLLAPSED;
          case COLLAPSED:
            return EXPANDED;
        }
      }).call(this);
    };

    Aside.prototype.expanded = function(k) {
      return this.expansion[k] === EXPANDED;
    };

    return Aside;

  })(Model);

  AsideDirective = (function(superClass) {
    extend(AsideDirective, superClass);

    function AsideDirective(params, cssKlass) {
      var asideParams;
      params = params != null ? params : {};
      cssKlass = cssKlass != null ? cssKlass : AsideCssManager;
      asideParams = {
        templateUrl: directiveDir + 'aside.html'
      };
      _.extend(params, asideParams);
      AsideDirective.__super__.constructor.call(this, params, Aside, cssKlass);
    }

    return AsideDirective;

  })(Directive);

  this.AsideDirective = AsideDirective;

}).call(this);


/*
Create an angular module called OODLIB
@author Phoenix Grey
 */

(function() {
  var a, d, f, lib;

  lib = angular.module("OODLib", ['gettext']);

  lib.run([
    'gettextCatalog', function(gettextCatalog) {
      gettextCatalog.currentLanguage = 'zh';
      return gettextCatalog.debug = true;
    }
  ]);


  /*
  Expose OOD to Browser as a global object
  @author Phoenix Grey
   */

  this.OOD = lib;

  d = new TableDirective();

  DirectiveSchool.register(OOD, 'ctable', d);

  f = new FooterDirective();

  DirectiveSchool.register(OOD, 'cfooter', f);

  a = new AsideDirective();

  DirectiveSchool.register(OOD, 'caside', a);

}).call(this);

angular.module('gettext').run(['gettextCatalog', function (gettextCatalog) {
/* jshint -W100 */
    gettextCatalog.setStrings('zh', {"details":"详情","records":"条记录","total":"总共"});
/* jshint +W100 */
}]);
angular.module('OODLib').run(['$templateCache', function ($templateCache) {
	$templateCache.put('lib/aside/aside.html', '<div class="linedk"> <ul> <li ng-repeat="(k, v) in model.data"><a ng-href="{{v.URL}}" ng-click="model.toggle(k)"><i ng-class="v.icon"></i>{{v.name}}<i ng-class="css.arrowIcon(model.expansion, k)"></i></a> <ul ng-show="model.expanded(k)"> <li ng-repeat="subnode in v.subnodes"><a ng-href="{{subnode.URL}}"><i ng-class="subnode.icon"></i>{{subnode.name}}</a></li> </ul> </li> </ul> </div>');
	$templateCache.put('lib/footer/footer.html', '<footer> <p>Copyright © {{model.data.year}} {{model.data.name}}<span>|</span><a ng-href="{{model.data.website}}">{{model.data.websiteName}}</a><span>|</span>version: {{model.data.version}} {{model.data.status}}</p> </footer>');
	$templateCache.put('lib/table/table.html', '<div class="responsive"> <table class="table table-sort table-detail-default table-stripped-4"> <thead> <tr> <th ng-repeat="t in model.columnFields" ng-click="model.sortBy(t)"> <span ng-bind="model.getTitle(t)"></span><i ng-class="css.sortState(model.sort, t)" class="fa"></i></th> </tr> </thead> <tbody> <tr ng-repeat-start="item in model.currentData" ng-click="model.toggleDetail($index)" ng-class="css.brief(item)"> <td ng-repeat="(k,v) in item.columnData" ng-class="css.td(item.columnData)"> <div ng-class="css.cell(k,v)"><i ng-class="css.cellIcon(k,v)"></i><span ng-bind="v" class="css.cellContent(k,v)"></span></div> </td> </tr> <tr ng-repeat-end="ng-repeat-end" ng-show="model.detailDisplayed($index)" ng-class="css.detail(item)"> <td colspan="{{model.columnFields.length}}" class="is-nopadding"> <div class="detail-default"> <div translate="translate" class="detail-title">details</div> <dl> <dt ng-repeat-start="(k,v) in item.detailData">{{model.getTitle(k)}}:</dt> <dd ng-repeat-end="(k,v) in item.detailData">{{v}}</dd> </dl> </div> </td> </tr> </tbody> </table> <div ng-show="model.data.length&gt;0" class="statistics"> <span> <span translate="translate">total</span><span ng-bind="model.data.length"> </span><span translate="translate">records</span></span> <ul class="pagination"> <li ng-class="css.prevPageState(model.currentPage)" ng-click="model.setCurrentPage(model.currentPage-1)"><a href="#">«</a></li> <li ng-repeat="i in model.pageRange" ng-click="model.setCurrentPage(i)" ng-class="css.pageState(model.currentPage, i)"><a href="#">{{i}}</a></li> <li ng-class="css.nextPageState(model.currentPage, model.numPages)" ng-click="model.setCurrentPage(model.currentPage+1)"><a href="#">»</a></li> </ul> </div> </div>');
	$templateCache.put('lib/topbar/topbarDropdown.html', '<ul class="dropdown-menu"> <li class="header">{{ model.data.name }}</li> <li> <ul class="menu"> <li ng-repeat="(k, v) in model.data"><a ng-href="{{v.URL}}" ng-click="model.toggle(k)"><i ng-class="v.icon" class="floatLeft"><span class="floatLeft"><small class="topBar_small"></small></span><span class="floatLeft">{{ v.name }}<small ng-bind="v.count" class="topBar_small_chrono"></small></span></i><i ng-class="css.arrowIcon(model.expansion, k)"></i> <ul ng-show="model.expanded(k)"> <li ng-repeat="(k, v) in v.subnodes">{{ k }}:&nbsp;&nbsp;{{ v }}</li> </ul></a></li> </ul> </li> <li class="footer"> <ul> <li ng-repeat="(k, v) in model.data.footerInfo">{{ k }}:&nbsp;&nbsp;{{ v }}</li> </ul> </li> </ul>');
}]);
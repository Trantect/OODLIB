/* version NO. 0.0.0 */

(function() {
  var Topbar, TopbarCssManager, TopbarDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/components/topbar/';

  Topbar = (function(superClass) {
    extend(Topbar, superClass);

    function Topbar(rawData) {
      this.rawData = rawData;
      this.title = this.rawData;
    }

    return Topbar;

  })(Model);

  TopbarCssManager = (function(superClass) {
    extend(TopbarCssManager, superClass);

    function TopbarCssManager() {
      return TopbarCssManager.__super__.constructor.apply(this, arguments);
    }

    return TopbarCssManager;

  })(CssManager);

  TopbarDirective = (function(superClass) {
    extend(TopbarDirective, superClass);


    /*
    Construct an instance of TopbarDirective
    @param params [Dict] parameters of angular directive
    @param cssKlass [Class] css management class for TopbarDirective
     */

    function TopbarDirective(params, cssKlass) {
      var headerParams;
      params = params != null ? params : {};
      cssKlass = cssKlass != null ? cssKlass : TopbarCssManager;
      headerParams = {
        templateUrl: directiveDir + 'topbar.html'
      };
      _.extend(params, headerParams);
      TopbarDirective.__super__.constructor.call(this, params, Topbar, cssKlass);
    }

    return TopbarDirective;

  })(Directive);

  this.TopbarDirective = TopbarDirective;

  this.TopbarCssManager = TopbarCssManager;

}).call(this);

(function() {
  var Topbar, TopbarCssManager, TopbarDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/components/topbar/';

  Topbar = (function(superClass) {
    extend(Topbar, superClass);

    function Topbar(rawData) {
      this.rawData = rawData;
      this.title = this.rawData;
    }

    return Topbar;

  })(Model);

  TopbarCssManager = (function(superClass) {
    extend(TopbarCssManager, superClass);

    function TopbarCssManager() {
      return TopbarCssManager.__super__.constructor.apply(this, arguments);
    }

    return TopbarCssManager;

  })(CssManager);

  TopbarDirective = (function(superClass) {
    extend(TopbarDirective, superClass);


    /*
    Construct an instance of TopbarDirective
    @param params [Dict] parameters of angular directive
    @param cssKlass [Class] css management class for TopbarDirective
     */

    function TopbarDirective(params, cssKlass) {
      var headerParams;
      params = params != null ? params : {};
      cssKlass = cssKlass != null ? cssKlass : TopbarCssManager;
      headerParams = {
        templateUrl: directiveDir + 'topbar.html'
      };
      _.extend(params, headerParams);
      TopbarDirective.__super__.constructor.call(this, params, Topbar, cssKlass);
    }

    return TopbarDirective;

  })(Directive);

  this.TopbarDirective = TopbarDirective;

  this.TopbarCssManager = TopbarCssManager;

}).call(this);


/*
Create an angular module called OOD_Table
@author Phoenix Grey
 */

(function() {
  var d, lib;

  lib = angular.module("OOD_topbar", ['gettext']);

  lib.run([
    'gettextCatalog', function(gettextCatalog) {
      return gettextCatalog.currentLanguage = 'zh';
    }
  ]);


  /*
  Expose OOD to Browser as a global object
  @author Phoenix Grey
   */

  d = new TopbarDirective();

  DirectiveSchool.register(lib, 'ctopbar', d);

}).call(this);

angular.module('OOD_topbar').run(['$templateCache', function ($templateCache) {
	$templateCache.put('lib/components/topbar/topbar.html', '<header><a href="#" class="logo"><img src="https://trello-attachments.s3.amazonaws.com/5677614ccce6b3d59e4bc9d7/60x30/ad7f1ea7713688a05b95a2dcb7e0d4f4/LOGO..png"/></a><div class="nav header-nav"> <ul class="nav-toolbar is-align-left nav-clearfix"><li><a id="sidebar_controller" href="#" class="nav-item"><i class="fa fa-bars"></i></a></li></ul><ul class="nav-toolbar is-align-right nav-clearfix"><li><a href="#" class="nav-item"><i class="fa fa-sitemap"></i></a></li><li><a href="#" class="nav-item"><i class="fa fa-database"></i></a></li><li><a href="#" class="nav-item"><i class="fa fa-tasks"></i></a></li><li><a href="#" class="nav-item"><i class="icon-vul"></i></a></li><li><a href="#" class="nav-item"><i class="icon-virus"></i></a></li><li><a href="#" class="nav-item"><i class="icon-hips"></i></a></li><li class="user user-info"><a class="nav-item"><i class="fa fa-user"></i><span>abc1234567</span></a></li><li class="user dropdown"><a href="#" class="nav-item"><i class="fa fa-sign-out"></i><span class="user-exit">Logut</span></a></li></ul></div></header>');
}]);
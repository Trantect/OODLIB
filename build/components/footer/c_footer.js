(function() {
  var Footer, FooterCssManager, FooterDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/components/footer/';


  /*
  To define a footer model
  @extend Model
   */

  Footer = (function(superClass) {
    extend(Footer, superClass);


    /*
    To construct an instance of footer model
    @param data [Array<Dict>] data to be displayed in footer
     */

    function Footer(data) {
      var defaultData;
      defaultData = {
        copyright: "EMPTY copyright",
        version: "EMPTY version",
        websites: []
      };
      this.rawData = _.extend(defaultData, data);
      this.copyright = this.rawData.copyright;
      this.version = this.rawData.version;
      this.websites = this.rawData.websites;
      this.lenOfSites = this.rawData.websites.length;
    }


    /*
    To get the first value of an object
    @param o [Object]
     */

    Footer.prototype.getLink = function(o) {
      return (_.values(o))[0];
    };


    /*
    To get the first key of an object
    @param o [Object]
     */

    Footer.prototype.getName = function(o) {
      return (_.keys(o))[0];
    };

    return Footer;

  })(Model);


  /*
  To define footer css manager
   */

  FooterCssManager = (function() {
    function FooterCssManager() {}

    return FooterCssManager;

  })();


  /*
  To define footer directive
  @extend Directive
   */

  FooterDirective = (function(superClass) {
    extend(FooterDirective, superClass);


    /*
    Construct an instance of FooterDirective
    @param params [dict] Parameters of angular directive
     */

    function FooterDirective(params) {
      var footerParams;
      params = params != null ? params : {};
      footerParams = {
        templateUrl: directiveDir + 'footer.html',
        replace: true
      };
      _.extend(params, footerParams);
      FooterDirective.__super__.constructor.call(this, params, Footer, FooterCssManager);
    }

    return FooterDirective;

  })(Directive);

  this.FooterDirective = FooterDirective;

}).call(this);


/*
Create an angular module called footer 
@author Phoenix Grey
 */

(function() {
  var f, lib;

  lib = angular.module("OOD_footer", ['gettext']);

  lib.run([
    'gettextCatalog', function(gettextCatalog) {
      return gettextCatalog.currentLanguage = 'zh';
    }
  ]);


  /*
  Expose footer to Browser as a global object
  @author Phoenix Grey
   */

  f = new FooterDirective();

  DirectiveSchool.register(lib, 'cfooter', f);

}).call(this);

angular.module('gettext').run(['gettextCatalog', function (gettextCatalog) {
/* jshint -W100 */
    gettextCatalog.setStrings('zh', {});
/* jshint +W100 */
}]);
angular.module('OOD_footer').run(['$templateCache', function ($templateCache) {
	$templateCache.put('lib/components/footer/footer.html', '<div class="footer"><span class="copyright"> <span>Copyright © {{model.copyright}}</span><span class="line">|</span><spen>Version: {{model.version}}</spen></span><span class="help"><span ng-repeat-start="site in model.websites"><a ng-href="{{model.getLink(site)}}">{{model.getName(site)}}</a></span><span ng-repeat-end="ng-repeat-end" ng-show="{{$index}}&lt;{{model.lenOfSites-1}}" class="line">|</span></span></div>');
}]);
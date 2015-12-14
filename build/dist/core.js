
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
          storage: "=info",
          cssManager: "="
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
    merge directive cssKlass and customerized one 
    @param customerCssManager [Class] customerized css manager defined from directive attribute css-manager
     */

    Directive.prototype.mergeCssKlass = function(customerCssManager) {
      _.extendOwn(this.cssKlass, customerCssManager);
      return this.cssKlass;
    };


    /*
    Called when directive is initiated, which is used to be extended by sub classes
     */

    Directive.prototype.linkFn = function(scope, element, attr) {
      this.scope = scope;
      _.extend(scope, {
        model: new this.modelKlass(scope.storage),
        css: this.mergeCssKlass(scope.cssManager)
      });
      scope.$watch('storage', (function(_this) {
        return function(nv, ov) {
          if (nv !== ov) {
            return scope.model = new _this.modelKlass(nv);
          }
        };
      })(this));
      return scope.$watch('cssManager', (function(_this) {
        return function(nv, ov) {
          if (nv !== ov) {
            return scope.css = _this.mergeCssKlass(nv);
          }
        };
      })(this));
    };


    /*
    Initialize link function of angular directive
    @private
     */

    Directive.prototype.initLink = function() {
      return this.params['link'] = {
        pre: (function(_this) {
          return function(scope, element, attr) {
            return _this.linkFn(scope, element, attr);
          };
        })(this)
      };
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

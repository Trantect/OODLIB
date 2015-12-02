###
To define a model
@author Phoenix Grey
###
class Model
  ###
  Construct a model
  ###
  constructor: (@data) ->


###
To define a css manager
@author Phoenix Grey
###
class CssManager

###
To define a directive
@author Phoenix Grey
###
class Directive
  ###
  Construct a directive by config, model, and events
  @param params [dict] Parameters of angular directive
  @param modelKlass [subclass of Model] Model class the directive uses to manipulate data 
  @param cssKlass [subClass of cssManager] CssManager class the directive uses to control css
  ###
  constructor: (params, modelKlass, cssKlass) ->
    @modelKlass = modelKlass or Model
    @cssKlass = cssKlass or CssManager
    @params =
      restrict: 'E'
      templateUrl: ''
      scope:
        storage: "=info"
        cssManager: "="
    scope = @params.scope
    if params and params.scope
      scope = _.extend @params.scope, params.scope
    _.extend @params, params
    @params.scope = scope
    @initLink()

  ###
  merge directive cssKlass and customerized one 
  @param customerCssManager [Class] customerized css manager defined from directive attribute css-manager 
  ###
  mergeCssKlass: (customerCssManager) ->
    _.extendOwn @cssKlass, customerCssManager
    @cssKlass

  ###
  Called when directive is initiated, which is used to be extended by sub classes
  ###
  linkFn: (scope, element, attr) ->
    @scope = scope
    _.extend scope,
      model: new @modelKlass scope.storage
      css: @mergeCssKlass scope.cssManager

  ###
  Initialize link function of angular directive
  @private
  ###
  initLink: () ->
    @params['link'] = (scope, element, attr) =>
      @linkFn scope, element, attr

###
To register directives in app
@author Phoenix Grey
###
class DirectiveSchool
  ###
  @param app [angular.module] The angular module the directive is registered to
  @param directiveName [string] The directive name
  @param directive [angular.directive] The directive to be registered
  ###
  @register: (app, directiveName, directive) ->
    app.directive directiveName, () ->
      directive.params


this.Model = Model
this.CssManager = CssManager
this.DirectiveSchool = DirectiveSchool
this.Directive = Directive

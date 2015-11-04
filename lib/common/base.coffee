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
###
class CssManager

###
To define user interaction 
@author Phoenix Grey
###
class UI
  ###
  Construct a User interaction service
  @param config [Array<Dict>] user interaction configuration 
  @example (create a UI instance)
    config = [
      selector: 'tr'
      action: 'click'
      handlerName: 'displayDetails'
    ,
      selector: 'tr'
      action: 'mouseover'
      handlerName: 'displayOptionButtons'
    ]

    new UI config 
  ###
  constructor: (config) ->
    @config = config ? {}
    @initHandler()

  ###
  Initialize the default handlers according to config
  @private
  ###
  initHandler: () ->
    @handlers = {}
    _.each @config, (_c) =>
      @handlers[_c.handlerName] = (element, model, scope, event) ->
        console.log 'default ', _c.handlerName, ' handler'

  ###
  Set handler function
  @param handlerName [String] handler name defined in config
  @param fn [Function]
  ###
  setHandler: (handlerName, fn) ->
    if _.has @handlers, handlerName
      @handlers[handlerName] = fn
    else
      throw Error 'No events has defined for your handler'
###
To define a directive
@author Phoenix Grey
###
class Directive
  ###
  Construct a directive by config, model, and events
  @param params [dict] The parameters of angular directive
  @param model [subclass of Model] The model the directive used to manipulate data 
  @param events [subclass of Events] The user interaction with directives 
  ###
  constructor: (params, modelKlass, cssKlass, ui) ->
    @modelKlass = modelKlass or Model
    @cssKlass = cssKlass or CssManager
    @params =
      restrict: 'E'
      templateUrl: ''
      scope:
        storage: "=info"
    scope = @params.scope
    if params and params.scope
      scope = _.extend @params.scope, params.scope
    _.extend @params, params
    @params.scope = scope
    @ui = ui or new UI()
    @initLink()

  ###
  Register user interaction
  @param root [JQuery.dom] an html dom element
  @param ui [UI] ui service to be bind with root
  @param scope [angular.scope]
  @private
  ###
  registerUI: (root, ui, scope) ->
    _.each ui.config, (_p) ->
      root.on _p.action, _p.selector, (event) ->
        ui.handlers[_p.handlerName] root, scope.model, scope, event
        scope.$apply()

  linkFn: (scope, element, attr) ->
    @scope = scope
    _.extend scope,
      model: new @modelKlass scope.storage
      css: @cssKlass

    @registerUI element, @ui, scope

  ###
  Initialize link function of angular directive
  @private
  ###
  initLink: () ->
    @params['link'] = (scope, element, attr) =>
      @linkFn scope, element, attr
  ###
  Set handler function
  ###
  setHandler: (handlerName, fn) ->
    @ui.setHandler handlerName, fn

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


this.UI = UI
this.Model = Model
this.CssManager = CssManager
this.DirectiveSchool = DirectiveSchool
this.Directive = Directive

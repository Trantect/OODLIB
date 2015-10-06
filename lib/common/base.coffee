#
# __ClassName: EventRegister__
#
# ---
#
# __Static Method__
#
# register(Dom, DomEvents)  
# * Register `DomEvents` on `Dom` element
# * eg:
#   ```
#   button = $ 'button';
#
#   events =
#     click: () ->
#       console.log 'click'
#
#   EventRegister.register button, events
#   ```
# ---
#
class EventRegister
  @register: (root, selector, behaviors) ->
    _.each behaviors, (handler, action) ->
      root.on action, selector, handler

#
# __ClassName: Directive__
#
# ---
#
# __Static Method__
#
# register(app, directiveName, directiveConfig)  
# * Register a directive called `directiveName` by config `directiveConfig` on `app`
# * eg:
#   ```
#   app = angular.module 'app', []
#
#   name = 'ctable'
#
#   config =
#     restrict: 'E'
#     template: 'directive.html'
#
#   Directive.register app, name, config
#   ```
# ---
#
class DirectiveSchool
  @register: (app, directiveName, directive) ->
    app.directive directiveName, () ->
      directive.params()

class Directive
  constructor: (config) ->
    @config =
      restrict: 'E'
      templateUrl: 'build/directive/default.html'
      scope: {}
    _.extend @config, config
    console.log @config
    @move 'options', 'events'
    @handlers = @initHandlers()
    @updateEvents()

  move: () ->
    _.each arguments, (key) =>
      @[key] = @config[key]
      delete @config[key]

  updateEvents: () ->
    @events = _.mapObject @events, (_behaviors, _selector) =>
      _.mapObject _behaviors, (_handler, _action) =>
        @handlers[_handler]
        
  initHandlers: () ->
    _item = {}
    _.each @events, (_behaviors, _selector) ->
      _handlers = _.values _behaviors
      _.each _handlers, (_handler) ->
        _item[_handler] = () ->
          console.log "fire #{_handler} action"
    _item

  registerEvents = (root, events) ->
    _.each events, (_behaviors, _selector) ->
      EventRegister.register root, _selector, _behaviors

  params: () ->
    @dParams = {}
    _.extend @dParams, @config
    @dParams['link'] = (scope, element, attr) =>
      _.extend scope, @options
      registerEvents element, @events
      
    @dParams



this.EventRegister = EventRegister
this.DirectiveSchool = DirectiveSchool
this.Directive = Directive

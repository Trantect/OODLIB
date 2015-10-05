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
  @register: (ele, events) ->
    _.each events, (value, key) ->
      ele.on key, value


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
class Directive
  @register: (app, directiveName, config) ->
    app.directive directiveName, () ->
      config

this.EventRegister = EventRegister
this.Directive = Directive

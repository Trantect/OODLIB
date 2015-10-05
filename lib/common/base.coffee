class EventRegister
  @register: (ele, events) ->
    _.each events, (value, key) ->
      ele.on key, value

class DictConfig
  constructor: (config) ->
    _.each config, (value, key) =>
      @[key] = _.clone value
    @

class Directive
  @register: (app, directiveName, config) ->
    app.directive directiveName, () ->
      new DictConfig config

this.EventRegister = EventRegister
this.DictConfig = DictConfig
this.Directive = Directive

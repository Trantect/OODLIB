directiveDir = 'build/aside/'


class Aside extends Model
  EXPANDED = false
  constructor: (@data) ->
    @initExpansion()
    @

  initExpansion: () ->
    @expansion = _.mapObject @data, () ->
      EXPANDED

  toggle: (k) ->
    @expansion[k] = not @expansion[k]

  expanded: (k) ->
    @expansion[k]

class AsideDirective extends Directive
  constructor: (params, uiConfig) ->
    params = params ? {}
    asideParams =
      templateUrl: directiveDir + 'aside.html'
    _.extend params, asideParams
    super params, Aside, new UI uiConfig


this.AsideDirective = AsideDirective

directiveDir = 'build/aside/'


class Aside extends Model
  constructor: (@data) ->
    @

class AsideDirective extends Directive
  constructor: (params, uiConfig) ->
    params = params ? {}
    asideParams =
      templateUrl: directiveDir + 'aside.html'
    _.extend params, asideParams
    super params, Aside, new UI uiConfig


this.AsideDirective = AsideDirective

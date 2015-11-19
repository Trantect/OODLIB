directiveDir = 'build/aside/'

EXPANDED = 0
COLLAPSED = 1
DISABLED = 2

class AsideCssManager
  @arrowIcon: (expansion, k) ->
    switch expansion[k]
      when EXPANDED then 'fa fa-angle-up'
      when COLLAPSED then 'fa fa-angle-down'
      else ''

class Aside extends Model
  constructor: (@data) ->
    @initExpansion()

  initExpansion: () ->
    @expansion = _.mapObject @data, (v, k) ->
      state = if not v.subnodes then DISABLED else COLLAPSED

  toggle: (k) ->
    @expansion[k] = switch @expansion[k]
      when EXPANDED then COLLAPSED
      when COLLAPSED then EXPANDED

  expanded: (k) ->
    @expansion[k] == EXPANDED

class AsideDirective extends Directive
  constructor: (params, cssKlass) ->
    params = params ? {replace: true}
    cssKlass = cssKlass ? AsideCssManager
    asideParams =
      templateUrl: directiveDir + 'aside.html'
    _.extend params, asideParams
    super params, Aside, cssKlass

this.AsideDirective = AsideDirective

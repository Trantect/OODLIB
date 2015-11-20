directiveDir = 'build/aside/'

ACTIVE = 0
INACTIVE = 1

COLLAPSED = 0
EXPANDED = 1

t = (d, s) ->
  _.mapObject d, () ->
    s
class AsideCssManager
  @getState: (states, k) ->
    switch states[k]
      when ACTIVE then 'is-active'

  @getExpansion: (states, k) ->
    switch states[k]
      when COLLAPSED then 'fa fa-angle-down'
      when EXPANDED then 'fa fa-angle-up'
      else ''

  @subState: (states, k) ->
    switch states[k]
      when COLLAPSED then false
      when EXPANDED then true

class Aside extends Model
  constructor: (@data) ->
    @initStates()
    @initExpansion()

  initStates: () ->
    @states = {}
    _.each @data, (val, key) =>
      @states[key] = INACTIVE
      subStates = t val.subnodes, INACTIVE
      _.extend @states, subStates

  hasChildren: (k) ->
    if @data[k]!=undefined
      @data[k].subnodes!=undefined
    else
      false

  initExpansion: () ->
    @expansion = {}
    _.each @data, (v, k) =>
      if @hasChildren k
        @expansion[k] = COLLAPSED
      
  setActive: (k) ->
    @states = _.mapObject @states, (cv, ck) =>
      if ck==k and not @hasChildren k
        ACTIVE
      else
        INACTIVE
    console.log "state", @states[k]

  toggle: (k) ->
    if @expansion[k]!=undefined
      @expansion[k] = switch @expansion[k]
        when COLLAPSED then EXPANDED
        when EXPANDED then COLLAPSED

  goto: (k) ->
    @setActive k
    @toggle k

class AsideDirective extends Directive
  constructor: (params, cssKlass) ->
    params = params ? {replace: true}
    cssKlass = cssKlass ? AsideCssManager
    asideParams =
      templateUrl: directiveDir + 'aside.html'
    _.extend params, asideParams
    super params, Aside, cssKlass

this.AsideDirective = AsideDirective

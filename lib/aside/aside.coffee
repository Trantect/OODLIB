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
    @init()
    console.log "expansion", @expansion

  init: () ->
    @states = {}
    @expansion = {}
    _.each @data, (item, index) =>
      @initItemStates item
      @initItemExpansion item, index

  initItemStates: (item) ->
    _.each item, (val, key) =>
      @states[key] = INACTIVE
      subStates = t val.subnodes, INACTIVE
      _.extend @states, subStates

  hasChildren: (index, k) ->
    if @data[index][k]!=undefined
      @data[index][k].subnodes!=undefined
    else
      false

  initItemExpansion: (item, index) ->
    _.each item, (v, k) =>
      if @hasChildren index, k
        @expansion[k] = COLLAPSED

  setActive: (k) ->
    @states = _.mapObject @states, (cv, ck) =>
      if ck==k and not _.has @expansion, k
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

  setInit: (key) ->
    @toggle key
    @setActive key

class AsideDirective extends Directive
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? AsideCssManager
    asideParams =
      templateUrl: directiveDir + 'aside.html'
      scope:
        activeState: "@"
    _.extend params, asideParams
    super params, Aside, cssKlass
  ###
  To initialize link function of table directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr
    scope.model.setInit scope.activeState

this.AsideDirective = AsideDirective

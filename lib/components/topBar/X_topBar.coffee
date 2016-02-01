directiveDir = 'lib/components/topBar/'

FOCUS = 0
UNFOCUS = 0

###
To convert an array of dict to a dict
@param _L [Array<Dict>]
###
merge = (_L) ->
  v = {}
  _.each _L, (_item) ->
    _.extend v, _item
  v

###
To define topBar css manager
###
class TopBarCssManager
  ###
  To control active style
  @param focusnion [enum] FOCUS, UNFOCUS
  ###
  @getState: (focusnion) ->
    switch focusnion
      when FOCUS then 'aaa'
      when UNFOCUS then 'adaa'
      else ''

  ###
  To control arrowIcon direction
  @param expansion [enum] COLLAPSED, EXPANDED
  ###
  @getExpansion: (expansion) ->
    switch expansion
      when COLLAPSED then 'aa'
      when EXPANDED then 'cc'
      else ''

  ###
  To control expansion
  @param expansion [enum] COLLAPSED, EXPANDED
  ###
  @expanded: (expansion) ->
    switch expansion
      when COLLAPSED then false
      when EXPANDED then true
      else ''

###
To abstract state for topBar item, which is so-called Node
###
class NodeState
  ###
  To construct an instance of NodeState
  @param
  @param
  @param
  ###
  constructor: (id, content, hasFather) ->
    @id = id
    @hasChildren = if content then content.subnodes!=undefined else undefined
    @hasFather = hasFather ? false
    @expansion = if @hasChildren then COLLAPSED else undefined
    @activation = INACTIVE
  ###
  To activate node, including setting expansion and activation
  return an activated node id and expanded node id
  ###
  activate: () ->
    AK = EK = undefined
    if @expansion != undefined
      @toggle()
      EK = if @expansion == EXPANDED then @id
    else
      @activation = ACTIVE
      AK = @id
      EK = if @hasFather then @hasFather else undefined
    [AK, EK]

  ###
  To set expansion EXPANDED if it is COLLAPSED
  ###
  expand: () ->
    @expansion = if @expansion == COLLAPSED then EXPANDED

  ###
  To toggle expansion value between COLLAPSED and EXPANDED
  ###
  toggle: () ->
    @expansion = if @expansion == COLLAPSED then EXPANDED else COLLAPSED

###
To define a topBar model
@extend Model
###
class TopBar extends Model

  ###
  To construct topBar model
  @param rawData [Object] info data imported from user
  ###
  constructor: (rawData) ->
    @rawData = _.filter rawData, (v) ->
      v != undefined and (_.keys v).length != 0
    @initStates()

  ###
  To initialize the state of nodes, subnodes and turn them into a flat data structure
  ###
  initStates: () ->
    t = _.map @rawData, (val, index) ->
      sectionNodes = _.map val, (nodeContent, nodeId) ->
        nodes = {}
        nodes[nodeId] = new NodeState nodeId, nodeContent, false
        subnodes = _.mapObject nodeContent.subnodes, (_subnode, _subid) ->
          new NodeState _subid, _subnode, nodeId
        _.extend nodes, subnodes
        nodes
      _tmp = merge sectionNodes
    @states = merge t

  ###
  To set states according to their keys
  @param nodeId [string] node id or subnode id
  ###
  setStates: (nodeId) ->
    nodeId = if nodeId!=undefined and nodeId!='' then nodeId else (_.keys @states)[0]
    [activatedKey, expandedKey] = if nodeId and @states[nodeId] then @states[nodeId].activate() else [undefined, undefined]
    if expandedKey then @states[expandedKey].expand()

  ###
  To toggle a topBar item
  @param nid [String] node id
  ###
  toggle: (nid) ->
    @states[nid].toggle()


#TODO copy from siderbar
###
To define topBar directive
@extend Directive
###
class topBarDirective extends Directive
  ###
  To construct an instance of topBarDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for topBar
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? TopBarCssManager
    asideParams =
      templateUrl: directiveDir + 'topBar.html'
      scope:
        focusItem: "="
    _.extend params, asideParams
    super params, TopBar, cssKlass
  ###
  To initialize link function of topBar directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr
    ###
    To set ACTIVE state to node or subnode according to focusItem
    @param item [string] node name or subnode name
    ###
    scope.model.setStates scope.focusItem

this.topBarDirective = topBarDirective

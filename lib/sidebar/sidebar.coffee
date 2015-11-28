directiveDir = 'lib/sidebar/'

ACTIVE = 0
INACTIVE = 1

COLLAPSED = 0
EXPANDED = 1

###
To convert an array of dict to a dict
@param _L [Array<Dict>]
###
merge = (_L) ->
  v = {}
  _.each _L, (_item) ->
    console.log '_item',_item
    _.extend v, _item
    console.log 'v',v
  v

###
To define sidebar css manager
###
class SidebarCssManager
  ###
  To control active style
  @param activation [emum] ACTIVE, INACTIVE
  ###
  @getState: (activation) ->
    switch activation
      when ACTIVE then 'is-active'
      when INACTIVE then ''
  ###
  To control arrowIcon direction
  @param expansion [enum] COLLAPSED, EXPANDED
  ###
  @getExpansion: (expansion) ->
    switch expansion
      when COLLAPSED then 'fa fa-angle-down'
      when EXPANDED then 'fa fa-angle-up'
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
To abstract state for menu item, which is so-called Node
###
class NodeState
  ###
  To construct an instance of NodeState
  @param id [string] node name or subnode name
  @param content [object<dict>] node content
  @param hasFather [boolean/string] node father existence or father id
  ###
  constructor: (id, content, hasFather) ->
    @id = id
    @hasChildren = content.subnodes!=undefined
    @hasFather = hasFather
    @expansion = if @hasChildren then COLLAPSED else undefined
    @activation = INACTIVE
  ###
  To change the state according to two state keys
  @param states [object<dict>] state of nodes
  @param activatedKey [enum] id of the node which is of activation state
  @param expandedKey [enum] id of the node which is of expansion state
  ###
  changeState: (states, activatedKey, expandedKey) ->

    AK = activatedKey
    EK = expandedKey
    if @expansion != undefined
      @expansion = if @expansion == COLLAPSED then EXPANDED else COLLAPSED
    else
      states[activatedKey].activation = INACTIVE if activatedKey != null
      @activation = ACTIVE
      AK = @id
      if @hasFather
        states[@hasFather].expansion = EXPANDED
        EK = @hasFather
    keys =
      activatedKey: AK
      expandedKey: EK


###
To define a sidebar model
@extend Model
###
class Sidebar extends Model

  ###
  To construct sidebar model
  ###
  constructor: (@rawData) ->
    @initStates()
  ###
  To initilize the state of nodes, subnodes and turn them into a flat data structure
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
    @expandedKey = null
    @activatedKey = null

  ###
  To set states according to their keys
  @param nodeId [string] node id or subnode id
  ###
  setStates: (nodeId) ->
    nodeId = if nodeId!=undefined and nodeId!='' then nodeId else (@activatedKey or (_.keys @states)[0])
    keys = @states[nodeId].changeState @states, @activatedKey, @expandedKey
    @expandedKey = keys.expandedKey
    @activatedKey = keys.activatedKey
  ###
  To sort all function into one single function
  @param nodeId [string] node id or subnode id
  ###
  goto: (nodeId) ->
    @setStates nodeId
###
To define sidebar directive
@extend Directive
###
class SidebarDirective extends Directive
  ###
  To construct an instance of SidebarDirective
  @param params [Dict] parameters of angular directive
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? SidebarCssManager
    asideParams =
      templateUrl: directiveDir + 'sidebar.html'
      scope:
        activeItem: "="
    _.extend params, asideParams
    super params, Sidebar, cssKlass
  ###
  To initialize link function of table directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr

    scope.$watch () ->
      scope.activeItem
    , (nV, oV) ->
      scope.setActiveItem nV
    ###
    To set ACTIVE state to node or subnode according to activeItem
    @param item [string] node name or subnode name
    ###
    scope.setActiveItem = (item) ->
      scope.activeItem = item
      scope.model.setStates scope.activeItem



this.SidebarDirective = SidebarDirective

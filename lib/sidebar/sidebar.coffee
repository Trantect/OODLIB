directiveDir = 'lib/sidebar/'

ACTIVE = 0
INACTIVE = 1

COLLAPSED = 0
EXPANDED = 1

###
To merge

###
merge = (_L) ->
  v = {}
  _.each _L, (_item) ->
    _.extend v, _item
  v

class SidebarCssManager
  @getState: (activation) ->
    switch activation
      when ACTIVE then 'is-active'
      when INACTIVE then ''

  @getExpansion: (expansion) ->
    switch expansion
      when COLLAPSED then 'fa fa-angle-down'
      when EXPANDED then 'fa fa-angle-up'
      else ''

  @expanded: (expansion) ->
    switch expansion
      when COLLAPSED then false
      when EXPANDED then true
      else ''



class NodeState
  constructor: (id, content, hasFather) ->
    @id = id
    @hasChildren = content.subnodes!=undefined
    @hasFather = hasFather
    @expansion = if @hasChildren then COLLAPSED else undefined
    @activation = INACTIVE

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
    console.log "============state changed============="
    keys =
      activatedKey: AK
      expandedKey: EK


###
To define a Sidebar Model
@extend Model
###
class Sidebar extends Model
  ###
  To construct an instance of Sidebar
  @param rawData[object] to get data from page
  ###
  constructor: (@rawData) ->
    @initStates()

  ###
  To init a Sidebar use rawdata
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

  ###
  setStates: (nodeId) ->
    nodeId = if nodeId!=undefined and nodeId!='' then nodeId else (@activatedKey or (_.keys @states)[0])
    console.log nodeId
    console.log "+++++++++++++++++++++++++++++++++++++++++++++++"
    console.log @states
    keys = @states[nodeId].changeState @states, @activatedKey, @expandedKey

    @expandedKey = keys.expandedKey
    @activatedKey = keys.activatedKey

#  goto: (nodeId) ->
#    @setStates nodeId

class SidebarDirective extends Directive
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

    scope.setActiveItem = (item) ->
      console.log "=========setActivity item============"
      scope.activeItem = item
#      scope.model.setStates scope.activeItem
#


this.SidebarDirective = SidebarDirective

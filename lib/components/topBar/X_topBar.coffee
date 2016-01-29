directiveDir = 'lib/components/topBar/'

ACTIVE = 0
INACTIVE = 0

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
  #TODO
  ###
  To control active style
  @param activation [enum] ACTIVE, INACTIVE
  ###
  @getState: (activation) ->


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
To abstract state for topBar item, which is so-called Node
###
class NodeState
  ###
  To construct an instance of NodeState
  @param
  @param
  @param
  ###


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
        activeItem: "="
        user: "="
    _.extend params, asideParams
    super params, TopBar, cssKlass
  ###
  To initialize link function of topBar directive
  ###
  linkFn: (scope, element, attr) ->
    super scope, element, attr
    ###
    scope.$watch () ->
      scope.activeItem
    , (nV, oV) ->
      scope.setActiveItem nV
    ###
    ###
    To set ACTIVE state to node or subnode according to activeItem
    @param item [string] node name or subnode name
    ###
#    scope.model.setStates scope.activeItem
#    scope.model.setUser scope.user
###
scope.setActiveItem = (item) ->
  scope.model.initStates()
  scope.activeItem = item
  scope.model.setStates scope.activeItem
###

this.topBarDirective = topBarDirective

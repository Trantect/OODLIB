directiveDir = 'lib/components/topBar/'

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
    @rawData = rawData

###
To define topBar directive
@extend Directive
###
class TopBarDirective extends Directive
  ###
  To construct an instance of topBarDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for topBar
  ###
  constructor: (params, cssKlass, templateHtml) ->
    params = params ? {}
    cssKlass = cssKlass ? {}
    topBarParams =
      templateUrl: directiveDir + templateHtml
      replace: true
    _.extend params, topBarParams
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
    scope.isPopupVisible = false
    scope.subToggle = false

    scope.toggleSelect = ->
      scope.isPopupVisible = !scope.isPopupVisible

    scope.subToggleSelect = ->
      scope.subToggle = !scope.subToggle

#    $(document).on 'click', (event) ->
#      isClickedElementChildOfPopup = element.find(event.target).length > 0
#      if isClickedElementChildOfPopup
#        return
#      scope.$apply ->
#        scope.isPopupVisible = false

# ---

this.TopBarDirective = TopBarDirective

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
  To toggle a topBar item
  @param nid [String] node id
  ###
  toggle: (_this) ->

    nextElement = angular.element(_this.currentTarget).next()
    if nextElement.hasClass('is-show')
      nextElement.removeClass('is-show')
    else
      angular.element("li > div.dropdown-menu").removeClass('is-show')
      nextElement.addClass('is-show')
    return false

  subToggle: (_this) ->
    nextElement = angular.element(_this.currentTarget).parent().next()
    if nextElement.hasClass('is-show')
      nextElement.removeClass('is-show')
    else
      nextElement.addClass('is-show')
    return false


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
    asideParams =
      templateUrl: directiveDir + templateHtml
      scope:
        focusItem: "="
      replace: true
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
#    scope.model.setStates scope.focusItem

this.TopBarDirective = TopBarDirective

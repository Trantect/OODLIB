directiveDir = 'lib/components/topbar/'

class Topbar extends Model
  constructor: (@rawData) ->
    @title = @rawData

class TopbarCssManager extends CssManager

class TopbarDirective extends Directive
  ###
  Construct an instance of TopbarDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for TopbarDirective
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? TopbarCssManager
    headerParams =
      templateUrl: directiveDir + 'topbar.html'
    _.extend params, headerParams
    super params, Topbar, cssKlass

this.TopbarDirective = TopbarDirective
this.TopbarCssManager = TopbarCssManager

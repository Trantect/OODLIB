directiveDir = 'lib/components/dropdownMenu/'

class DDMHeader extends Model
  constructor: (@rawData) ->
    @title = @rawData

class DDMHeaderCssManager extends CssManager

class DDMHeaderDirective extends Directive
  ###
  Construct an instance of DDMDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for DDMHeaderDirective
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass ? DDMHeaderCssManager
    headerParams =
      templateUrl: directiveDir + 'ddmHeader.html'
    _.extend params, headerParams
    super params, DDMHeader, cssKlass

this.DDMHeaderDirective = DDMHeaderDirective
this.DDMHeaderCssManager = DDMHeaderCssManager

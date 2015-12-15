directiveDir = 'lib/components/dropdownMenu/'

class DDMBodyItemContent extends Model
  constructor: (@rawData) ->
    @one = @rawData.one
    @two = @rawData.two
    @three = @rawData.three
    @four = @rawData.four

class DDMBodyItemContentDirective extends Directive
  ###
  Construct an instance of DDMDirective
  @param params [Dict] parameters of angular directive
  @param cssKlass [Class] css management class for DDMHeaderDirective
  ###
  constructor: (params, cssKlass) ->
    params = params ? {}
    cssKlass = cssKlass
    headerParams =
      templateUrl: directiveDir + 'bodyItemContent.html'
    _.extend params, headerParams
    super params, DDMBodyItemContent, cssKlass

this.DDMBodyItemContentDirective = DDMBodyItemContentDirective

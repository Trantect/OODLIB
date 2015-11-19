directiveDir = 'lib/footer/'

###
To define a footer model
@extend Model
###
class Footer extends Model
  ###
  To construct an instance of footer model
  @param data [Array<Dict>] data to be displayed in footer
  ###
  constructor: (data) ->
    @rawData = data
    @copyright = data.copyright
    @version = data.version
    @websites = data.websites
    @lenOfSites = (_.keys data.websites).length

###
To define footer css manager
###
class FooterCssManager

###
To define footer directive
@extend Directive
###
class FooterDirective extends Directive
  ###
  Construct an instance of FooterDirective
  @param params [dict] Parameters of angular directive
  ###
  constructor: (params) ->
    params = params ? {}
    footerParams =
      templateUrl: directiveDir + 'footer.html'
    _.extend params, footerParams
    super params, Footer, FooterCssManager


this.FooterDirective = FooterDirective

directiveDir = 'lib/components/footer/'

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
    defaultData =
      copyright: "EMPTY copyright"
      version: "EMPTY version"
      websites: []

    @rawData = _.extend defaultData, data
    @copyright = @rawData.copyright
    @version = @rawData.version
    @websites = @rawData.websites
    @lenOfSites = @rawData.websites.length

  ###
  To get the first value of an object
  @param o [Object]
  ###
  getLink: (o) ->
    (_.values o)[0]

  ###
  To get the first key of an object
  @param o [Object]
  ###
  getName: (o) ->
    (_.keys o)[0]


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
      replace: true
    _.extend params, footerParams
    super params, Footer, FooterCssManager


this.FooterDirective = FooterDirective

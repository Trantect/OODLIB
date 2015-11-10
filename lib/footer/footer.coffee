directiveDir = fetch()

class FooterCssManager

class Footer extends Model
  constructor: (@data) ->
    @

class FooterDirective extends Directive
  constructor: (params) ->
    params = params ? {}
    footerParams =
      templateUrl: directiveDir + 'footer.html'
    _.extend params, footerParams
    super params, Footer, FooterCssManager


this.FooterDirective = FooterDirective

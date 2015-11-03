directiveDir = 'build/footer/'


class Footer extends Model
  constructor: (@data) ->
    @

class FooterDirective extends Directive
  constructor: (params, uiConfig) ->
    params = params ? {}
    footerParams =
      templateUrl: directiveDir + 'footer.html'
    _.extend params, footerParams
    super params, Footer, new UI uiConfig


this.FooterDirective = FooterDirective

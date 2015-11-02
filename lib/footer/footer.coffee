getScriptDir = () ->
  scripts = document.getElementsByTagName("script")
  csp = scripts[scripts.length-1].src
  csp = csp.substring(0, csp.lastIndexOf('/') + 1)
  csp

directiveDir = getScriptDir()


class Footer extends Model
  constructor: (@data) ->
    @

class FooterDirective extends Directive
  constructor: (params, uiConfig) ->
    params = params ? {}
    footerParams =
      scope:
        storage: '=info'
      templateUrl: directiveDir + 'footer.html'

    _.extend params, footerParams
    super params, Footer, new UI uiConfig


this.FooterDirective = FooterDirective

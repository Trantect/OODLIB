(function() {
  var Footer, FooterCssManager, FooterDirective, directiveDir,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = fetch();

  FooterCssManager = (function() {
    function FooterCssManager() {}

    return FooterCssManager;

  })();

  Footer = (function(superClass) {
    extend(Footer, superClass);

    function Footer(data) {
      this.data = data;
      this;
    }

    return Footer;

  })(Model);

  FooterDirective = (function(superClass) {
    extend(FooterDirective, superClass);

    function FooterDirective(params) {
      var footerParams;
      params = params != null ? params : {};
      footerParams = {
        templateUrl: directiveDir + 'footer.html'
      };
      _.extend(params, footerParams);
      FooterDirective.__super__.constructor.call(this, params, Footer, FooterCssManager);
    }

    return FooterDirective;

  })(Directive);

  this.FooterDirective = FooterDirective;

}).call(this);

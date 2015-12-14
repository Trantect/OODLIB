
/*
Create an angular module called footer 
@author Phoenix Grey
 */

(function() {
  var f, lib;

  lib = angular.module("OOD_Footer", ['gettext']);

  lib.run([
    'gettextCatalog', function(gettextCatalog) {
      gettextCatalog.currentLanguage = 'zh';
      return gettextCatalog.debug = true;
    }
  ]);


  /*
  Expose footer to Browser as a global object
  @author Phoenix Grey
   */

  f = new FooterDirective();

  DirectiveSchool.register(lib, 'cfooter', f);

}).call(this);

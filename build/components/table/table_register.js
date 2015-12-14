
/*
Create an angular module called OOD_Table
@author Phoenix Grey
 */

(function() {
  var d, lib;

  lib = angular.module("OOD_Table", ['gettext']);

  lib.run([
    'gettextCatalog', function(gettextCatalog) {
      gettextCatalog.currentLanguage = 'zh';
      return gettextCatalog.debug = true;
    }
  ]);


  /*
  Expose OOD to Browser as a global object
  @author Phoenix Grey
   */

  d = new TableDirective();

  DirectiveSchool.register(lib, 'ctable', d);

}).call(this);

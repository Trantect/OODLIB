
/*
Create an angular module called OOD_Sidebar
@author Phoenix Grey
 */

(function() {
  var a, lib;

  lib = angular.module("OOD_Sidebar", ['gettext']);

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

  a = new SidebarDirective();

  DirectiveSchool.register(lib, 'csidebar', a);

}).call(this);

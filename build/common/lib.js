
/*
Create an angular module called OODLIB
@author Phoenix Grey
 */

(function() {
  var d, f, lib;

  lib = angular.module("OODLib", []);


  /*
  Expose OOD to Browser as a global object
  @author Phoenix Grey
   */

  this.OOD = lib;

  d = new TableDirective();

  DirectiveSchool.register(OOD, 'ctable', d);

  f = new FooterDirective();

  DirectiveSchool.register(OOD, 'cfooter', f);

}).call(this);

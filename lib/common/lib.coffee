###
Create an angular module called OODLIB
@author Phoenix Grey
###
lib = angular.module "OODLib", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###
this.OOD = lib


d = new TableDirective()

DirectiveSchool.register OOD, 'ctable', d

f = new FooterDirective()
DirectiveSchool.register OOD, 'cfooter', f

a = new AsideDirective()
DirectiveSchool.register OOD, 'caside', a

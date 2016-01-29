###
Create an angular module called OOD_topBar
@author Edison Su
###
lib = angular.module "OOD_topBar", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
#gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Edison Su
###

a = new topBarDirective()
DirectiveSchool.register lib, 'ctopbar', a

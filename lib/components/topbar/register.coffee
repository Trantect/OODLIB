###
Create an angular module called OOD_Table
@author Phoenix Grey
###
lib = angular.module "OOD_topbar", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  #gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###

d = new TopbarDirective()
DirectiveSchool.register lib, 'ctopbar', d

###
Create an angular module called OOD_Table
@author Phoenix Grey
###
lib = angular.module "OOD_table", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###

d = new TableDirective()
DirectiveSchool.register lib, 'ctable', d



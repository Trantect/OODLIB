###
Create an angular module called OOD_Table
@author Phoenix Grey
###
lib = angular.module "OOD_dropdownMenu", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###

d = new DDMHeaderDirective()
DirectiveSchool.register lib, 'ddmHeader', d



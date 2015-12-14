###
Create an angular module called footer 
@author Phoenix Grey
###
lib = angular.module "OOD_Footer", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  gettextCatalog.debug = true
]

###
Expose footer to Browser as a global object
@author Phoenix Grey
###

f = new FooterDirective()
DirectiveSchool.register lib, 'cfooter', f


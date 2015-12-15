###
Create an angular module called OOD_Sidebar
@author Phoenix Grey
###
lib = angular.module "OOD_sidebar", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
  gettextCatalog.debug = true
]

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###

a = new SidebarDirective()
DirectiveSchool.register lib, 'csidebar', a

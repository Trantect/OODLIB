###
Create an angular module called OOD_Sidebar
@author Phoenix Grey
###
lib = angular.module "OOD_sidebar", ['gettext']

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###

a = new SidebarDirective()
DirectiveSchool.register lib, 'csidebar', a

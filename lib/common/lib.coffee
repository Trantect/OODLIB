###
Create an angular module called OODLIB
@author Phoenix Grey
###
lib = angular.module "OODLib", []

###
Expose OOD to Browser as a global object
@author Phoenix Grey
###
this.OOD = lib

###
To define hardware table css manager
@extend TableCssManager
###
class HardwareTableCss extends TableCssManager
  @brief: (item) ->
    styleclass = ""
    if item.columnData.pcType == '其他'
      styleclass = "warning"
    if item.columnData.pcType == '--'
      styleclass = "danger"
    styleclass

d = new TableDirective {}, HardwareTableCss

DirectiveSchool.register OOD, 'ctable', d

f = new FooterDirective()
DirectiveSchool.register OOD, 'cfooter', f



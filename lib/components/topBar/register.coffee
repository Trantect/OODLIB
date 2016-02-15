###
Create an angular module called OOD_topBar
@author Edison Su
###
lib = angular.module "OOD_topBar", ['gettext']
lib.run ['gettextCatalog', (gettextCatalog) ->
  gettextCatalog.currentLanguage = 'zh'
#gettextCatalog.debug = true
]

#lib.animation '.dropdown-menu', () ->
#  console.log 'aaaaaaaaaaaaaaaa'
#  IS_SHOW = 'is-show'
#  return {
#    beforeAddClass: (element, className, done) ->
#      console.log '1111111111'
#      if className is IS_SHOW
#        element.slideUp(done)
#
#    removeClass: (element, className, done) ->
#      console.log '222222222222222'
#      if className is IS_SHOW
#        element.hide().slideDown(done)
#  }

###
Expose OOD to Browser as a global object
@author Edison Su
###
topBarObj =
  ctopbarMultiCenter: 'topBarMultiCenter.html'
  ctopbarServiceStatus: 'topBarServiceStatus.html'
  ctopbarNormal: 'topBarNormal.html'

_.each topBarObj, (v, k) ->
  a = new TopBarDirective(undefined, undefined, v)
  DirectiveSchool.register lib, k, a
